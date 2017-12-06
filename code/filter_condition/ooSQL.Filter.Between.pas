{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Between;

interface

uses
  SysUtils,
  ooSQL.Filter.JoinAnd,
  ooSQL.Parameter.Intf,
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TSQLConditionBetween = class sealed(TInterfacedObject, IFilterCondition)
  strict private
    _Key, _Value1, _Value2: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key, Value1, Value2: String);

    class function New(const Key, Value1, Value2: String): IFilterCondition;
  end;

implementation

function TSQLConditionBetween.IsEmpty: Boolean;
begin
  Result := (Length(_Value1) < 1) or (Length(_Value2) < 1);
end;

function TSQLConditionBetween.IsReplaceable: Boolean;
begin
  if IsEmpty then
    Result := False
  else
    Result := HasDynamicPrefix(_Value1) or HasDynamicPrefix(_Value2);
end;

function TSQLConditionBetween.IsValid: Boolean;
begin
  Result := (Length(Key) > 0) and not IsEmpty;
end;

function TSQLConditionBetween.Key: String;
begin
  Result := _Key;
end;

function TSQLConditionBetween.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([Key, 'BETWEEN', _Value1, TSQLJoinAnd.New.Parse(Beautify), _Value2]);
end;

constructor TSQLConditionBetween.Create(const Key, Value1, Value2: String);
begin
  _Key := Key;
  _Value1 := Value1;
  _Value2 := Value2;
end;

class function TSQLConditionBetween.New(const Key, Value1, Value2: String): IFilterCondition;
begin
  Result := TSQLConditionBetween.Create(Key, Value1, Value2);
end;

end.
