{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.TimeStamp;

interface

uses
  SysUtils,
  ooFilter.Parameter, ooSQL.Parameter.Intf;

type
  TSQLParameterTimeStamp = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Parameter: IParameter<TDateTime>;
  public
    function Name: String;
    function IsNull: Boolean;
    function NameParsed: String;
    function ValueParsed: String;

    procedure Clear;

    constructor Create(const Parameter: IParameter<TDateTime>);

    class function New(const Name: String; const Value: TDateTime): ISQLParameter;
  end;

implementation

function TSQLParameterTimeStamp.IsNull: Boolean;
begin
  Result := _Parameter.IsNull;
end;

function TSQLParameterTimeStamp.Name: String;
begin
  Result := _Parameter.Name;
end;

function TSQLParameterTimeStamp.NameParsed: String;
begin
  Result := PARAMETER_PREFIX + Name;
end;

function TSQLParameterTimeStamp.ValueParsed: String;
begin
  if IsNull then
    Result := PARAMETER_NULL
  else
    Result := QuotedStr(DateTimeToStr(_Parameter.Value));
end;

procedure TSQLParameterTimeStamp.Clear;
begin
  _Parameter.Clear;
end;

constructor TSQLParameterTimeStamp.Create(const Parameter: IParameter<TDateTime>);
begin
  _Parameter := Parameter;
end;

class function TSQLParameterTimeStamp.New(const Name: String; const Value: TDateTime): ISQLParameter;
begin
  Result := Create(TParameter<TDateTime>.New(Name, Value));
end;

end.
