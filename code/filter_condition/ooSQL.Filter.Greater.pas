{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Greater;

interface

uses
  SysUtils,
  ooSQL.Parameter.Intf,
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TSQLConditionGreater = class sealed(TInterfacedObject, IFilterCondition)
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

function TSQLConditionGreater.IsEmpty: Boolean;
begin
  Result := Length(_Value) < 1;
end;

function TSQLConditionGreater.IsReplaceable: Boolean;
begin
  if IsEmpty then
    Result := False
  else
    Result := HasDynamicPrefix(_Value);
end;

function TSQLConditionGreater.IsValid: Boolean;
begin
  Result := (Length(Key) > 0) and not IsEmpty;
end;

function TSQLConditionGreater.Key: String;
begin
  Result := _Key;
end;

function TSQLConditionGreater.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([Key, '>', _Value]);
end;

constructor TSQLConditionGreater.Create(const Key, Value: String);
begin
  _Key := Key;
  _Value := Value;
end;

class function TSQLConditionGreater.New(const Key, Value: String): IFilterCondition;
begin
  Result := TSQLConditionGreater.Create(Key, Value);
end;

end.
