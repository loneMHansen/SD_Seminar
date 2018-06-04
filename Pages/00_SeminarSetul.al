page 123456700 "Seminar Setup"
{
    PageType = Card;
    SourceTable = "Seminar Setup";

    InsertAllowed=false;
    DeleteAllowed=false;
    UsageCategory=Administration;

    layout
    {
        area(content)
        {
            group(GroupName)
            {
                Caption='Numbering';

                field("Seminar Nos.";"Seminar Nos.")
                {
                    
                }
                field("Seminar Registration Nos.";"Seminar Registration Nos.") {

                }
                field("Posted Seminar Reg. Nos.";"Posted Seminar Reg. Nos.") {

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction();
                begin
                end;
            }
        }
    }
    
    trigger OnOpenPage();
    var
    
    begin
        if not Get then begin
            Init;
            Insert;
        end;
    end;
    var
        myInt : Integer;
}