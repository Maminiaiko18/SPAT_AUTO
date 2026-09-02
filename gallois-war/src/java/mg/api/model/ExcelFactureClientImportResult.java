package mg.port.api.model;

public class ExcelFactureClientImportResult {

    private FactureClientRequest factureImportExport;
    private FactureClientRequest facturePrepay;
    private FactureClientRequest factureOV;

    public FactureClientRequest getFactureImportExport() {
        return factureImportExport;
    }

    public void setFactureImportExport(
            FactureClientRequest factureImportExport) {

        this.factureImportExport = factureImportExport;
    }

    public FactureClientRequest getFacturePrepay() {
        return facturePrepay;
    }

    public void setFacturePrepay(
            FactureClientRequest facturePrepay) {

        this.facturePrepay = facturePrepay;
    }

    public FactureClientRequest getFactureOV() {
        return factureOV;
    }

    public void setFactureOV(
            FactureClientRequest factureOV) {

        this.factureOV = factureOV;
    }
}