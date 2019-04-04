Unit Clipper;


{Short-circuit boolean expression evaluation (for StrTran)}
{$B-}


Interface


Uses SysUtils, Dialogs;


type
{$IFNDEF WIN32}
   TStrLen = Byte;
{$ELSE}
   TStrLen = Integer;
{$ENDIF}

(********JEFF'S FUNCS**********)

function GetAppCurrentDir: string;
function IncrementString(s: string): string;
procedure DateComplete(var StrLikeDate : string; const NowIfError:boolean = True) ;

(********** STRFUNCS **********)


function AllTrim(const S:String ): String;
function At(const S:String;
            const cSearchStr:String):TStrLen;
function CapFirst(const S:String): String;
function EmptyString(const S:String):Boolean;
function EmptyStr(const S:String):Boolean;
function FillStr(const S:String;xPos:TStrLen;
                 xLen:TStrLen;Ch:Char):String;
function Left(const S:String;
              xLen:TStrLen):String;
function Lower(const S:String): String;
function LTrim(const S:String): String;
function PadC(const S:String; xLen: TStrLen; const Ch: Char = ' '): String;
function PadL(const S:String; xLen: TStrLen; const Ch: Char = ' '): String;
function PadR(const S:String; xLen: TStrLen; const Ch: Char = ' '): String;
function RAt(const cSearch: String; const S:String): TStrLen;
function RealToStr(rInVal: Real; xDecimals: TStrLen): String;
function Replicate(const cRepliStr: String; xNoTimes: TStrLen): String;
function Right(const S:String; xLen: TStrLen ): String;
function RTrim(const S:String): String;
function Space(xLen: TStrLen): String;
function StrToReal(const S:String): Real;
Function StrTran(const S:String; cSearch, cRepl:String;
                 xStart,xCount:TStrLen;bMatchCase:Boolean): String;
function StrZero( liNum: LongInt; xLen: TStrLen): String;
function Stuff(const S:String; xStart, xToDel: TStrLen;
               const cInsert: String): String;
function SubStr(const S:String; xPos, xLen: TStrLen): String;
function TrailingBackSlash(const S:String): String;
function TrailingChar(const S:String; Trailer: Char): String;
function Trim(const S:String): String;
function Upper(const S:String): String;


(************ DATFUNCS ************)


function BoM( dtVar : TDateTime ): TDateTime; {- Begin-of-Month -}
function BoY( dtVar : TDateTime ): TDateTime; {- Begin-of-Year -}
function BoW( dtVar : TDateTime ): TDateTime; {- Begin-of-Week -}

{--- jeff's }
function BoQ( dtVar : TDateTime ): TDateTime; {- Begin-of-Quarter -}
function EoQ( dtVar : TDateTime ): TDateTime; {- End-of-Quarter -}


function EoM( dtVar : TDateTime ): TDateTime; {- End-of-Month -}
function EoW( dtVar : TDateTime ): TDateTime; {- End-of-Week -}
function EoY( dtVar : TDateTime ): TDateTime; {- End-of-Year -}


function DoM( dtVar : TDateTime ): Word; {- Day-of-Month -}
function Day( dtVar : TDateTime ): Word; {- Idem DoM -}
function DoW( dtVar : TDateTime ): Word; {- Day-of-Week -}
function DoY( dtVar : TDateTime ): Word; {- Day-of-Year -}


function Month( dtVar : TDateTime ): Word;
function MonthLen( dtVar : TDateTime ): Word;
function NextMonth( dtVar : TDateTime ): TDateTime;
function PrevMonth( dtVar : TDateTime ): TDateTime;


function Year( dtVar : TDateTime ): Word;
function NextYear( dtVar : TDateTime ): TDateTime;
function PrevYear( dtVar : TDateTime ): TDateTime;
function LeapYear( wYear: Word ): Boolean;
function YearLen( wYear : Word ): Word;


function WeekNr( dtVar : TDateTime ): Word;
function WeekLast( dtVar : TDateTime ): Word;
function WeekYear( dtVar : TDateTime ): Word;
function WeekDate( wYear, wWeek : Word ): TDateTime;
function FirstMonday( wYear : Word ): TDateTime;


function Easter( wYear : Word ): TDateTime;

{--- jeff's }
procedure QuickDatePick( var fdate1, fdate2: tdatetime;
  flag: string; const flag2: shortint=0);


(********** CLPFUNCS **********) 


function CDOW(Date: TDateTime) : string; 
function CMonth(Date: TDateTime) : string; 
function CToD(cDate: string) : TDateTime; 
function DToC(Date : TDateTime) : string; 
function DToS(Date : TDateTime) : string; 


function ASC(str : string) : byte; 
function DiskSpace(Drive: Byte): Longint; 
function EmptyDate(Date : TDateTime) : boolean; 
function Ferase(str: string) : boolean;
function IIFDate(c1 : boolean; ret1,ret2 : TDateTime) : TDateTime; 
function IIFInt(c1 : boolean; ret1,ret2 : integer) : integer; 
function IIFReal(c1 : boolean; ret1,ret2 : extended) : extended; 
function IIFStr(c1 : boolean; ret1,ret2 : string) : string;
function IIFVariant(c1 : boolean; ret1,ret2 : Variant) : Variant;
function IsAlpha(str: string) : boolean;
function IsDigit(str: string) : boolean;
function IsLower(str: string) : boolean; 
function IsUpper(str: string) : boolean; 
function Len(str: string) : integer; 
function MaxDate(d1,d2 : TDateTime) : TDateTime; 
function MaxInt(i1,i2 : integer) : integer; 
function MaxReal(r1,r2 : extended) : extended; 
function MaxStr(str1,str2 : string) : string; 
function MinDate(d1,d2 : TDateTime) : TDateTime; 
function MinInt(i1,i2 : integer) : integer; 
function MinReal(r1,r2 : extended) : extended; 
function MinStr(str1,str2 : string) : string; 


function Strg(X : real; w : word ; d : word) : string;  { like Clipper Str() }


(********** DIVERS **********)


procedure KijkStr( str: String); 
procedure KijkInt( i: integer); 
procedure KijkReal( r: Real; xDecimals: TStrLen); 
procedure KijkBool( b: Boolean); 


Implementation 


(********** STRFUNCS **********) 


{$IFNDEF WIN32} 
procedure SetLength(var S:String; bLen:Byte); 
begin 
   S[0] := Chr(bLen); 
end; 
{$ENDIF}


function AllTrim(const S:String): String; 
begin 
   Result := LTrim( Trim( S )); 
end; 


function At(const S:String; 
            const cSearchStr:String):TStrLen; 
begin 
        Result := Pos( S, cSearchStr ); 
end; 


function CapFirst(const S:String):String; 
var 
   xPos : TStrLen; 
   cTemp: String;
begin 
   cTemp     := Trim(S); 
   Result    := Trim(S); 
   Result[1] := UpCase(Result[1]); 
   xPos := RAt(' ', cTemp); 
   while xPos <> 0 do begin 
      cTemp := Substr( cTemp, 1, xPos-1 ); 
      Inc(xPos,1); 
      Result[xPos] := UpCase(Result[xPos]); 
      xPos    := RAt( ' ', cTemp); 
   end; 
end; 


function EmptyString(const S:String): Boolean; 
begin 
   Result := ( Length( AllTrim( S)) = 0); 
end; 


function EmptyStr(const S:String): Boolean; 
begin 
   Result := ( Length( AllTrim( S)) = 0); 
end; 


function Left(const S:String; xLen: TStrLen): String; 
begin 
   Result := Copy( S, 1, xLen ); 
end; 


function FillStr(const S:String;xPos:TStrLen; 
                 xLen:TStrLen;Ch:Char):String; 
begin 
   Result := Stuff(S,xPos,xLen,Replicate(Ch,xLen)); 
end; 


function Lower(const S:String): String; 
var 
   i : TStrLen; 
begin 
   Result := S; 
   for i := 1 to Length( Result ) do 
      if Result[i] in ['A'..'Z'] then 
         Result[i] := Chr( Ord( Result[i] ) + 32 ); 
end; 


function LTrim(const S:String): String; 
var 
   xLen: TStrLen; 
   xPos: TStrLen; 
begin 
   xLen := Length(S); 
   if xLen > 0 then begin 
      xPos := 1; 
      While S[xPos] = ' ' do 
         Inc(xPos,1); 
      Result := Copy( S, xPos,(Length(S) - xPos + 1)); 
   end 
   else 
      Result := ''; 
end; 


function PadC(const S:String; xLen: TStrLen; const Ch: Char = ' ' ): String;
var 
        xNoPad : TStrLen; 
begin 
   SetLength( Result, xLen ); 
   FillChar( Result[1], xLen, Ch ); 
   xNoPad := Length(S); 
   if xNoPad <= xLen then 
        Move( S[1], Result[((xLen-xNoPad) div 2)+1], xNoPad ) 
   else 
        Move( S[((xNoPad-xLen) div 2)+1], Result[1], xLen ); 
end; 


function PadL(const S:String; xLen: TStrLen; const Ch: Char = ' '): String;
var
   xLenInStr : TStrLen;
begin
   SetLength( Result, xLen );
   FillChar(Result[1],xLen,Ch);
   xLenInStr := Length(S);
   If xLenInStr <= xLen then
      Move( S[1], Result[Succ(xLen - xLenInStr)], xLenInStr)
   else
      Move(S[1],Result[1],xLen); 
end; 


function PadR(const S:String; xLen: TStrLen; const Ch: Char = ' '): String; 
begin 
   SetLength( Result, xLen ); 
   FillChar(Result[1],xLen,Ch); 
   if Length(S) <= xLen then 
      Move(S[1], Result[1], Length(S) ) 
   else 
      Move(S[1], Result[1], xLen ); 
end; 


function RAt(const cSearch: String; const S:String): TStrLen;
var
   Quit       : Boolean;
   xPos, xLen : TStrLen;
begin
   Result := 0;
   Quit   := False;
   xLen   := Length(cSearch);
   xPos   := Length(S) - xLen;
   while not Quit do
      begin
         if Copy(S,xPos,xLen) = cSearch then begin
            Result := xPos;
            Quit   := True;
         end;
         if xPos < 2 then    // changed from xPos = 1 9/19/2008
            Quit := True;
         Dec(xPos,1);
   end;
end;


function RealToStr(rInVal: Real; xDecimals: TStrLen): String;
var
   xWidth : TStrLen;
begin
   Str(Int(rInVal):40:0,Result);
   xWidth := Length(LTrim(Result));
   Str(rInVal:xWidth:xDecimals,Result);
end;


function Replicate(const cRepliStr: String; xNoTimes: TStrLen): String; 
var 
   i : TStrLen; 
begin 
   Result := ''; 
   For i := 1 To xNoTimes do 
      Result := Result + cRepliStr; 
end; 


function Right(const S:String; xLen: TStrLen): String; 
begin 
   Result := Copy( S, (Length( S )-xLen+1 ), xLen ); 
end; 


function RTrim(const S:String): String; 
begin 
        Result := Trim(S); 
end; 


function Space(xLen: TStrLen): String; 
begin 
   SetLength( Result, xLen ); 
   FillChar( Result[1], xLen, ' '); 
end; 


function StrToReal(const S:String): Real; 
var 
   ErrCode : Integer; 
   rTemp   : Real; 
   cTemp   : String; 
begin 
   Result := 0; 
   if Length(S) > 0 then begin 
      cTemp := S; 
      If Copy(cTemp,1,1) = '.' then 
         cTemp := '0' + cTemp; 
      If (Copy(cTemp,1,2) = '-.') then 
         Insert('0',cTemp,2); 
      If cTemp[Length(cTemp)] = '.' then 
         Delete(cTemp,Length(cTemp),1); 
      Val(cTemp,rTemp,ErrCode); 
      if ErrCode = 0 then 
         Result := rTemp; 
   end; 
end; 


function StrTran(const S:String; cSearch, cRepl:String; 
                 xStart,xCount:TStrLen; bMatchCase:Boolean): String; 
{If xStart en xCount are 0 then all will be changed } 
var 
   i,xPos,xLenS,xLenR : TStrLen; 
   cTemp              : String; 
   bAll               : Boolean; 
begin 
   cTemp  := S; 
   Result := S; 
   if NOT bMatchCase then begin 
      cTemp   := Upper(cTemp); 
      cSearch := Upper(cSearch); 
      cRepl   := Upper(cRepl); 
   end; 
   xLenS := Length(cSearch); 
   xLenR := Length(cRepl); 
   if xStart <= 0 then xStart := 1; 
   for i:= 1 to (xStart - 1) do begin 
      xPos  := At(cSearch, cTemp); 
      cTemp := Stuff(cTemp,xPos,xLenS,Replicate(#231,xLenS)); 
   end; 
   i    := 1; 
   xPos := At(cSearch, cTemp); 
   bAll := (xCount=0); 
   while (xPos <> 0) AND (bAll OR (i <= xCount)) do begin 
      Result := Stuff(Result,xPos,xLenS,cRepl); 
      cTemp  := Stuff(cTemp,xPos,xLenS,Replicate(#231,xLenR)); 
      xPos   := At(cSearch,cTemp); 
      Inc(i,1); 
   end; 
end; 


function StrZero(liNum:LongInt; 
                 xLen:TStrLen):String; 
begin 
        Str( liNum:0, Result ); 
   while Length( Result ) < xLen do 
        Result := '0' + Result; 
end; 


function Stuff(const S:String; 
               xStart,xToDel:TStrLen; 
               const cInsert:String):String; 
begin 
   Result := S; 
   system.Delete(Result, xStart, xToDel);
   system.Insert(cInsert, Result, xStart); 
end; 


function SubStr(const S:String; xPos, xLen: TStrLen): String; 
begin 
        Result := Copy(S,xPos,xLen); 
end; 


function TrailingBackSlash(const S:String): String; 
begin 
 Result := S; 
 if Copy(S, Length(S), 1) <> '\' 
   then Result:= S + '\'; 
end; 


function TrailingChar(const S:String; Trailer:Char): String; 
begin 
  Result := S; 
  if Copy( S, Length(S), 1) <> Trailer 
    then Result:= Result + Trailer; 
end; 


function Trim(const S:String): String; 
var 
   xPos: TStrLen; 
begin 
   xPos := Length(S); 
   if xPos > 0 then begin 
      While S[xPos] = ' ' do 
         Dec(xPos,1); 
      Result := Copy( S, 1, xPos ); 
   end 
   else 
      Result := ''; 
end; 


function Upper(const S:String): String; 
var
   i : TStrLen;
begin
   Result := S;
   for i := 1 to Length( Result ) do
      Result[i] := UpCase( Result[i] );
end;


(********** DATFUNCS **********)

{--- jeff's --- }
function BoQ( dtVar : TDateTime ): TDateTime; {- Begin-of-Quarter -}
var
  qYear, qMonth, qDay: word;
begin
  DecodeDate( dtVar, qYear, qMonth, qDay );
  case qMonth of
    1,2,3: qMonth := 1;
    4,5,6: qMonth := 4;
    7,8,9: qMonth := 7;
    else qMonth := 10;
  end;
  Result := EncodeDate( qYear, qMonth, 1 );
end;

function EoQ( dtVar : TDateTime ): TDateTime; {- End-of-Quarter -}
var
  qYear, qMonth, qDay: word;
begin
  DecodeDate( dtVar, qYear, qMonth, qDay );
  case qMonth of
    1,2,3: qMonth := 3;
    4,5,6: qMonth := 6;
    7,8,9: qMonth := 9;
    else qMonth := 12;
  end;
  Result := EoM( EncodeDate(qYear, qMonth, 1) );
end;

{--- jeff's --- }


function BoM( dtVar : TDateTime ): TDateTime;
var
  wYear, wMonth, wDay : Word;
begin
  { Begin v/d Maand }
  DecodeDate( dtVar, wYear, wMonth, wDay );
  Result := EncodeDate( wYear, wMonth, 1 );
end;


function BoW( dtVar : TDateTime ): TDateTime;
begin
  { Begin v/d Week }
  //Result := dtVar - DoW( dtVar ) + 1;
  Result := dtVar - DoW( dtVar );
end;


function BoY( dtVar : TDateTime ): TDateTime;
var
  wYear, wMonth, wDay : Word;
begin
  { Begin v/h Jaar }
  DecodeDate( dtVar, wYear, wMonth, wDay );
  Result := EncodeDate( wYear, 1, 1 );
end;


function Day( dtVar : TDateTime ): Word;
var
  wYear, wMonth, wDay : Word;
begin
  { Day v/d Maand }
  DecodeDate( dtVar, wYear, wMonth, wDay );
  Result   := wDay;
end;


function DoM( dtVar : TDateTime ): Word;
begin
  { Dag v/d Maand }
  Result := Day( dtVar );
end;


function Dow( dtVar : TDateTime ): Word;
var
  wDay : Word;
begin
  { Dag v/d week (volgens ISO) }
  wDay := DayOfWeek( dtVar );
  if wDay = 1 then
    Result := 7
  else
    Result := wDay - 1;
end;


function DoY( dtVar : TDateTime ): Word;
var
  wMonth, wYear, x : Word;
begin
  { Dag v/h Jaar }
  wMonth   := Month( dtVar );
  wYear    := Year( dtVar );
  Result   := 0;
  for x := 1 to wMonth-1 do
  begin
    Result := Result + MonthLen(EncodeDate(wYear,x,1));
  end;
  Result := Result + Day( dtVar );
end;


function EoM( dtVar : TDateTime ): TDateTime;
var
  wYear, wMonth, wDay, wDaysInMonth : Word;
begin
  { Einde v/d Maand }
  DecodeDate( dtVar, wYear, wMonth, wDay );
  wDaysInMonth := MonthLen(dtVar);
  Result       := EncodeDate( wYear, wMonth, wDaysInMonth );
end;


function Eow( dtVar : TDateTime ): TDateTime;
begin 
  { Einde v/d Week } 
  Result := dtVar + 7 - Dow( dtVar ); 
end; 


function Eoy( dtVar : TDateTime ): TDateTime; 
var 
  wYear, wMonth, wDay : Word; 
begin 
  { Einde v/h Jaar } 
  DecodeDate( dtVar, wYear, wMonth, wDay ); 
  Result := EncodeDate( wYear, 12, 31 ); 
end; 


function LeapYear( wYear: Word ): Boolean; 
begin 
  { Schrikkeljaar? } 
  Result := (wYear mod 4 = 0) and 
           ((wYear mod 100 <> 0) or (wYear mod 400 = 0)); 
end; 


function Month( dtVar : TDateTime ): Word; 
var 
  wYear, wMonth, wDay : Word; 
begin 
  { Maand v/e Datum } 
  DecodeDate( dtVar, wYear, wMonth, wDay ); 
  Result   := wMonth; 
end; 


function MonthLen( dtVar : TDateTime ): Word; 
type 
  TMonthLen = array[0..12] of Word; 
const 
  FMonthLen: TMonthLen = (0,31,28,31,30,31,30,31,31,30,31,30,31); 
var 
  wYear, wMonth, wDay, wDaysInMonth : Word; 
begin 
  { Lenghte v/d Maand } 
  DecodeDate( dtVar, wYear, wMonth, wDay ); 
  Result   := FMonthLen[wMonth]; 
  if (wMonth = 2) and (LeapYear(wYear)) then Result := 29; 
end; 


function NextMonth( dtVar : TDateTime ): TDateTime; 
begin 
  { Volgende Maand } 
  Result := dtVar + MonthLen( dtVar ); 
  if Month( dtVar ) = Month( Result ) - 2 then 
    Result := BoM( Result ) - 1 
end; 


function NextYear( dtVar : TDateTime ): TDateTime; 
var 
  wYear, wMonth, wDay : Word; 
begin 
  { Volgend Jaar } 
  if (Day( dtVar ) = 29) and (Month( dtVar ) = 2) then dtVar := dtVar - 1; 
  DecodeDate( dtVar, wYear, wMonth, wDay ); 
  Result := EncodeDate( wYear + 1, wMonth, wDay ); 
end; 


function PrevMonth( dtVar : TDateTime ): TDateTime; 
begin 
  { Vorige Maand } 
  Result := BoM( dtVar ) - 1; 
  while Day( Result ) > Day( dtVar ) do 
    Result := Result - 1; 
end; 


function PrevYear( dtVar : TDateTime ): TDateTime; 
var 
  wYear, wMonth, wDay : Word; 
begin 
  { Vorig Jaar } 
  if (Day( dtVar ) = 29) and (Month( dtVar ) = 2) then dtVar := dtVar - 1; 
  DecodeDate( dtVar, wYear, wMonth, wDay ); 
  Result := EncodeDate( wYear - 1, wMonth, wDay ); 
end; 


function WeekDate( wYear, wWeek : Word ): TDateTime; 
begin 
  { Datum van eerste dag van een week/jaar } 
  Result := FirstMonday(wYear) + 7 * (wWeek-1); 
end; 


function WeekLast( dtVar : TDateTime ): Word; 
var 
  wYear : Word; 
begin 
  wYear  := Year( dtVar ); 
  {  Weeknr. van dag voor 1ste maandag in nieuw jaar } 
  Result := WeekNr( FirstMonday( wYear+1 ) - 1 ); 
end; 


function WeekNr( dtVar : TDateTime ): Word; 
var 
  dtFirstMonday : TDateTime; 
  wYear : Word; 
begin 
  { WeekNr volgens ISO Norm } 
  wYear := Year( dtVar ); 
  { 1ste week van volgende jaar? } 
  if dtVar >= FirstMonday( wYear+1 ) then 
    Result := 1 
  else begin 
    { In vorig jaar } 
    if dtVar < FirstMonday( wYear ) then 
      dtFirstMonday := FirstMonday( wYear-1 ) 
    else 
      dtFirstMonday := FirstMonday( wYear ); 
    Result := 1 + ( Trunc(dtVar - dtFirstMonday) div 7 ); 
  end; 
end; 


function WeekYear( dtVar : TDateTime ): Word; 
var 
  dtFirstMonday : TDateTime; 
  wYear : Word; 
begin 
  { WeekJaar volgens ISO Norm } 
  wYear  := Year( dtVar ); 
  Result := wYear; 
  { 1ste week van volgend jaar? } 
  if dtVar >= FirstMonday( wYear+1 ) then 
    Result := wYear + 1 
  else if dtVar < FirstMonday( wYear ) then 
    Result := wYear - 1; 
end; 


function Year( dtVar : TDateTime ): Word; 
var 
  wYear, wMonth, wDay : Word; 
begin 
  DecodeDate( dtVar, wYear, wMonth, wDay ); 
  Result   := wYear; 
end; 


function YearLen( wYear : Word ): Word; 
begin 
  if LeapYear(wYear) then Result := 366 else Result := 365; 
end; 


function FirstMonday( wYear : Word ): TDateTime; 
begin 
  { De eerste maandag v/h jaar volgens ISO } 
  Result := EncodeDate( wYear, 1, 1 ); 
  Result := Result + 4 - DayOfWeek( Result+2 ); 
end; 


function Easter( wYear : Word ): TDateTime; 
var 
  i,n,w: Word; 
begin 
  Result := 0.0; 
  {- Datum van pasen v/e bepaald jaar } 
  if (wYear > 1900) and (wYear < 2100) then 
  begin 
    i := (wYear mod 19) + 1; 
    n := (11*i + 18) mod 30; 
    if (n=25) and (i>11) then Inc(n); 
    n := 31 - n; 
    if (n<8) then n := n + 30; 
    w := (((5*wYear) div 4)+n) mod 7; 
    n := n + 19 - w; 
    Result := EncodeDate(wYear,3,1) + n; 
  end 
end; 


(********** CLPFUNCS **********) 


function  ASC(str : string) : byte; 
var 
  ch : char; 
begin 
  ch := str[1]; 
  Result := Ord(ch); 
end; 


function CDOW(Date: TDateTime) : string; 
var 
  day : integer; 
begin 
  day := DayOfWeek(Date); 
  case day of 
     1 : Result := 'Zondag'; 
     2 : Result := 'Maandag'; 
     3 : Result := 'Dinsdag'; 
     4 : Result := 'Woensdag'; 
     5 : Result := 'Donderdag'; 
     6 : Result := 'Vrijdag'; 
     7 : Result := 'Zaterdag'; 
  end; 
end; 


function CMonth(Date: TDateTime) : string; 
var 
  year,month,day : word; 
begin 
  DecodeDate(Date,year,month,day); 
  case month of 
     1 : Result := 'January';
     2 : Result := 'February';
     3 : Result := 'March';
     4 : Result := 'April';
     5 : Result := 'May';
     6 : Result := 'June';
     7 : Result := 'July';
     8 : Result := 'August';
     9 : Result := 'September';
    10 : Result := 'October';
    11 : Result := 'November';
    12 : Result := 'December';
  end; 
end; 


function  CToD(cDate: string) : TDateTime; 
var 
  year,month,day : word; 
  iCode : integer;  { throw away } 
begin 
  { make sure date is in the right format } 
  { but not yet } 
  Val( SubStr( cDate, 1, 2), day  , iCode); 
  Val( SubStr( cDate, 4, 2), month, iCode); 
  Val( SubStr( cDate, 7, 2), year , iCode); 
  Result := EncodeDate( year, month, day); 
end; 


function  DiskSpace(Drive: Byte): Longint; 
begin 
  Result := DiskFree(Drive) 
end; 


function  DToC(Date : TDateTime) : string;  {to wrap PASCAL func "DateToStr()"} 
begin 
  Result := DateToStr(Date) 
end; 


function  DToS(Date : TDateTime) : string; 
var 
  year,month,day : word; 
begin 
  DecodeDate(Date,year,month,day); 
  Result := StrZero( year, 4) + StrZero( month, 2) + StrZero( day, 2) 
end; 


function  EmptyDate(Date : TDateTime) : boolean; 
var 
  year,month,day : word; 
begin 
  DecodeDate(Date,year,month,day); 
  if (year=0) and (month=0) and (day=0) then 
    Result := TRUE 
  else 
    Result := FALSE 
end; 


function  Ferase(str: string) : boolean; 
begin 
  Result := DeleteFile(str) 
end; 


function  IIFDate(c1 : boolean; ret1,ret2 : TDateTime) : TDateTime; 
begin 
  if c1 then 
    Result := ret1 
  else 
    Result := ret2 
end; 


function  IIFInt(c1 : boolean; ret1,ret2 : integer) : integer; 
begin 
  if c1 then 
    Result := ret1 
  else 
    Result := ret2 
end; 


function  IIFReal(c1 : boolean; ret1,ret2 : extended) : extended; 
begin 
  if c1 then 
    Result := ret1 
  else 
    Result := ret2 
end; 


function  IIFStr(c1 : boolean; ret1,ret2 : string) : string; 
begin 
  if c1 then 
    Result := ret1 
  else 
    Result := ret2 
end; 

function  IIFVariant(c1 : boolean; ret1,ret2 : Variant) : Variant;
begin
  if c1 then
    Result := ret1 
  else 
    Result := ret2
end;


function  IsAlpha(str: string) : boolean; 
var 
  asciinum : byte; 
  ch : char; 


begin 
  Result := FALSE; 
  {ch := 'a'; 
  ch := Char(Copy(str,1,1));  invalid type cast} 
  ch := str[1]; 
  asciinum := Ord(ch); 
  if ((asciinum >= 97) and (asciinum <= 122)) or 
     ((asciinum >= 65) and (asciinum <= 90)) then 
    Result := TRUE; 
end; 


function  IsDigit(str: string) : boolean;
var 
  asciinum : byte; 
  ch : char;
  i : integer; 
begin
{
  Result := FALSE;
  ch := str[1];
  asciinum := Ord(ch);
  if ((asciinum >= 48) and (asciinum <= 57)) then
    Result := TRUE;
    }
  Result := TRUE;
  for i := 1 to Length(str) do begin
    ch := str[i];
    asciinum := Ord(ch);
    if not ((asciinum >= 48) and (asciinum <= 57)) then
    begin
      Result := FALSE;
      exit;
    end;
  end;
end;


function  IsLower(str: string) : boolean; 
var 
  asciinum : byte; 
  ch : char; 
begin 
  Result := FALSE; 
  ch := str[1]; 
  asciinum := Ord(ch); 
  if ((asciinum >= 97) and (asciinum <= 122)) then 
    Result := TRUE; 
end; 


function  IsUpper(str: string) : boolean; 
var 
  asciinum : byte; 
  ch : char; 
begin 
  Result := FALSE; 
  ch := str[1]; 
  asciinum := Ord(ch); 
  if ((asciinum >= 65) and (asciinum <= 90)) then 
    Result := TRUE; 
end; 


function  Len(str: string) : integer;   { to wrap PASCAL function "Length" } 
begin 
  Result := Length(str) 
end; 


function  MaxDate(d1,d2 : TDateTime) : TDateTime; 
begin 
  if d1 > d2 then 
    Result := d1 
  else 
    Result := d2 
end; 


function  MaxInt(i1,i2 : integer) : integer; 
begin 
  if i1 > i2 then 
    Result := i1 
  else 
    Result := i2 
end; 


function  MaxReal(r1,r2 : extended) : extended; 
begin 
  if r1 > r2 then 
    Result := r1 
  else 
    Result := r2 
end; 


function  MaxStr(str1,str2 : string) : string; 
begin 
  if str1 > str2 then 
    Result := str1 
  else 
    Result := str2 
end; 


function  MinDate(d1,d2 : TDateTime) : TDateTime; 
begin 
  if d1 < d2 then 
    Result := d1 
  else 
    Result := d2 
end; 


function  MinInt(i1,i2 : integer) : integer; 
begin 
  if i1 < i2 then 
    Result := i1 
  else 
    Result := i2 
end; 


function  MinReal(r1,r2 : extended) : extended; 
begin 
  if r1 < r2 then 
    Result := r1 
  else 
    Result := r2 
end; 


function  MinStr(str1,str2 : string) : string; 
begin 
  if str1 < str2 then 
    Result := str1 
  else 
    Result := str2 
end; 


function Strg(X : real; w : word ; d : word) : string; 
var 
  XStr : string; 
begin 
  Str(X:w:d,XStr);     { <--- note the funny syntax see DU p 283} 
  Result := XStr 
end; 


(********** DIVERS **********) 


procedure KijkStr( str: String); 
begin 
   ShowMessage( str); 
end; 


procedure KijkInt( i: integer); 
begin 
   ShowMessage( IntToStr( i)); 
end; 


procedure KijkReal( r: Real; xDecimals: TStrLen); 
var 
   xWidth : TStrLen; 
   s: String; 
begin 
   Str( Int(r):40:0, s); 
   xWidth := Length( LTrim( s)); 
   Str( r:xWidth:xDecimals, s); 
   ShowMessage( s); 
end; 


procedure KijkBool( b: Boolean); 
begin
   if b=True then ShowMessage( 'True' )
             else ShowMessage( 'False');
end;


function GetAppCurrentDir: string;
begin
  result := getcurrentdir;
  if not( result[length(result)] in ['/','\'] ) then
    result := result + '\';
end;



{--- mga gawa ni jeff --}
{ 03-08-14 : this incrementstring code failed with '209886202172'.
  The code cannot convert the string into a valid integer;
  re-implementation follows below;


function IncrementString(s: string): string;
var
  i, j: integer;
  sPref, oldS: string;
begin
  //increment any string to its logical successor
  if s='' then begin
    result := '';
    exit;
  end;

  //s := StrTran(s,'-','',0,100,false);
  sPref := '';
  i := RAt('-',s);
  j := RAt(' ',s);
  i := IIfInt(i>j, i, j);
  if i > 0 then begin
    sPref := Copy(s,0,i);
    s := Copy(s,i+1,100);
  end;
  
  if IsDigit(s) then begin
    oldS := s;
    j := Length(OldS);
    i := StrToInt(s);
    Inc(i);
    s := IntToStr(i);
    i := Length(s);
    s := Stuff(OldS,(j-i)+1,100,s);
  end else

    s := copy(s,0,Length(s)-1)+ Succ(copy(s,Length(s),1)[1]);
  result := sPref + s;
end;
}

//--------------------
function IncrementString(s: string): string;
  function IncrementChar( c: string ): string;
  begin
    if c = 'z' then Result := 'a' else
    if c = 'Z' then Result := 'A' else
    if c = '9' then Result := '0' else
    if (c < '0') or (c > 'z') then Result := c else
    Result := Succ( c[1] );
  end;
var
  i, j: integer;
  sPref, oldS: string;
  RMC, RMCs: string;
  RMCPointer: Integer;
  bQuit : Boolean;
begin
  //increment any string to its logical ASCII successor
  if s='' then begin
    result := '';
    exit;
  end;

  RMCPointer := 1;
  bQuit := False;

  while not bQuit do
  begin
    RMC := IncrementChar(Left(Right(s,RMCPointer),1));
    if (Pos(RMC,'aA0') > 0) or (RMC < '0') or (RMC > 'z') then
    begin
      Inc(RMCPointer);
      if RMCPointer > Len(s) then bQuit := True
      else RMCs := RMC + RMCs;
    end else
      bQuit := True;
  end;

  Result := Left(s,Len(s)-RMCPointer) + RMC + RMCs;
  if RMCPointer > Len(s) then
  begin
    if RMC = '0' then Result := '1'+ Result else
    if RMC = 'a' then Result := 'a'+ Result else
    if RMC = 'A' then Result := 'A'+ Result;
  end;

end;

//--------------------
procedure QuickDatePick( var fdate1, fdate2: tdatetime;
  flag: string; const flag2: shortint=0);
begin
  if flag='DAY' then //today
    begin
      fdate1 := date-iifint(flag2=1,1,0);
      fdate2 := date-iifint(flag2=1,1,0);
    end
  else if flag ='WEEK' then
    begin
      fdate1 := BoW(date-iifint(flag2=0,0,7))-1;
      fdate2 := EoW(date-iifint(flag2=0,0,7))-1;
    end
  else if flag ='MONTH' then
    if flag2=0 then begin   // this month
      fdate1 := BoM(date);
      fdate2 := EoM(date);
    end else begin          // last month
      fdate1 := BoM( BoM(date)-1 );
      fdate2 := BoM(date)-1 ;
    end
  else if flag ='QUARTER' then
    if flag2=0 then begin   // this qtr
      fdate1 := BoQ(date);
      fdate2 := EoQ(date);
    end else begin          // last qtr
      fdate1 := BoQ( BoQ(date)-1 );
      fdate2 := BoQ(date)-1;
    end
  else if flag ='YEAR' then
    if flag2=0 then begin   // this year
      fdate1 := BoY(date);
      fdate2 := EoY(date);
    end else begin          // last year
      fdate1 := BoY( BoY(date)-1 );
      fdate2 := BoY(date)-1;
    end;
end;


procedure DateComplete(var StrLikeDate : string; const NowIfError:boolean = True) ;
 var
    DateStr : string;
    Year, Month, Day : Word;
    cnt, SepCount : Integer;
 begin
    DateStr:=StrLikeDate;
 
    if DateStr = '' then Exit;
    SepCount := 0;
 
    for cnt := 1 to Length(DateStr) do
    begin
     if not (DateStr[cnt] in ['0'..'9']) then
     begin
      DateStr[cnt] := DateSeparator;
      inc(SepCount) ;
     end;
    end;
 
    while (DateStr <> '') and (DateStr[Length(DateStr)]=DateSeparator) do
    begin
     Delete(DateStr, Length(DateStr), 1) ;
     Dec(SepCount) ;
    end;
 
    DecodeDate(Now, Year, Month, Day) ;
 
    if SepCount = 0 then
    begin
     case Length(DateStr) of
     0 : DateStr := DateToStr(Now) ;
     1, 2 : DateStr := DateStr+DateSeparator+IntToStr(Month) ;
     4 : Insert(DateSeparator, DateStr, 3) ;
     6, 8 : begin
             Insert(DateSeparator, DateStr, 5) ;
             Insert(DateSeparator, DateStr, 3) ;
            end;
      end; {case}
     end; {if SepCount}
 
     try
      StrLikeDate := DateToStr(StrToDate(DateStr)) ;
     except
      if NowIfError = true then
       StrLikeDate := DateToStr(Date)
      else
       StrLikeDate := '';
     end;
 end; 



end.

