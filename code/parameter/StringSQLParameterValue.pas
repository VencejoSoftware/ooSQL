{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter string value syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit StringSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter string value syntax)
  Object to resolve a SQL parameter value with strings
  @member(
    Content String value
    @return(String value)
  )
}
{$ENDREGION}
  IStringSQLParameterValue = interface(ISQLParameterValue)
    ['{1CB252E0-80EB-43EC-8DA1-2D0E02B576EF}']
    function Content: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameterValue))
  Return the syntax value as string
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Content String value)
  )
  @member(
    New Create a new @classname as interface
    @param(Content String value)
  )
}
{$ENDREGION}

  TStringSQLParameterValue = class sealed(TInterfacedObject, IStringSQLParameterValue)
  strict private
    _Content: String;
  public
    function Syntax: String;
    function Content: String;
    constructor Create(const Content: String);
    class function New(const Content: String): IStringSQLParameterValue;
  end;

implementation

function TStringSQLParameterValue.Syntax: String;
begin
  Result := QuotedStr(_Content);
end;

function TStringSQLParameterValue.Content: String;
begin
  Result := _Content;
end;

constructor TStringSQLParameterValue.Create(const Content: String);
begin
  _Content := Content;
end;

class function TStringSQLParameterValue.New(const Content: String): IStringSQLParameterValue;
begin
  Result := TStringSQLParameterValue.Create(Content);
end;

end.
