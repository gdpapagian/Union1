page 50001 "Default Dimensions GP"
{

    ApplicationArea = All;
    Caption = 'Default Dimensions';
    Extensible = true;
    PageType = List;
    SourceTable = "Default Dimension";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1103200000)
            {
                field("Table ID "; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                }
                field("Value Posting"; Rec."Value Posting")
                {
                    ApplicationArea = All;
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ApplicationArea = All;
                }

                field("Multi Selection Action"; Rec."Multi Selection Action")
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
            action(FixDimensions)
            {
                Caption = 'Remove Mandatory Dimensions';
                ApplicationArea = All;
                trigger OnAction()
                var
                    defdim: Record "Default Dimension";
                    nCount: Integer;
                begin
                    defdim.SetRange("Table ID", 15);
                    defdim.SetFilter("Dimension Code", '%1|%2|%3', 'ENTITY', 'BUSUNIT', 'CONSOLCO');
                    defdim.SetRange("Value Posting", defdim."Value Posting"::"Code Mandatory");
                    nCount := defdim.Count();
                    defdim.DeleteAll(true);
                    MESSAGE('Deleted %1 mandatory dimensions in Chart of Accounts', nCount);
                end;

            }

        }
    }

    var
        GroupCategory: Text[100];
        cuUtil: Codeunit DimUtilCU_GP;

}

