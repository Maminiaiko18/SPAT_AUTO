param(
    [string]$WildFlyHome = 'C:\wildfy-officiel\wildfly-10.0.0.Final',
    [string]$NetBeansHome = 'C:\Program Files\NetBeans-17\netbeans',
    [string]$JavaHome = 'C:\Program Files\Eclipse Adoptium\jdk-8.0.372.7-hotspot'
)

$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$buildTempRoot = Join-Path $repoRoot 'automation-api\target\build-tmp'
New-Item -ItemType Directory -Path $buildTempRoot -Force | Out-Null
$env:TEMP = $buildTempRoot
$env:TMP = $buildTempRoot
$javaExe = Join-Path $JavaHome 'bin\java.exe'
$javacExe = Join-Path $JavaHome 'bin\javac.exe'
if (-not (Test-Path -LiteralPath $javaExe) -or -not (Test-Path -LiteralPath $javacExe)) {
    throw "JDK de compilation introuvable : $JavaHome"
}
$env:JAVA_HOME = $JavaHome
$env:PATH = "$JavaHome\bin;$env:PATH"
$ant = Join-Path $NetBeansHome 'extide\ant\bin\ant.bat'
$copyLibs = Join-Path $NetBeansHome 'java\ant\extra\org-netbeans-modules-java-j2seproject-copylibstask.jar'
$wildflyHome = (Resolve-Path -LiteralPath $WildFlyHome).Path
$deploymentPath = Join-Path $wildflyHome 'standalone\deployments\spat.war'
$ejbJar = Join-Path $repoRoot 'gallois-ejb\dist\gallois-ejb.jar'
$warPath = Join-Path $repoRoot 'gallois-war\dist\gallois-war.war'
$antUserPropertiesFile = Join-Path $repoRoot 'automation-api\target\netbeans-build.properties'

if (-not (Test-Path -LiteralPath (Split-Path -Parent $antUserPropertiesFile))) {
    New-Item -ItemType Directory -Path (Split-Path -Parent $antUserPropertiesFile) -Force | Out-Null
}
if (-not (Test-Path -LiteralPath $antUserPropertiesFile)) {
    [IO.File]::WriteAllText($antUserPropertiesFile, '', (New-Object System.Text.UTF8Encoding($false)))
}

foreach ($path in @($ant, $copyLibs, $deploymentPath)) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required build input not found: $path"
    }
}

function Invoke-NetBeansAnt([string]$ProjectBuild, [string]$Target, [string]$PropertyFile = $null) {
    if ($PropertyFile) {
        & $ant -f $ProjectBuild -propertyfile $PropertyFile "-Duser.properties.file=$antUserPropertiesFile" $Target
    } else {
        & $ant -f $ProjectBuild "-Duser.properties.file=$antUserPropertiesFile" "-Dlibs.CopyLibs.classpath=$copyLibs" $Target
    }
    if ($LASTEXITCODE -ne 0) {
        throw "Ant failed for $ProjectBuild ($Target), exit code $LASTEXITCODE"
    }
}

