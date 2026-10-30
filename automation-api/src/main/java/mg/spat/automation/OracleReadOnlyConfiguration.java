package mg.spat.automation;

import javax.sql.DataSource;
import java.util.Properties;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
@ConditionalOnProperty(name = "spat.readonly.enabled", havingValue = "true")
public class OracleReadOnlyConfiguration {
    @Bean
    DataSource spatReadOnlyDataSource(
            @Value("${spring.datasource.url}") String url,
            @Value("${spring.datasource.username}") String username,
            @Value("${spring.datasource.password}") String password,
            @Value("${spring.datasource.driver-class-name:oracle.jdbc.OracleDriver}") String driver) {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(driver);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        Properties connectionProperties = new Properties();
        connectionProperties.setProperty("oracle.net.CONNECT_TIMEOUT", "5000");
        connectionProperties.setProperty("oracle.net.OUTBOUND_CONNECT_TIMEOUT", "10000");
        connectionProperties.setProperty("oracle.jdbc.ReadTimeout", "20000");
        dataSource.setConnectionProperties(connectionProperties);
        return dataSource;
    }

    @Bean
    JdbcTemplate spatJdbcTemplate(DataSource spatReadOnlyDataSource) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(spatReadOnlyDataSource);
        jdbcTemplate.setQueryTimeout(15);
        return jdbcTemplate;
    }

    @Bean
    PlatformTransactionManager transactionManager(DataSource spatReadOnlyDataSource) {
        return new DataSourceTransactionManager(spatReadOnlyDataSource);
    }
}
