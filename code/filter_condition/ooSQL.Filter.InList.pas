{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.InList;

interface

uses
  SysUtils,
  ooSQL.Parameter.Intf,
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TSQLConditionIn = class sealed(TInterfacedObject, IFilterCondition)
  strict private
    _Key: String;
    _Values: Array of string;
  private
    function PlainValues: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key: String; const Values: Array of string);

    class function New(const Key: String; const Values: Array of string): IFilterCondition;
  end;

implementation

function TSQLConditionIn.IsEmpty: Boolean;
begin
  Result := Pred(Length(_Values)) = - 1;
end;

function TSQLConditionIn.IsReplaceable: Boolean;
var
  Item: String;
begin
  Result := False;
  if IsEmpty then
    Exit;
  for Item in _Values do
    if Length(Item) > 0 then
      if HasDynamicPrefix(Item) then
      begin
        Result := True;
        Break;
      end;
end;

function TSQLConditionIn.IsValid: Boolean;
begin
  Result := (Length(Key) > 0) and not IsEmpty;
end;

function TSQLConditionIn.Key: String;
begin
  Result := _Key;
end;

function TSQLConditionIn.PlainValues: String;
var
  Item: String;
begin
  Result := EmptyStr;
  if IsEmpty then
    Exit;
  for Item in _Values do
    Result := Result + Item + ', ';
  Result := Copy(Result, 1, Length(Result) - 2);
end;

function TSQLConditionIn.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([Key, 'IN', Beautify.DelimitedList(PlainValues)]);
end;

constructor TSQLConditionIn.Create(const Key: String; const Values: Array of string);
var
  i: Integer;
begin
  _Key := Key;
  SetLength(_Values, Length(Values));
  for i := 0 to High(Values) do
    _Values[i] := Values[i];
end;

class function TSQLConditionIn.New(const Key: String; const Values: Array of string): IFilterCondition;
begin
  Result := TSQLConditionIn.Create(Key, Values);
end;

end.
