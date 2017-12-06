{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.SimpleFormatter;

interface

uses
  SysUtils,
  ooText.Beautify.Intf;

type
  TSQLFilterSimpleFormatter = class(TInterfacedObject, ITextBeautify)
  strict private
    _Margin: Byte;
  private
    function ApplyMargin(const Text: String): String;
  public
    procedure ChangeMargin(const Margin: Byte);

    function Apply(const ArrayText: Array of string): String;
    function DelimitedList(const Value: String): String;

    class function New: ITextBeautify;
  end;

implementation

function TSQLFilterSimpleFormatter.ApplyMargin(const Text: String): String;
begin
  Result := StringOfChar(' ', _Margin) + Text;
end;

function TSQLFilterSimpleFormatter.Apply(const ArrayText: array of string): String;
const
  EOL = ';';
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to High(ArrayText) do
    Result := Result + StringReplace(ArrayText[i], EOL, EmptyStr, [rfReplaceAll]) + ' ';
  Result := ApplyMargin(Trim(Result));
end;

procedure TSQLFilterSimpleFormatter.ChangeMargin(const Margin: Byte);
begin
  _Margin := Margin;
end;

function TSQLFilterSimpleFormatter.DelimitedList(const Value: String): String;
begin
  Result := '(' + Trim(Value) + ')';
end;

class function TSQLFilterSimpleFormatter.New: ITextBeautify;
begin
  Result := TSQLFilterSimpleFormatter.Create;
end;

end.
