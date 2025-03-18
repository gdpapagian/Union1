page 50003 "DCLE Page"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = DCLETable;
    Caption = 'Detailed Cust. Ledger Entries';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Entity Value"; Rec.EntityValue)
                {
                    ApplicationArea = All;
                }
                field("BusUnit Value"; Rec.BusUnitValue)
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