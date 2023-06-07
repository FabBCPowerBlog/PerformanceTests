codeunit 50101 "CAGPT_GeneralJournalMgt"
{
    procedure CreateGenJnlFromStdJnlMultipleTimes(JnlTemplateName: Code[10]; JnlBatchName: Code[10]; StdGenJnlCode: Code[10]; Qty: Integer)
    var
        StdGenJnl: Record "Standard General Journal";
        i: Integer;
    begin
        StdGenJnl.Get(JnlTemplateName, StdGenJnlCode);
        for i := 1 to Qty do
            StdGenJnl.CreateGenJnlFromStdJnl(StdGenJnl, JnlBatchName);
    end;

    procedure PostGeneralJournal(JnlTemplateName: Code[10]; JnlBatchName: Code[10])
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
    begin
        GenJnlLine.Setrange("Journal Template Name", JnlTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JnlBatchName);
        GenJnlLine.FindFirst();
        GenJnlPostBatch.Run(GenJnlLine);
    end;
}
