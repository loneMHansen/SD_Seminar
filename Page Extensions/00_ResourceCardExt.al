pageextension 123456700 "CDO_ResourceCardExt" extends "Resource Card"
{
    layout
    {
        addlast(General) {
            field("CSD_Resource Type";"CSD_Resource Type") {

            }
            field("CSD_Quantity Per Day";"CSD_Quantity Per Day") {

            }
        }
        addafter("Personal Data") {
            group("Room") {
                Visible = ShowMaxfield;
                field("CSD_Maximum Participants";"CSD_Maximum Participants") {

                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    
    trigger OnOpenPage();
    begin
        ShowMaxField := (Type = Type::Machine); 
        CurrPage.Update(false);        
    end;
    var
        [InDataSet]
        ShowMaxField: Boolean;
}