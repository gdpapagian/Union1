table 50000 CompanyMappingTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Entity,BusUnit,Other';
            OptionMembers = "ENTITY","BUSUNIT","OTHER";
        }
        field(2; "Old Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation =
                if ("Line Type" = CONST(ENTITY)) "Dimension Value".Code where("Dimension Code" = CONST('ENTITY'))
            else if ("Line Type" = CONST(BUSUNIT)) "Dimension Value".Code where("Dimension Code" = CONST('BUSUNIT'));
        }
        field(3; "ShippingCompany Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Name"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Company Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Ship-Owning,Management,Holding';
            OptionMembers = "Ship-Owning",Management,Holding;
        }
        field(6; "Vessel Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Short Name"; Text[5])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Line Type", "Old Code")
        {
            Clustered = true;
        }
    }
}