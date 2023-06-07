permissionset 50100 "CAGPT_Admin"
{
    Assignable = true;
    Caption = 'CAGPT_Admin', MaxLength = 30;
    Permissions =
        table "CAGPT_Test Template" = X,
        tabledata "CAGPT_Test Template" = RMID,
        codeunit "CAGPT_Post Sales Inv. from JQE" = X,
        codeunit "CAGPT_Sales Document Mgt" = X,
        codeunit CAGPT_TestLaunchMgt = X,
        codeunit "CAGPT_Sales Inv. Post. Test" = X,
        page "CAGPT_Test Templates" = X,
        table "CAGPT_Test Template Parameter" = X,
        tabledata "CAGPT_Test Template Parameter" = RMID,
        codeunit "CAGPT_Apply GL Entr. from JQE" = X,
        codeunit "CAGPT_Gen. Jnl. Test" = X,
        codeunit CAGPT_GeneralJournalMgt = X,
        page "CAGPT_Test Templ. Parameters" = X;
}
