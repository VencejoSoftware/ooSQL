{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.Text;

interface

uses
  SysUtils,
  ooFilter.Parameter, ooSQL.Parameter.Intf;

type
  TSQLParameterText = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Parameter: IParameter<String>;
  public
    function Name: String;
    function IsNull: Boolean;
    function NameParsed: String;
    function ValueParsed: String;

    procedure Clear;

    constructor Create(const Parameter: IParameter<String>);

    class function New(const Name: String; const Value: String): ISQLParameter;
  end;

implementation

function TSQLParameterText.IsNull: Boolean;
begin
  Result := _Parameter.IsNull;
end;

function TSQLParameterText.Name: String;
begin
  Result := _Parameter.Name;
end;

function TSQLParameterText.NameParsed: String;
begin
  Result := PARAMETER_PREFIX + Name;
end;

function TSQLParameterText.ValueParsed: String;
begin
  if IsNull then
    Result := PARAMETER_NULL
  else
    Result := _Parameter.Value;
end;

procedure TSQLParameterText.Clear;
begin
  _Parameter.Clear;
end;

constructor TSQLParameterText.Create(const Parameter: IParameter<String>);
begin
  _Parameter := Parameter;
end;

class function TSQLParameterText.New(const Name: String; const Value: String): ISQLParameter;
begin
  Result := Create(TParameter<String>.New(Name, Value));
end;

end.
