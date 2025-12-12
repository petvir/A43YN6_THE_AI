program ttt;

uses crt;

Type TTabla= array [ 1 .. 3 , 1 .. 3 ] of byte; { 0 - Åres, 1 - x, 2 - o }

var tabla : TTabla;
    max,
    ossz,
    xgyoz,
    ogyoz,
    dont,
    db : longint;
    xl : boolean;
    lepes : byte;
    member : byte;
    computer : byte;
    gamed,
    kezd : boolean;
    f : text;
    sor : string;

Procedure WriteFile;
begin
   assign ( f , 'error.txt' );
   rewrite ( f );
   Writeln ( f , sor );
   Close ( f );
end;

Function Vege ( a : TTabla; var c : byte ) : boolean;
var r : boolean;
begin
   c := 0;

   If ( a [ 1 , 1 ] <> 0 ) and ( a [ 1 , 2 ] <> 0 ) and ( a [ 1 , 3 ] <> 0 ) and
      ( a [ 2 , 1 ] <> 0 ) and ( a [ 2 , 2 ] <> 0 ) and ( a [ 2 , 3 ] <> 0 ) and
      ( a [ 3 , 1 ] <> 0 ) and ( a [ 3 , 2 ] <> 0 ) and ( a [ 3 , 3 ] <> 0 ) then
      c := 1; { dîntetlen }

   If ( ( a [ 1 , 1 ] = 1 ) and ( a [ 1 , 2 ] = 1 ) and ( a [ 1 , 3 ] = 1 ) ) or
      ( ( a [ 2 , 1 ] = 1 ) and ( a [ 2 , 2 ] = 1 ) and ( a [ 2 , 3 ] = 1 ) ) or
      ( ( a [ 3 , 1 ] = 1 ) and ( a [ 3 , 2 ] = 1 ) and ( a [ 3 , 3 ] = 1 ) ) or

      ( ( a [ 1 , 1 ] = 1 ) and ( a [ 2 , 1 ] = 1 ) and ( a [ 3 , 1 ] = 1 ) ) or
      ( ( a [ 1 , 2 ] = 1 ) and ( a [ 2 , 2 ] = 1 ) and ( a [ 3 , 2 ] = 1 ) ) or
      ( ( a [ 1 , 3 ] = 1 ) and ( a [ 2 , 3 ] = 1 ) and ( a [ 3 , 3 ] = 1 ) ) or

      ( ( a [ 1 , 1 ] = 1 ) and ( a [ 2 , 2 ] = 1 ) and ( a [ 3 , 3 ] = 1 ) ) or
      ( ( a [ 1 , 3 ] = 1 ) and ( a [ 2 , 2 ] = 1 ) and ( a [ 3 , 1 ] = 1 ) ) then
      c := 2; { x gyãz }

   If ( ( a [ 1 , 1 ] = 2 ) and ( a [ 1 , 2 ] = 2 ) and ( a [ 1 , 3 ] = 2 ) ) or
      ( ( a [ 2 , 1 ] = 2 ) and ( a [ 2 , 2 ] = 2 ) and ( a [ 2 , 3 ] = 2 ) ) or
      ( ( a [ 3 , 1 ] = 2 ) and ( a [ 3 , 2 ] = 2 ) and ( a [ 3 , 3 ] = 2 ) ) or

      ( ( a [ 1 , 1 ] = 2 ) and ( a [ 2 , 1 ] = 2 ) and ( a [ 3 , 1 ] = 2 ) ) or
      ( ( a [ 1 , 2 ] = 2 ) and ( a [ 2 , 2 ] = 2 ) and ( a [ 3 , 2 ] = 2 ) ) or
      ( ( a [ 1 , 3 ] = 2 ) and ( a [ 2 , 3 ] = 2 ) and ( a [ 3 , 3 ] = 2 ) ) or

      ( ( a [ 1 , 1 ] = 2 ) and ( a [ 2 , 2 ] = 2 ) and ( a [ 3 , 3 ] = 2 ) ) or
      ( ( a [ 1 , 3 ] = 2 ) and ( a [ 2 , 2 ] = 2 ) and ( a [ 3 , 1 ] = 2 ) ) then
      c := 3; { o gyãz }

   If c > 0 then Vege := true else vege := false;
end;


Procedure DrawTabla ( a : TTabla );
var v : byte;
    c : char;
    i , j : byte;
