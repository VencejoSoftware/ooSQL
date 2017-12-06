{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.IsNull;

interface

uses
  ooText.Beautify.Intf,
  ooFilter.Condition.Intf;

type
  TSQLConditionIsNull = class sealed(TInterfacedObject, IFilterCondition)
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

function TSQLConditionIsNull.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLConditionIsNull.IsReplaceable: Boolean;
begin
  Result := False;
end;

function TSQLConditionIsNull.IsValid: Boolean;
begin
  Result := (Length(Key) > 0) and not IsEmpty;
end;

function TSQLConditionIsNull.Key: String;
begin
  Result := _Key;
end;

function TSQLConditionIsNull.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([Key, 'IS NULL']);
end;

constructor TSQLConditionIsNull.Create(const Key: String);
begin
  _Key := Key;
end;

class function TSQLConditionIsNull.New(const Key: String): IFilterCondition;
begin
  Result := TSQLConditionIsNull.Create(Key);
end;

end.
