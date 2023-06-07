codeunit 50148 "CAGPT_Apply GL Entr. from JQE"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        ApplyGLEntries(CopyStr(Rec."Parameter String", 1, 20));
    end;

    procedure ApplyGLEntries(GLAccountNo: Code[20])
    var
        GLEntryAppl: Codeunit "CAGPC_G/L Entry Application";
    begin
        GLEntryAppl.PostAllApplications(GLAccountNo, false);
    end;
}
