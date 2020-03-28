{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL date-time parameter content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit DateTimeSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue;

{$IFNDEF FPC}{$IF CompilerVersion > 21}{$DEFINE FormatSettingsScope}{$IFEND}{$ENDIF}

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter date value Content)
  Object to resolve a SQL parameter value with TDatetimes
  @member(
    Value Date-time value
    @return(Date-time value)
  )
}
{$ENDREGION}
  IDateTimeSQLParameterValue = interface(ISQLParameterValue)
    ['{D9B9D881-2EA1-43D3-844E-DDDA6A9C8E86}']
    function Value: TDateTime;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBooleanSQLParameterValue))
  Return the content value as a formatted date-time
  @member(Value @seealso(IDateSQLParameterValue.Value))
  @member(Content @seealso(IStatement.Content))
  @member(
    Create Object constructor
    @param(Value TDatetime value)
    @param(Format Date-time format template)
  )
  @member(
    New Create a new @classname as interface
    @param(Value TDate value)
    @param(Format TDatetime format template)
  )
  @member(
    NewDefault Create a new @classname as interface with the default short datetime format setting
    @param(Value TDatetime value)
  )
}
{$ENDREGION}

  TDateTimeSQLParameterValue = class sealed(TInterfacedObject, IDateTimeSQLParameterValue)
  const
    DATE_TIME_FORMAT = 'DD/MM/YYYY hh:nn:ss';
  strict private
    _Value: TDateTime;
    _Format: String;
  public
    function Content: String;
    function Value: TDateTime;
    constructor Create(const Value: TDateTime; const Format: String);
    class function New(const Value: TDateTime; const Format: String = DATE_TIME_FORMAT): IDateTimeSQLParameterValue;
    class function NewDefault(const Value: TDateTime): IDateTimeSQLParameterValue;
  end;

implementation

function TDateTimeSQLParameterValue.Content: String;
begin
  Result := QuotedStr(FormatDateTime(_Format, _Value));
end;

function TDateTimeSQLParameterValue.Value: TDateTime;
begin
  Result := _Value;
end;

constructor TDateTimeSQLParameterValue.Create(const Value: TDateTime; const Format: String);
begin
  _Format := Format;
  _Value := Value;
end;

class function TDateTimeSQLParameterValue.New(const Value: TDateTime; const Format: String): IDateTimeSQLParameterValue;
begin
  Result := TDateTimeSQLParameterValue.Create(Value, Format);
end;

class function TDateTimeSQLParameterValue.NewDefault(const Value: TDateTime): IDateTimeSQLParameterValue;
begin
  Result := TDateTimeSQLParameterValue.New(Value,
{$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortDateFormat + ' ' +
{$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortTimeFormat);
end;

end.
