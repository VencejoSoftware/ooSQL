{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.Dbl;

interface

uses
  SysUtils,
  ooFilter.Parameter, ooSQL.Parameter.Intf;

type
  TSQLParameterDbl = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Parameter: IParameter<Extended>;
  public
    function Name: String;
    function IsNull: Boolean;
    function NameParsed: String;
    function ValueParsed: String;

    procedure Clear;

    constructor Create(const Parameter: IParameter<Extended>);

    class function New(const Name: String; const Value: Extended): ISQLParameter;
  end;

implementation

function TSQLParameterDbl.IsNull: Boolean;
begin
  Result := _Parameter.IsNull;
end;

function TSQLParameterDbl.Name: String;
begin
  Result := _Parameter.Name;
end;

function TSQLParameterDbl.NameParsed: String;
begin
  Result := PARAMETER_PREFIX + Name;
end;

function TSQLParameterDbl.ValueParsed: String;
begin
  if IsNull then
    Result := PARAMETER_NULL
  else
    Result := FloatToStr(_Parameter.Value);
end;

procedure TSQLParameterDbl.Clear;
begin
  _Parameter.Clear;
end;

constructor TSQLParameterDbl.Create(const Parameter: IParameter<Extended>);
begin
  _Parameter := Parameter;
end;

class function TSQLParameterDbl.New(const Name: String; const Value: Extended): ISQLParameter;
begin
  Result := Create(TParameter<Extended>.New(Name, Value));
end;

end.
