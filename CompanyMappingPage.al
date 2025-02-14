page 50000 "Company Mapping Page"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = CompanyMappingTable;
    Caption = 'Company Mapping';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line Type"; Rec."Line Type")
                {
                    ApplicationArea = All;
                }
                field("Old Code"; Rec."Old Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("ShippingCompanyCode"; Rec."ShippingCompany Code")
                {
                    ApplicationArea = All;
                }
                field("Company Type"; Rec."Company Type")
                {
                    ApplicationArea = All;
                }
                field("Vessel Name"; Rec."Vessel Name")
                {
                    ApplicationArea = All;
                }

                field("Short Name"; Rec."Short Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("New")
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = New;

                trigger OnAction()
                begin
                    CreateNewRecord();
                end;
            }
        }
    }

    procedure CreateNewRecord()
    begin
        // Logic to create a new record
    end;
}