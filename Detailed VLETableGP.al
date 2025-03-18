table 50001 DVLETable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "EntityValue"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "BusUnitValue"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}