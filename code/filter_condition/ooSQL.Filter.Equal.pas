{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Equal;

interface

uses
  SysUtils,
  ooSQL.Parameter.Intf,
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TSQLConditionEqual = class sealed(TInterfacedObject, IFilterCondition)
  strict private
    _Key, _Value: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key, Value: String);

    class function New(const Key, Value: String): IFilterCondition;
  end;

implementation

function TSQLConditionEqual.IsEmpty: Boolean;
begin
  Result := Length(_Value) < 1;
end;

function TSQLConditionEqual.IsReplaceable: Boolean;
begin
  if IsEmpty then
    Result := False
  else
    Result := HasDynamicPrefix(_Value);
end;

function TSQLConditionEqual.IsValid: Boolean;
begin
  Result := (Length(Key) > 0) and not IsEmpty;
end;

function TSQLConditionEqual.Key: String;
begin
  Result := _Key;
end;

function TSQLConditionEqual.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([Key, '=', _Value]);
end;

constructor TSQLConditionEqual.Create(const Key, Value: String);
begin
  _Key := Key;
  _Value := Value;
end;

class function TSQLConditionEqual.New(const Key, Value: String): IFilterCondition;
begin
  Result := TSQLConditionEqual.Create(Key, Value);
end;

end.