begin
   clrscr;
   for i := 1 to 3 do
   begin
      For j := 1 to 3 do
      begin
         case a [ i , j ] of
            0 : write ( ' ' );
            1 : write ( 'X' );
            2 : write ( 'O' );
         end;
         If j <> 3 then write ( '|' );
      end;
      Case i of
         1 : write ( ' 1|2|3');
         2 : write ( ' 4|5|6');
         3 : write ( ' 7|8|9');
      end;
      Writeln;
      If i <> 3 then Writeln ( '-+-+- -+-+-');
   end;
   Writeln;
   If Vege ( a , v ) then
      case v of
         1 : Writeln ( 'EgyezzÅnk ki egy dîntetlenben!');
         2 : case computer of
                1 : Writeln ( 'ên gyãztem! Legyen nagyobb szerencsÇd m†skor!');
                2 : begin
                       Writeln ( 'Gartul†lok gyãztÇl! Hogy csin†ltad?');
                       WriteFile;
                    end;
             end;
         3 : case computer of
                2 : Writeln ( 'ên gyãztem! Legyen nagyobb szerencsÇd m†skor!');
                1 : begin
                       Writeln ( 'Gartul†lok gyãztÇl! Hogy csin†ltad?');
                       WriteFile;
                    end;
             end;
      end
   else If xl then Writeln ( 'X lÇp') else writeln ( 'O lÇp' );
   {c := readkey;
   If c = 'v' then halt;}
end;

Procedure ClearTabla ( a :TTabla );
var  i , j : byte;
begin
   for i := 1 to 3 do
      For j := 1 to 3 do Tabla [ i , j ] := 0;
end;

Procedure backtrack ( a : TTabla; xlep : boolean; l : byte );
var i , j , k : byte;
    v : byte;
    ll : longint;
    b : boolean;
begin
   b := false;
   For i := 1 to 3 do
   begin
      for j := 1 to 3 do
      If a [ i , j ] = 0 then
      begin
         inc ( db );
         if l mod 2 = 1 then xlep := true else xlep := false;
         If xlep then a [ i , j ] := 1 else a [ i , j ] := 2;
         xl := xlep;
         {DrawTabla ( a , l , i , j );}
         If Vege ( a , v ) then
         begin
            a [ i , j ] := 0;
            ll := 1;
            If gamed and ( l > 4 ) then for k := 1 to ( 10 - l ) do ll := ll * 10;
            case v of
               1 : inc ( dont );
               2 : inc ( xgyoz , ll );
               3 : inc ( ogyoz , ll );
            end;
         end
         else
         begin
            BackTrack ( a , xlep , l + 1 );
            a [ i , j ] := 0;
         end;
         b := true;
         If b then continue;
      end;
   end;
end;

function rand ( s : string ) : string;
var i : byte;
begin
   i := random ( length ( s ) ) + 1;
   {writeln ( s , '-' , s [ i ] );}
   rand := s [ i ];
end;

Procedure lep ( s : string; id : byte );
var b : char;
begin
   b := s [ 1 ];
{   Writeln ( b , '-' , s );}
   case b of
      '1' : tabla [ 1 , 1 ] := id;
      '2' : tabla [ 1 , 2 ] := id;
      '3' : tabla [ 1 , 3 ] := id;
      '4' : tabla [ 2 , 1 ] := id;
      '5' : tabla [ 2 , 2 ] := id;
      '6' : tabla [ 2 , 3 ] := id;
      '7' : tabla [ 3 , 1 ] := id;
      '8' : tabla [ 3 , 2 ] := id;
      '9' : tabla [ 3 , 3 ] := id;
   end;
   sor := sor + b;
end;

Function ures ( s : string ) : boolean;
var r : boolean;
    b : char;
begin
   b := s [ 1 ];
   r := true;
   case b of
      '1' : If tabla [ 1 , 1 ] > 0 then r := false;
      '2' : If tabla [ 1 , 2 ] > 0 then r := false;
      '3' : If tabla [ 1 , 3 ] > 0 then r := false;
      '4' : If tabla [ 2 , 1 ] > 0 then r := false;
      '5' : If tabla [ 2 , 2 ] > 0 then r := false;
      '6' : If tabla [ 2 , 3 ] > 0 then r := false;
      '7' : If tabla [ 3 , 1 ] > 0 then r := false;
      '8' : If tabla [ 3 , 2 ] > 0 then r := false;
      '9' : If tabla [ 3 , 3 ] > 0 then r := false;
   end;
   Ures := r;
end;

Procedure Memberlep;
var c : char;
begin
   Write ( lepes , '. lÇpÇs. Te kîvetkezel! Hova lÇpsz? :');
   repeat
      c := readkey;
   until ( c in ['1','2','3','4','5','6','7','8','9'] ) and ures ( c );
   lep ( c , member );
   inc ( lepes );
   Writeln;
   Writeln ( 'LÇptÇl!');
