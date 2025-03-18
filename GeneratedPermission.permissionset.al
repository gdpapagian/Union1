permissionset 50000 GeneratedPermission
{
    Assignable = true;
    Permissions = tabledata CompanyMappingTable=RIMD,
        tabledata DCLETable=RIMD,
        tabledata DVLETable=RIMD,
        table CompanyMappingTable=X,
        table DCLETable=X,
        table DVLETable=X,
        report CreateCompaniesReport=X,
        report "Fix Company Pictures"=X,
        report "Fix Detailed LE Dimensions"=X,
        report "Fix Document Dimensions"=X,
        report "Fix Entry Dimensions"=X,
        report "Fix G/L Budget Entry Dim"=X,
        report "Fix VAT Entry Dimensions"=X,
        codeunit DimUtilCU_GP=X,
        page "Company Mapping Page"=X,
        page "DCLE Page"=X,
        page "Default Dimensions GP"=X,
        page "DVLE Page"=X;
}