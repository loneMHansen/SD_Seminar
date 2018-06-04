table 123456701 Seminar
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10;"No.";Code[20])
        {
           Caption='No.';
           trigger OnValidate();
           var
               NoSeries : Record "No. Series";
           begin
               if "No." <> xRec."No." then begin
                   SeminarSetup.Get;
                   NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                   "No. Series" := '';
               end;
           end;
        }
        field(20;Name;Text[50])
        {
            Caption='Name';
            trigger OnValidate();
            var
                
            begin
                if Name <> xRec.Name then begin
                    if "Search Name" = UpperCase(xRec.Name) then
                        "Search Name" := UpperCase(Name);
                end;

            end;
        }
        field(30;"Seminar Duration";Decimal)
        {
            Caption='Seminar duration';
            DecimalPlaces=0:1;
        }
        field(40;"Minimum Participants";Integer)
        {
            Caption='Minimum participants';
        }
        field(50;"Maximum Participants";Integer)
        {
            Caption='Maximum participants';
        }
        field(60;"Search Name";Code[50])
        {
            Caption='Search name';
        }
        field(70;Blocked;Boolean)
        {
            Caption='Blocked';
        }
        field(80;"Last Date Modified";Date)
        {
            Caption='Last Date Modified';
            Editable=false;
        }
        field(90;Comment;Boolean)
        {
            Caption='Comment';
            Editable=false;
//            FieldClass=FlowField;
//            CalcFormula=exist("Seminar Comment Line" where ("Table Name"=filter("Seminar"),"No."=Field("No.")));
        }
        field(100;"Seminar Price";Decimal)
        {
            Caption='Seminar Price';
            AutoFormatType=1;
        }
        field(110;"Gen. Prod. Posting Group";Code[10])
        {
            Caption='Gen. Prod. Posting Group';
            TableRelation="Gen. Product Posting Group".Code;
            trigger OnValidate();
            var
                
            begin
                GenProdPostGroup.Get("Gen. Prod. Posting Group");
                if GenProdPostGroup.ValidateVatProdPostingGroup(GenProdPostGroup,"Gen. Prod. Posting Group") then begin
                    "VAT Prod. Posting Group":= GenProdPostGroup."Def. VAT Prod. Posting Group";
                end;
            end;
        }
        field(120;"VAT Prod. Posting Group";Code[10])
        {
            Caption='VAT Prod. Posting Group';
            TableRelation="VAT Product Posting Group".Code;
        }
        field(130;"No. Series";Code[10])
        {
            Caption='No. Series';
            Editable=false;
            TableRelation="No. Series".Code;
        }
    }

    keys
    {
        key(PK;"No.")
        {
            Clustered = true;
        }
        key(Key1;"Search Name")
        {
            
        }
    }
    
    var
        SeminarSetup: Record "Seminar Setup";
        //CommentLine: Record "Seminar Comment line";
        Seminar: Record Seminar;
        GenProdPostGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert();
    begin
        SeminarSetup.Get;
        if "No." = '' then 
            "No." := NoSeriesMgt.GetNextNo(SeminarSetup."Seminar Nos.",WorkDate,true);
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := WorkDate;
    end;

    trigger OnDelete();
    begin
//        CommentLine.setrange();
//        if CommentLine.findset then
//            CommentLine.DeleteAll;
    end;

    trigger OnRename();
    begin
        "Last Date Modified" := WorkDate;
    end;
    procedure AssistEdit():Boolean;
    var
        myInt : Integer;
    begin
        with Seminar do begin
            Seminar := rec;
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.",xRec."No. Series","No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                rec := Seminar;
                exit(true);
            end;                
        end;
    end;
    
}