end;

Procedure gyoze ( a : TTabla; a1 , a2 , b1 , b2 , c1 , c2 , c : byte; var b : boolean );
var s : string;
begin
   If ( ( a [ a1 , a2 ] = c ) and ( a [ b1 , b2 ] = c ) and ( a [ c1 , c2] = 0 ) ) then
   begin
      str ( ( c1 - 1 ) * 3 + c2 , s );
      lep ( s , computer );
      b := true;
   end;
   If ( ( a [ a1 , a2 ] = 0 ) and ( a [ b1 , b2 ] = c ) and ( a [ c1 , c2] = c ) ) then
   begin
      str ( ( a1 - 1 ) * 3 + a2 , s );
      lep ( s , computer );
      b := true;
   end;
   If ( ( a [ a1 , a2 ] = c ) and ( a [ b1 , b2 ] = 0 ) and ( a [ c1 , c2] = c ) ) then
   begin
      str ( ( b1 - 1 ) * 3 + b2 , s );
      lep ( s , computer );
      b := true;
   end;
end;


Procedure Computerlep;
var r : byte;
    r1 : longint;
    v : byte;
    i , j : byte;
    xl : boolean;
    s1 : string;
begin
   Writeln ( lepes , '. lÇpÇs. ên kîvetkezem! Gondolkodom...');
   case lepes of
{      1 : tabla [ 2 , 2 ] := computer;
      2 : If tabla [ 2 , 2 ] = 0 then tabla [ 2 , 2 ] := computer else
             lep ( rand ( '1379' ) ,computer );
      3 : begin
             If ( tabla [ 1 , 1 ] <> 0 ) then
                lep ( rand ( '24' ) ,computer );
             if ( tabla [ 1 , 3 ] <> 0 ) then
                lep ( rand ( '26' ) ,computer );
             if ( tabla [ 3 , 1 ] <> 0 ) then
                lep ( rand ( '48' ) ,computer );
             if ( tabla [ 3 , 3 ] <> 0 ) then
                lep ( rand ( '68' ) ,computer );
             If ( tabla [ 1 , 2 ] <> 0 ) then
                lep ( rand ( '13' ) ,computer );
             If ( tabla [ 2 , 1 ] <> 0 ) then
                lep ( rand ( '17' ) ,computer );
             If ( tabla [ 2 , 3 ] <> 0 ) then
                lep ( rand ( '39' ) ,computer );
             If ( tabla [ 3 , 2 ] <> 0 ) then
                lep ( rand ( '79' ) ,computer );
          end;}
      1..9 : begin
                r := 0;
                r1 := 0;
                xl := false;

                If not xl then gyoze ( Tabla , 1 , 1 , 1 , 2 , 1 , 3 , computer , xl );
                If not xl then gyoze ( Tabla , 2 , 1 , 2 , 2 , 2 , 3 , computer , xl );
                If not xl then gyoze ( Tabla , 3 , 1 , 3 , 2 , 3 , 3 , computer , xl );

                If not xl then gyoze ( Tabla , 1 , 1 , 2 , 1 , 3 , 1 , computer , xl );
                If not xl then gyoze ( Tabla , 1 , 2 , 2 , 2 , 3 , 2 , computer , xl );
                If not xl then gyoze ( Tabla , 1 , 3 , 2 , 3 , 3 , 3 , computer , xl );

                If not xl then gyoze ( Tabla , 1 , 1 , 2 , 2 , 3 , 3 , computer , xl );
                If not xl then gyoze ( Tabla , 1 , 3 , 2 , 2 , 3 , 1 , computer , xl );

                If not xl then gyoze ( Tabla , 1 , 1 , 1 , 2 , 1 , 3 , member , xl );
                If not xl then gyoze ( Tabla , 2 , 1 , 2 , 2 , 2 , 3 , member , xl );
                If not xl then gyoze ( Tabla , 3 , 1 , 3 , 2 , 3 , 3 , member , xl );

                If not xl then gyoze ( Tabla , 1 , 1 , 2 , 1 , 3 , 1 , member , xl );
                If not xl then gyoze ( Tabla , 1 , 2 , 2 , 2 , 3 , 2 , member , xl );
                If not xl then gyoze ( Tabla , 1 , 3 , 2 , 3 , 3 , 3 , member , xl );

                If not xl then gyoze ( Tabla , 1 , 1 , 2 , 2 , 3 , 3 , member , xl );
                If not xl then gyoze ( Tabla , 1 , 3 , 2 , 2 , 3 , 1 , member , xl );

                If not xl then
                begin
                for i := 1 to 3 do
                   For j := 1 to 3 do
                   If Tabla [ j , i ] = 0 then
                   begin
                      Tabla [ j , i ] := computer;
                      If Vege ( Tabla , v ) then
                      begin
                         If ( v = 1 ) and ( r = 0 ) then r := ( j - 1 ) * 3 + i;
                         If v = computer + 1 then r := ( j - 1 ) * 3 + i;
                      end
                      else
                      begin
                         xgyoz := 0;
                         ogyoz := 0;
                         dont := 0;
                         db := 0;
                         If computer = 1 then xl := false;
                         BackTrack ( Tabla , xl , lepes + 1 );
                         case computer of
                            1 : If ( ( xgyoz + dont ) * 100 ) div
                                   ( ogyoz + xgyoz + dont ) > r1 then
                                begin
                                   r := ( j - 1 ) * 3 + i;
                                   r1 := ( ( xgyoz + dont ) * 100 ) div
                                   ( ogyoz + xgyoz + dont );
                                end;
                            2 : If ( ( ogyoz + dont ) * 100 ) div
                                   ( ogyoz + xgyoz + dont ) > r1 then
                                begin
                                   r := ( j - 1 ) * 3 + i;
                                   r1 := ( ( ogyoz + dont ) * 100 ) div
                                   ( ogyoz + xgyoz + dont );
                                end;
                         end;
                         {Writeln ( ( j - 1 ) * 3 + i , '-X:' , xgyoz , '-O:' , ogyoz , '-D:' , dont , '-%:' , r1 );}
                      end;
                      tabla [ j , i ] := 0;
                   end;
                end;
                If not xl and ( r = 0 ) Then
                begin
                   Writeln ( 'Nincs j¢ lÇpÇslehetãsÇg!' );
                   halt;
                end;
                str ( r , s1 );
                If not xl then lep ( s1 ,computer );
             end;
   end;
   inc ( lepes );
   Writeln ( 'LÇptem!');
   {readkey;}
