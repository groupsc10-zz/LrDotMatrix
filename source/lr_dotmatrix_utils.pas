unit lr_dotmatrix_utils;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

function IfThen(aCondition: boolean; const aFalseReturn: string; const aTrueReturn: string = ''): string; overload;

function PadCenter(const aData: string; aNewLength: integer; aFillChar: char = ' '): string;
function PadLeft(const aData: string; aNewLength: integer; aFillChar: char = ' '): string;
function PadRight(const aData: string; aNewLength: integer; aFillChar: char = ' '): string;

//from : https://github.com/silvioprog/rutils
function RemoveDiacritics(const S: string): string;

implementation

function IfThen(aCondition: boolean; const aFalseReturn: string; const aTrueReturn: string): string;
begin
  if (aCondition) then
  begin
    Result := aTrueReturn;
  end
  else
  begin
    Result := aFalseReturn;
  end;
end;

function PadCenter(const aData: string; aNewLength: integer; aFillChar: char): string;
var
  vLength: integer;
begin
  vLength := (aNewLength - Length(aData)) div 2;
  if (vLength > 0) then
  begin
    Result := StringOfChar(aFillChar, vLength) + aData + StringOfChar(aFillChar, vLength);
  end;
  // when length(Result) is an odd number
  Result := PadRight(Result, aNewLength, aFillChar);
end;

function PadLeft(const aData: string; aNewLength: integer; aFillChar: char): string;
var
  vLength: integer;
begin
  vLength := Length(aData);
  if (vLength < aNewLength) then
  begin
    Result := aData + StringOfChar(aFillChar, aNewLength - vLength);
  end
  else
  begin
    Result := LeftStr(aData, aNewLength);
  end;
end;

function PadRight(const aData: string; aNewLength: integer; aFillChar: char): string;
var
  vLength: integer;
begin
  vLength := Length(aData);
  if (vLength < aNewLength) then
  begin
    Result := StringOfChar(aFillChar, aNewLength - vLength) + aData;
  end
  else
  begin
    Result := RightStr(aData, aNewLength);
  end;
end;

function RemoveDiacritics(const S: string): string;
var
  F: boolean;
  I: SizeInt;
  PS, PD: PChar;
begin
  SetLength(Result, Length(S));
  PS := PChar(S);
  PD := PChar(Result);
  I := 0;
  while PS^ <> #0 do
  begin
    F := PS^ = #195;
    if F then
      case PS[1] of
        #128..#134: PD^ := 'A';
        #135: PD^ := 'C';
        #136..#139: PD^ := 'E';
        #140..#143: PD^ := 'I';
        #144: PD^ := 'D';
        #145: PD^ := 'N';
        #146..#150, #152: PD^ := 'O';
        #151: PD^ := 'x';
        #153..#156: PD^ := 'U';
        #157: PD^ := 'Y';
        #158: PD^ := 'P';
        #159: PD^ := 's';
        #160..#166: PD^ := 'a';
        #167: PD^ := 'c';
        #168..#171: PD^ := 'e';
        #172..#175: PD^ := 'i';
        #176: PD^ := 'd';
        #177: PD^ := 'n';
        #178..#182, #184: PD^ := 'o';
        #183: PD^ := '-';
        #185..#188: PD^ := 'u';
        #190: PD^ := 'p';
        #189, #191: PD^ := 'y';
        else
          F := False;
      end;
    if F then
      Inc(PS)
    else
      PD^ := PS^;
    Inc(I);
    Inc(PD);
    Inc(PS);
  end;
  SetLength(Result, I);
end;

end.
