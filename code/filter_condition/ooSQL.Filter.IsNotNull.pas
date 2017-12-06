{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.IsNotNull;

interface

uses
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TSQLConditionIsNotNull = class sealed(TInterfacedObject, IFilterCondition)
  strict private
    _Key: String;
  public
    function IsValid: Boolean;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;
    function Parse(const Beautify: ITextBeautify): String;
    function Key: String;

    constructor Create(const Key: String);

    class function New(const Key: String): IFilterCondition;
  end;

implementation

function TSQLConditionIsNotNull.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLConditionIsNotNull.IsReplaceable: Boolean;
begin
  Result := False;
end;

function TSQLConditionIsNotNull.IsValid: Boolean;
begin
  Result := (Length(Key) > 0) and not IsEmpty;
end;

function TSQLConditionIsNotNull.Key: String;
begin
  Result := _Key;
end;

function TSQLConditionIsNotNull.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([Key, 'IS NOT NULL']);
end;

constructor TSQLConditionIsNotNull.Create(const Key: String);
begin
  _Key := Key;
end;

class function TSQLConditionIsNotNull.New(const Key: String): IFilterCondition;
begin
  Result := TSQLConditionIsNotNull.Create(Key);
end;

end.