end;

Procedure Game;
var c : byte;
begin
   clrscr;
   cleartabla ( Tabla );
   gamed := true;
   lepes := 1;
   while not vege ( Tabla , c ) do
   begin
      DrawTabla ( Tabla );
      IF kezd then
      begin
         memberlep;
         DrawTabla ( Tabla );
         If not vege ( Tabla , c ) then computerlep;
         DrawTabla ( Tabla );
      end
      else
      begin
         computerlep;
         DrawTabla ( Tabla );
         If not vege ( Tabla , c ) then memberlep;
         DrawTabla ( Tabla );
      end
   end;
end;

procedure Options;
var c : char;
begin
   repeat
      sor := '';
      Writeln ( 'Melyikkel akarsz j†tszani (X,O) ?: ' );
      repeat
         c := Upcase ( Readkey );
      until c in ['X','O'];
      If c = 'X' then member := 1 else member := 2;
      computer := 3 - member;
      Writeln ( 'Akarsz kezdeni (I,N) ?: ' );
      repeat
         c := Upcase ( Readkey );
      until c in ['I','N'];
      If c = 'I' then kezd := true else kezd := false;
      Game;
      Writeln ( 'Akarsz mÇg j†tszani? (I,N): ');
      repeat
         c := Upcase ( Readkey );
      until c in ['I','N'];
   until c = 'N';
end;

Procedure stat;
begin
   cleartabla ( Tabla );
   xgyoz := 0;
   ogyoz := 0;
   dont := 0;
   db := 0;
   gamed := false;
   BackTrack ( Tabla , true , 1 );
   ossz := xgyoz+ogyoz+dont;
   max := 9*8*7*6*5*4*3*2*1;
   Writeln ( 'Kezdã   X gyãz: ',xgyoz, ' esetben');
   Writeln ( 'M†sodik O gyãz: ',ogyoz, ' esetben');
   Writeln ( 'dîntetlen: ',dont, ' esetben');
   Writeln ( 'ôsszesen : ',ossz,' j†tszma van');
   Writeln ( 'Kezdã esÇlye a gyãzelemre : ',( xgyoz*100 ) div ossz );
   Writeln ( 'Kezdã esÇlye a dîntetlenre: ',( dont*100 ) div ossz );
   Writeln ( 'Kezdã esÇlye a veresÇgre  : ',( ogyoz*100 ) div ossz );
end;

begin
   clrscr;
   randomize;
   Options;
end.