codeunit 50141 "CAGPT_TestLaunchMgt"
{
    procedure LaunchTest(TestTemplate: Record "CAGPT_Test Template")
    var
        StrMenuString: Text;
        StrMenuAnswer: Integer;
    begin
        OnMakeTestLaunchMenu(StrMenuString);
        StrMenuAnswer := StrMenu(StrMenuString);
        if StrMenuAnswer <> 0 then
            OnTestLaunch(SelectStr(StrMenuAnswer, StrMenuString), TestTemplate);
    end;

    procedure AddStringToStrMenuString(var StrMenuString: Text; StringToAdd: Text)
    var
        StrMenuStringLbl: Label '%1,%2', Locked = true;
    begin
        if StrMenuString = '' then
            StrMenuString := StringToAdd
        else
            StrMenuString := StrSubstNo(StrMenuStringLbl, StrMenuString, StringToAdd);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnMakeTestLaunchMenu(var StrMenuString: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTestLaunch(TestCode: Text; TestTemplate: Record "CAGPT_Test Template")
    begin
    end;
}
