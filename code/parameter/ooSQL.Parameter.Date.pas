{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.Date;

interface

uses
  SysUtils,
  ooFilter.Parameter, ooSQL.Parameter.Intf;
{$IFNDEF FPC}{$IF CompilerVersion > 21}{$DEFINE FormatSettingsScope}{$IFEND}{$ENDIF}

type
  TSQLParameterDate = class sealed(TInterfacedObject, ISQLParameter)
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

function TSQLParameterDate.IsNull: Boolean;
begin
  Result := _Parameter.IsNull;
end;

function TSQLParameterDate.Name: String;
begin
  Result := _Parameter.Name;
end;

function TSQLParameterDate.NameParsed: String;
begin
  Result := PARAMETER_PREFIX + Name;
end;

function TSQLParameterDate.ValueParsed: String;
begin
  if IsNull then
    Result := PARAMETER_NULL
  else
    Result := QuotedStr(FormatDateTime({$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortDateFormat,
      _Parameter.Value));
end;

procedure TSQLParameterDate.Clear;
begin
  _Parameter.Clear;
end;

constructor TSQLParameterDate.Create(const Parameter: IParameter<TDateTime>);
begin
  _Parameter := Parameter;
end;

class function TSQLParameterDate.New(const Name: String; const Value: TDateTime): ISQLParameter;
begin
  Result := Create(TParameter<TDateTime>.New(Name, Value));
end;

end.
