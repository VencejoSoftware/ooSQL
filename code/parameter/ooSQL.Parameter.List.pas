{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.List;

interface

uses
  Classes, SysUtils,
  Generics.Collections,
  ooSQL.Parameter.Intf;

type
  TSQLParameterList = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Name: String;
    _List: TList<ISQLParameter>;
  public
    function Name: String;
    function IsNull: Boolean;
    function NameParsed: String;
    function ValueParsed: String;

    procedure Clear;

    constructor Create(const Name: String; List: TList<ISQLParameter>);

    class function New(const Name: String; List: TList<ISQLParameter>): ISQLParameter;
  end;

implementation

procedure TSQLParameterList.Clear;
var
  SQLParameter: ISQLParameter;
begin
  for SQLParameter in _List do
    SQLParameter.Clear;
end;

function TSQLParameterList.IsNull: Boolean;
var
  SQLParameter: ISQLParameter;
begin
  Result := False;
  for SQLParameter in _List do
  begin
    Result := SQLParameter.IsNull;
    if Result then
      Break;
  end;
end;

function TSQLParameterList.Name: String;
begin
  Result := _Name;
end;

function TSQLParameterList.NameParsed: String;
begin
  Result := PARAMETER_PREFIX + Name;
end;

function TSQLParameterList.ValueParsed: String;
const
  LIST_SEPARATOR = ',';
var
  SQLParameter: ISQLParameter;
begin
  if IsNull then
  begin
    Result := PARAMETER_NULL;
  end
  else
  begin
    Result := EmptyStr;
    for SQLParameter in _List do
      Result := Result + SQLParameter.ValueParsed + LIST_SEPARATOR;
    Result := Copy(Result, 1, Length(Result) - Length(LIST_SEPARATOR));
    Result := '(' + Result + ')';
  end;
end;

constructor TSQLParameterList.Create(const Name: String; List: TList<ISQLParameter>);
begin
  _Name := Name;
  _List := List;
end;

class function TSQLParameterList.New(const Name: String; List: TList<ISQLParameter>): ISQLParameter;
begin
  Result := Create(Name, List);
end;

end.
