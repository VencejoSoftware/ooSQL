{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.Int;

interface

uses
  SysUtils,
  ooFilter.Parameter, ooSQL.Parameter.Intf;

type
  TSQLParameterInt = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Parameter: IParameter<Integer>;
  public
    function Name: String;
    function IsNull: Boolean;
    function NameParsed: String;
    function ValueParsed: String;

    procedure Clear;

    constructor Create(const Parameter: IParameter<Integer>);

    class function New(const Name: String; const Value: Integer): ISQLParameter;
  end;

implementation

function TSQLParameterInt.IsNull: Boolean;
begin
  Result := _Parameter.IsNull;
end;

function TSQLParameterInt.Name: String;
begin
  Result := _Parameter.Name;
end;

function TSQLParameterInt.NameParsed: String;
begin
  Result := PARAMETER_PREFIX + Name;
end;

function TSQLParameterInt.ValueParsed: String;
begin
  if IsNull then
    Result := PARAMETER_NULL
  else
    Result := IntToStr(_Parameter.Value);
end;

procedure TSQLParameterInt.Clear;
begin
  _Parameter.Clear;
end;

constructor TSQLParameterInt.Create(const Parameter: IParameter<Integer>);
begin
  _Parameter := Parameter;
end;

class function TSQLParameterInt.New(const Name: String; const Value: Integer): ISQLParameter;
begin
  Result := TSQLParameterInt.Create(TParameter<Integer>.New(Name, Value));
end;

end.
