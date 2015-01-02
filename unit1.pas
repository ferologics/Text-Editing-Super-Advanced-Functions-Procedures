unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function prvocislo(x: integer):boolean;
var count,i:integer;
begin
   count:= 0;
   for i:= 1 to x do if (x mod i = 0) then count += 1;
   if (count = 2) then Result:= true
                  else Result:= false;
end;

procedure prvocisloDo(index:integer);
var count,i:integer;
begin
   count:= 0;
   i:= 1;
   repeat
      if prvocislo(i) then begin
                                count += 1;
                                Form1.Memo1.Lines.Add(IntToStr(count) + ': ' + IntToStr(i));
                           end;
      i += 1;
   until (count >= index);
end;

procedure prvocisloZ(x:integer;y:integer);
var count,i:integer;
begin
   count:= 0;
   i:= x;
   repeat
      if prvocislo(i) then begin
                                count += 1;
                                Form1.Memo1.Lines.Add(IntToStr(count) + ': ' + IntToStr(i));
                           end;
      i += 1;
   until (i >= y);
end;

function pocetSlov(str:string):integer;
var i,count,inWord:integer;
var ch:char;
begin
   //str += '  ';
   inWord:= 0;
   count:= 0;
   for i:= 0 to length(str) do
   begin
       ch:= str[i];
       case ch of
            'a'..'z','A'..'Z','0'..'9': if (inWord = 0) then
                                                    begin
                                                      inWord:= 1;
                                                      count += 1;
                                                    end;
                          ' ': if (inWord = 1) then inWord:= 0;
       end;
    end;
    Result:= count;
end;

function slovoNaMieste(str:string; index:integer):string;
var i,count,inWord:integer;
var word:string;
var ch:char;
begin
   str += '  ';
   inWord:= 0;
   count:= 0;
   word:= '';
   for i:= 0 to length(str) do
   begin
       ch:= str[i];
       case ord(ch) of
                              33..126: begin      //'a'..'z','A'..'Z','0'..'9' to boli krasne casy, ce ce ce re ce...
                                             if (inWord = 0) then
                                                    begin
                                                      inWord:= 1;
                                                      count += 1;
                                                    end;
                                             word += str[i];
                                        end;
                                   32: if (inWord = 1) then
                                                   begin
                                                      inWord:= 0;
                                                      if (count = index) then Result:= word
                                                                         else word:= '';
                                                    end;
       end;
   end;
end;

function vetaOdzadu(str:string):string;
var i:integer;
var vyslednyStr:string;
begin
   vyslednyStr:= '';
   for i:= pocetSlov(str) downto 1 do vyslednyStr += (slovoNaMieste(str, i) + ' ');
   Delete (vyslednyStr,length(vyslednyStr),length(vyslednyStr));
   Result:= vyslednyStr;
end;

procedure TForm1.Button1Click(Sender: TObject); // Je X prvocislo ty blbecek?
var x:integer;
begin
   x:= StrToIntDef(Form1.Edit4.Text,0);
   Form1.Memo1.Lines.Add(IntToStr(x) + ' -> ' + boolToStr(prvocislo(x)) + '   (0=nie | -1=ano)');
end;

procedure TForm1.Button2Click(Sender: TObject); // Vypis prvych X prvocisel
var x:integer;
begin
   x:= StrToIntDef(Form1.Edit4.Text,0);
   prvocisloDo(x);
end;

procedure TForm1.Button3Click(Sender: TObject); // Vypis prvocisla z intervalu (OD DO)
var x,y:integer;
begin
   x:= StrToIntDef(Form1.Edit2.Text,0);
   y:= StrToIntDef(Form1.Edit3.Text,0);
   prvocisloZ(x,y);
end;

procedure TForm1.Button4Click(Sender: TObject); // Vypis pocet slov vo vete
begin
   Form1.Memo1.Lines.Add('Pocet slov vo vete: ' + IntToStr(pocetSlov(Form1.Edit1.Text)));
end;

procedure TForm1.Button5Click(Sender: TObject); // Vypis slovo podla indexu (x) vo vete
var indexiq:integer;
begin
   indexiq:= StrToIntDef(Form1.Edit4.Text,0);
   Form1.Memo1.Lines.Add('Slovo na ' + IntToStr(indexiq) + '. mieste vo vete: ' + slovoNaMieste(Form1.Edit1.Text,indexiq));
end;

procedure TForm1.Button6Click(Sender: TObject); // Vypis vetu odzadu
begin
   Form1.Memo1.Lines.Add(vetaOdzadu(Form1.Edit1.Text));
end;

procedure TForm1.Button7Click(Sender: TObject); // CLEAR MEMO!@#$!@@!#!@#@!#$#%^&*()&^%$#@
begin
  Form1.Memo1.Clear;
end;

end.

