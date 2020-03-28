{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL date parameter content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit DateSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue;

{$IFNDEF FPC}{$IF CompilerVersion > 21}{$DEFINE FormatSettingsScope}{$IFEND}{$ENDIF}

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter date value syntax)
  Object to resolve a SQL parameter value with TDates
  @member(
    Value Date value
    @return(Date value)
  )
}
{$ENDREGION}
  IDateSQLParameterValue = interface(ISQLParameterValue)
    ['{D67E27E7-BEE2-4574-9E66-4F44A16E5CB1}']
    function Value: TDate;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBooleanSQLParameterValue))
  Return the content value as a formatted date
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(Value @seealso(IDateSQLParameterValue.Value))
  @member(
    Create Object constructor
    @param(Value TDate value)
    @param(Format Date format template)
  )
  @member(
    New Create a new @classname as interface
    @param(Value TDate value)
    @param(Format Date format template)
  )
  @member(
    NewDefault Create a new @classname as interface with the default short date format setting
    @param(Value TDate value)
  )
}
{$ENDREGION}

  TDateSQLParameterValue = class sealed(TInterfacedObject, IDateSQLParameterValue)
  const
    DATE_FORMAT = 'DD/MM/YYYY';
  strict private
    _Value: TDate;
    _Format: String;
  public
    function Content: String;
    function Value: TDate;
    constructor Create(const Value: TDate; const Format: String);
    class function New(const Value: TDate; const Format: String = DATE_FORMAT): IDateSQLParameterValue;
    class function NewDefault(const Value: TDate): IDateSQLParameterValue;
  end;

implementation

function TDateSQLParameterValue.Content: String;
begin
  Result := QuotedStr(FormatDateTime(_Format, _Value));
end;

function TDateSQLParameterValue.Value: TDate;
begin
  Result := _Value;
end;

constructor TDateSQLParameterValue.Create(const Value: TDate; const Format: String);
begin
  _Format := Format;
  _Value := Value;
end;

class function TDateSQLParameterValue.New(const Value: TDate; const Format: String): IDateSQLParameterValue;
begin
  Result := TDateSQLParameterValue.Create(Value, Format);
end;

class function TDateSQLParameterValue.NewDefault(const Value: TDate): IDateSQLParameterValue;
begin
  Result := TDateSQLParameterValue.New(Value, {$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortDateFormat);
end;

end.