if (-not (Test-Path -LiteralPath $warPath)) {
    throw "WAR package was not created: $warPath"
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
$tempRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$stage = Join-Path $tempRoot "spat-war-build-$([guid]::NewGuid().ToString('N'))"
$assembled = Join-Path $stage 'assembled.war'
$expanded = Join-Path $stage 'expanded'
$extractedRuntimeLibDir = Join-Path $stage 'runtime-libs'
$ejbBuildProperties = Join-Path $stage 'gallois-ejb-build.properties'
$buildProperties = Join-Path $stage 'spat-war-build.properties'
$libDestination = Join-Path $expanded 'WEB-INF\lib'
New-Item -ItemType Directory -Path $stage | Out-Null

try {
    if (Test-Path -LiteralPath $deploymentPath -PathType Container) {
        $runtimeLibDir = Join-Path $deploymentPath 'WEB-INF\lib'
    } else {
        New-Item -ItemType Directory -Path $extractedRuntimeLibDir | Out-Null
        $deployedArchive = [IO.Compression.ZipFile]::OpenRead($deploymentPath)
        try {
            $libraryEntries = @($deployedArchive.Entries | Where-Object {
                $_.FullName -match '^WEB-INF/lib/[^/]+\.jar$'
            })
            foreach ($entry in $libraryEntries) {
                $destination = Join-Path $extractedRuntimeLibDir ([IO.Path]::GetFileName($entry.FullName))
                $sourceStream = $entry.Open()
                try {
                    $destinationStream = [IO.File]::Create($destination)
                    try { $sourceStream.CopyTo($destinationStream) } finally { $destinationStream.Dispose() }
                } finally {
                    $sourceStream.Dispose()
                }
            }
        } finally {
            $deployedArchive.Dispose()
        }
        $runtimeLibDir = $extractedRuntimeLibDir
    }

    if (-not (Test-Path -LiteralPath $runtimeLibDir -PathType Container)) {
        throw "Runtime library directory not found in the current SPAT deployment: $runtimeLibDir"
    }

    $runtimeJars = @(Get-ChildItem -LiteralPath $runtimeLibDir -Filter '*.jar' -File |
        Where-Object { $_.Name -ne 'gallois-ejb.jar' })
    if ($runtimeJars.Count -eq 0) {
        throw "No runtime libraries found in $runtimeLibDir"
    }

    $ejbClassPathEntries = @($runtimeJars | ForEach-Object { $_.FullName.Replace('\', '/') })
    $ejbPropertyText = "javac.classpath=$($ejbClassPathEntries -join ';')`nlibs.CopyLibs.classpath=$($copyLibs.Replace('\', '/'))`n"
    [IO.File]::WriteAllText($ejbBuildProperties, $ejbPropertyText, (New-Object System.Text.UTF8Encoding($false)))

    Push-Location $repoRoot
    try {
        Invoke-NetBeansAnt 'gallois-ejb\build.xml' 'dist' $ejbBuildProperties
    } finally {
        Pop-Location
    }

    if (-not (Test-Path -LiteralPath $ejbJar)) {
        throw "EJB package was not created: $ejbJar"
    }

    $classPathEntries = @($runtimeJars | ForEach-Object { $_.FullName.Replace('\', '/') })
    $classPathEntries += $ejbJar.Replace('\', '/')
    $propertyText = "javac.classpath=$($classPathEntries -join ';')`nlibs.CopyLibs.classpath=$($copyLibs.Replace('\', '/'))`n"
    [IO.File]::WriteAllText($buildProperties, $propertyText, (New-Object System.Text.UTF8Encoding($false)))

    Push-Location $repoRoot
    try {
        Invoke-NetBeansAnt 'gallois-war\build.xml' 'dist' $buildProperties
    } finally {
        Pop-Location
    }

    New-Item -ItemType Directory -Path $expanded | Out-Null
    [IO.Compression.ZipFile]::ExtractToDirectory($warPath, $expanded)
    New-Item -ItemType Directory -Path $libDestination -Force | Out-Null

    foreach ($jar in $runtimeJars) {
        Copy-Item -LiteralPath $jar.FullName -Destination $libDestination -Force
    }
    Copy-Item -LiteralPath $ejbJar -Destination (Join-Path $libDestination 'gallois-ejb.jar') -Force
    if (-not (Test-Path -LiteralPath (Join-Path $libDestination 'gallois-ejb.jar') -PathType Leaf)) {
        throw "The EJB library was not copied into the staging directory: $libDestination"
    }
    Write-Output "Staged libraries: $(@(Get-ChildItem -LiteralPath $libDestination -File).Count); EJB: $(Join-Path $libDestination 'gallois-ejb.jar')"

    $resourceSource = Join-Path $repoRoot 'gallois-ejb\src\java\resources'
    $classDestination = Join-Path $expanded 'WEB-INF\classes'
    foreach ($bundleName in @('text.properties', 'text_zh.properties')) {
        $bundle = Join-Path $resourceSource $bundleName
        if (-not (Test-Path -LiteralPath $bundle)) {
            throw "Required resource bundle not found: $bundle"
        }
        Copy-Item -LiteralPath $bundle -Destination $classDestination -Force
    }

    $assembledZip = [IO.Compression.ZipFile]::Open($assembled, [IO.Compression.ZipArchiveMode]::Create)
    try {
        $expandedPrefix = $expanded.TrimEnd('\') + '\'
        foreach ($file in Get-ChildItem -LiteralPath $expanded -File -Recurse) {
            $relativePath = $file.FullName.Substring($expandedPrefix.Length).Replace('\', '/')
            $entry = $assembledZip.CreateEntry($relativePath, [IO.Compression.CompressionLevel]::Optimal)
            $inputStream = [IO.File]::OpenRead($file.FullName)
            try {
                $outputStream = $entry.Open()
                try { $inputStream.CopyTo($outputStream) } finally { $outputStream.Dispose() }
            } finally {
                $inputStream.Dispose()
            }
        }
    } finally {
        $assembledZip.Dispose()
    }

    $zip = [IO.Compression.ZipFile]::OpenRead($assembled)
    try {
        $entries = @($zip.Entries | Select-Object -ExpandProperty FullName)
        if ($entries -notcontains 'WEB-INF/lib/gallois-ejb.jar') {
            $libraryEntries = @($entries | Where-Object { $_ -match '(^|/)gallois-ejb\.jar$' })
            $webInfEntries = @($entries | Where-Object { $_ -like '*WEB-INF*' } | Select-Object -First 12)
            throw "The assembled WAR is missing WEB-INF/lib/gallois-ejb.jar. Found EJB: $($libraryEntries -join ', '); WEB-INF: $($webInfEntries -join ', ')"
        }
        if (-not ($entries | Where-Object { $_ -like 'WEB-INF/lib/*.jar' })) {
            throw 'The assembled WAR contains no WEB-INF/lib JAR dependencies.'
        }
        $ejbEntry = $zip.GetEntry('WEB-INF/lib/gallois-ejb.jar')
        $ejbStream = $ejbEntry.Open()
        try {
            $ejbArchive = New-Object IO.Compression.ZipArchive($ejbStream, [IO.Compression.ZipArchiveMode]::Read, $false)
            try {
                if ($null -eq $ejbArchive.GetEntry('bean/ClassMAPTable.class')) {
                    throw 'The packaged gallois-ejb.jar is missing bean/ClassMAPTable.class.'
                }
            } finally {
                $ejbArchive.Dispose()
            }
        } finally {
            $ejbStream.Dispose()
        }
    } finally {
        $zip.Dispose()
    }

    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $rawBackup = Join-Path (Split-Path $warPath -Parent) "gallois-war-raw-$stamp.war"
    Move-Item -LiteralPath $warPath -Destination $rawBackup
    Move-Item -LiteralPath $assembled -Destination $warPath
    $count = @($runtimeJars | Where-Object { $_.Name -ne 'gallois-ejb.jar' }).Count + 1
    Write-Output "WAR built with $count runtime dependencies: $warPath"
    Write-Output "Previous raw WAR retained at: $rawBackup"
} catch {
    throw
} finally {
    $resolvedStage = [IO.Path]::GetFullPath($stage)
    if ($resolvedStage.StartsWith($tempRoot, [StringComparison]::OrdinalIgnoreCase) -and
        $resolvedStage -like (Join-Path $tempRoot 'spat-war-build-*')) {
        Remove-Item -LiteralPath $resolvedStage -Recurse -Force -ErrorAction SilentlyContinue
    }
}
