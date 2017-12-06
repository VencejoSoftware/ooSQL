{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.Bool;

interface

uses
  ooFilter.Parameter, ooSQL.Parameter.Intf;

type
  TSQLParameterBool = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Parameter: IParameter<Boolean>;
  public
    function Name: String;
    function IsNull: Boolean;
    function NameParsed: String;
    function ValueParsed: String;

    procedure Clear;

    constructor Create(const Parameter: IParameter<Boolean>);

    class function New(const Name: String; const Value: Boolean): ISQLParameter;
  end;

implementation

function TSQLParameterBool.IsNull: Boolean;
begin
  Result := _Parameter.IsNull;
end;

function TSQLParameterBool.Name: String;
begin
  Result := _Parameter.Name;
end;

function TSQLParameterBool.NameParsed: String;
begin
  Result := PARAMETER_PREFIX + Name;
end;

function TSQLParameterBool.ValueParsed: String;
const
  BOOLEAN_VALUE: array [Boolean] of char = ('0', '1');
begin
  if IsNull then
    Result := PARAMETER_NULL
  else
    Result := BOOLEAN_VALUE[_Parameter.Value];
end;

procedure TSQLParameterBool.Clear;
begin
  _Parameter.Clear;
end;

constructor TSQLParameterBool.Create(const Parameter: IParameter<Boolean>);
begin
  _Parameter := Parameter;
end;

class function TSQLParameterBool.New(const Name: String; const Value: Boolean): ISQLParameter;
begin
  Result := Create(TParameter<Boolean>.New(Name, Value));
end;

end.
