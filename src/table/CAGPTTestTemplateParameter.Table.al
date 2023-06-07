table 50141 "CAGPT_Test Template Parameter"
{
    Caption = 'Test Template Parameter';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Test Template Code"; Code[20])
        {
            Caption = 'Test Template Code';
            NotBlank = true;
        }
        field(2; "Test Template Version"; Integer)
        {
            Caption = 'Version';
            NotBlank = true;
        }
        field(3; Code; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(4; "Value"; Text[250])
        {
            Caption = 'Value';
        }
    }
    keys
    {
        key(PK; "Test Template Code", "Test Template Version", "Code")
        {
            Clustered = true;
        }
    }

    procedure ApplyFilterFromTestTemplate(TestTemplate: Record "CAGPT_Test Template")
    begin
        Rec.Reset();
        Rec.SetRange("Test Template Code", TestTemplate.Code);
        Rec.SetRange("Test Template Version", TestTemplate.Version);
    end;
}
