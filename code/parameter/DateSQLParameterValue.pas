{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter date value syntax object
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
    Content Date value
    @return(Date value)
  )
}
{$ENDREGION}
  IDateSQLParameterValue = interface(ISQLParameterValue)
    ['{D67E27E7-BEE2-4574-9E66-4F44A16E5CB1}']
    function Content: TDate;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBooleanSQLParameterValue))
  Return the syntax value as a TDate formatted
  @member(Content @seealso(IDateSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Content TDate value)
    @param(Format Date format template)
  )
  @member(
    New Create a new @classname as interface
    @param(Content TDate value)
    @param(Format Date format template)
  )
  @member(
    NewDefault Create a new @classname as interface with the default short date format setting
    @param(Content TDate value)
  )
}
{$ENDREGION}

  TDateSQLParameterValue = class sealed(TInterfacedObject, IDateSQLParameterValue)
  strict private
    _Content: TDate;
    _Format: String;
  public
    function Syntax: String;
    function Content: TDate;
    constructor Create(const Content: TDate; const Format: String);
    class function New(const Content: TDate; const Format: String): IDateSQLParameterValue;
    class function NewDefault(const Content: TDate): IDateSQLParameterValue;
  end;

implementation

function TDateSQLParameterValue.Syntax: String;
begin
  Result := QuotedStr(FormatDateTime(_Format, _Content));
end;

function TDateSQLParameterValue.Content: TDate;
begin
  Result := _Content;
end;

constructor TDateSQLParameterValue.Create(const Content: TDate; const Format: String);
begin
  _Format := Format;
  _Content := Content;
end;

class function TDateSQLParameterValue.New(const Content: TDate; const Format: String): IDateSQLParameterValue;
begin
  Result := TDateSQLParameterValue.Create(Content, Format);
end;

class function TDateSQLParameterValue.NewDefault(const Content: TDate): IDateSQLParameterValue;
begin
  Result := TDateSQLParameterValue.New(Content, {$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortDateFormat);
end;

end.
