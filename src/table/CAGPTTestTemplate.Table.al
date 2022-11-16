table 50140 "CAGPT_Test Template"
{
    Caption = 'CAGPT_Test Template';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Sales Document Type From"; enum "Sales Document Type From")
        {
            Caption = 'Sales Document Type From';
        }
        field(3; "From Document No."; Code[20])
        {
            Caption = 'From Document No.';
        }
        field(4; "Document Count"; Integer)
        {
            Caption = 'Document Count';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
