codeunit 50141 "CAGPT_TestLaunchMgt"
{
    procedure CreateNewTestTemplate()
    var
        TestTemplate: Record "CAGPT_Test Template";
        StrMenuString: Text;
        StrMenuAnswer: Integer;
        NextVersionNo: Integer;
        SelectedTestCode: Code[20];
        TestCodeList: List of [Code[20]];
    begin
        OnMakeCreateNewTestTemplateMenu(TestCodeList);
        StrMenuAnswer := StrMenu(MakeStrMenuStringFromTestCodeList(TestCodeList));
        if StrMenuAnswer <> 0 then begin
            SelectedTestCode := CopyStr(SelectStr(StrMenuAnswer, StrMenuString), 1, 20);

            TestTemplate.SetRange(Code, SelectedTestCode);
            if TestTemplate.FindLast() then
                NextVersionNo := TestTemplate.Version + 1
            else
                NextVersionNo := 1;

            TestTemplate.Init();
            TestTemplate.Code := SelectedTestCode;
            TestTemplate.Version := NextVersionNo;
            TestTemplate.Insert(true);
        end;
    end;

    procedure LaunchTest(TestTemplate: Record "CAGPT_Test Template")
    begin
        if not Confirm('Do you wish to launch the test ?', false) then
            exit;

        OnTestLaunch(TestTemplate);
    end;

    procedure MakeStrMenuStringFromTestCodeList(TestCodeList: List of [Code[20]]): Text
    var
        TestCode: Code[20];
        StrMenuString: Text;
        StrMenuStringLbl: Label '%1,%2', Locked = true;
    begin
        foreach TestCode in TestCodeList do
            if StrMenuString = '' then
                StrMenuString := TestCode
            else
                StrMenuString := StrSubstNo(StrMenuStringLbl, StrMenuString, TestCode);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnMakeCreateNewTestTemplateMenu(var TestCodeList: List of [Code[20]])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTestLaunch(TestTemplate: Record "CAGPT_Test Template")
    begin
    end;
}
