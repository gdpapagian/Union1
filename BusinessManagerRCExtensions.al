pageextension 50001 "Data Upgrade Center _GP" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Sections)
        {
            group("Fortune Data Upgrade")
            {
                action("Company Mapping")
                {
                    RunObject = page "Company Mapping Page";
                    ApplicationArea = All;
                }

                action("Detiailed Vendor Ledger Entries")
                {
                    RunObject = page "DVLE Page";
                    ApplicationArea = All;
                }
                action("Detiailed Cust. Ledger Entries")
                {
                    RunObject = page "DCLE Page";
                    ApplicationArea = All;
                }

                action("Create Companies")
                {
                    RunObject = report "CreateCompaniesReport";
                    ApplicationArea = All;
                }

                action("Fix Entry Dimensions")
                {
                    RunObject = report "Fix Entry Dimensions";
                    ApplicationArea = All;
                }

                action("Fix VAT Entry Dimensions")
                {
                    RunObject = report "Fix VAT Entry Dimensions";
                    ApplicationArea = All;
                }

                action("Fix Document Dimensions")
                {
                    RunObject = report "Fix Document Dimensions";
                    ApplicationArea = All;
                }

                action("Fix G/L Budget Entry Dimensions")
                {
                    RunObject = report "Fix G/L Budget Entry Dim";
                    ApplicationArea = All;
                }

                action("Fix Default Dimensions")
                {
                    RunObject = page "Default Dimensions GP";
                    ApplicationArea = All;
                }



                action("Fix Detailed LE Dimensions")
                {
                    RunObject = report "Fix Detailed LE Dimensions";
                    ApplicationArea = All;
                }
                action("Fix Company Pictures")
                {
                    RunObject = report "Fix Company Pictures";
                    ApplicationArea = All;
                }

            }
        }
    }
}