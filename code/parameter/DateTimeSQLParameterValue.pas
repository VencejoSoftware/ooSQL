{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter date-time value syntax object
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
  @abstract(SQL parameter date value syntax)
  Object to resolve a SQL parameter value with TDatetimes
  @member(
    Content Date-time value
    @return(Date-time value)
  )
}
{$ENDREGION}
  IDateTimeSQLParameterValue = interface(ISQLParameterValue)
    ['{D9B9D881-2EA1-43D3-844E-DDDA6A9C8E86}']
    function Content: TDateTime;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBooleanSQLParameterValue))
  Return the syntax value as a TDate formatted
  @member(Content @seealso(IDateSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Content TDatetime value)
    @param(Format Date-time format template)
  )
  @member(
    New Create a new @classname as interface
    @param(Content TDate value)
    @param(Format TDatetime format template)
  )
  @member(
    NewDefault Create a new @classname as interface with the default short datetime format setting
    @param(Content TDatetime value)
  )
}
{$ENDREGION}

  TDateTimeSQLParameterValue = class sealed(TInterfacedObject, IDateTimeSQLParameterValue)
  strict private
    _Content: TDateTime;
    _Format: String;
  public
    function Syntax: String;
    function Content: TDateTime;
    constructor Create(const Content: TDateTime; const Format: String);
    class function New(const Content: TDateTime; const Format: String): IDateTimeSQLParameterValue;
    class function NewDefault(const Content: TDateTime): IDateTimeSQLParameterValue;
  end;

implementation

function TDateTimeSQLParameterValue.Syntax: String;
begin
  Result := QuotedStr(FormatDateTime(_Format, _Content));
end;

function TDateTimeSQLParameterValue.Content: TDateTime;
begin
  Result := _Content;
end;

constructor TDateTimeSQLParameterValue.Create(const Content: TDateTime; const Format: String);
begin
  _Format := Format;
  _Content := Content;
end;

class function TDateTimeSQLParameterValue.New(const Content: TDateTime; const Format: String)
  : IDateTimeSQLParameterValue;
begin
  Result := TDateTimeSQLParameterValue.Create(Content, Format);
end;

class function TDateTimeSQLParameterValue.NewDefault(const Content: TDateTime): IDateTimeSQLParameterValue;
begin
  Result := TDateTimeSQLParameterValue.New(Content,
{$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortDateFormat + ' ' +
{$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortTimeFormat);
end;

end.
