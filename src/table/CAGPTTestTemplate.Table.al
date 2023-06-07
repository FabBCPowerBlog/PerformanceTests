table 50140 "CAGPT_Test Template"
{
    Caption = 'CAGPT_Test Template';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Version; Integer)
        {
            Caption = 'Version';
            NotBlank = true;
        }
        field(4; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
    }
    keys
    {
        key(PK; "Code", "Version")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        TestTemplateParameter: Record "CAGPT_Test Template Parameter";
    begin
        TestTemplateParameter.ApplyFilterFromTestTemplate(Rec);
        TestTemplateParameter.DeleteAll(true);
    end;

    procedure ShowParameters()
    var
        TestTemplParameter: Record "CAGPT_Test Template Parameter";
        TestTemplParameters: Page "CAGPT_Test Templ. Parameters";
    begin
        TestTemplParameter.ApplyFilterFromTestTemplate(Rec);
        TestTemplParameters.SetTableView(TestTemplParameter);
        TestTemplParameters.RunModal();
    end;

    procedure GetParameterValue(ParameterCode: Code[20]): Text[250]
    var
        TestTemplParameter: Record "CAGPT_Test Template Parameter";
    begin
        TestTemplParameter.Get(Rec.Code, Rec.Version, ParameterCode);
        if TestTemplParameter.Value = '' then
            error('A value should be set for %1 parameter.', ParameterCode);
        exit(TestTemplParameter.Value);
    end;

    procedure GetParameterValueAsCode10(ParameterCode: Code[20]): Code[10]
    begin
        exit(CopyStr(GetParameterValue(ParameterCode), 1, 10));
    end;

    procedure GetParameterValueAsCode20(ParameterCode: Code[20]): Code[20]
    begin
        exit(CopyStr(GetParameterValue(ParameterCode), 1, 20));
    end;
}
