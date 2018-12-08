{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter boolean value syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit BooleanSQLParameterValue;

interface

uses
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter boolean value syntax)
  Object to resolve a SQL parameter value with booleans
  @member(
    Content Boolean value
    @return(Boolean value)
  )
}
{$ENDREGION}
  IBooleanSQLParameterValue = interface(ISQLParameterValue)
    ['{612376F9-C4E5-481B-BE1C-EFD695B407E5}']
    function Content: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBooleanSQLParameterValue))
  Return the syntax value in '0' and '1' for false and true
  @member(Content @seealso(IBooleanSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Content Boolean value)
  )
  @member(
    New Create a new @classname as interface
    @param(Content Boolean value)
  )
}
{$ENDREGION}

  TBooleanSQLParameterValue = class sealed(TInterfacedObject, IBooleanSQLParameterValue)
  strict private
    _Content: Boolean;
  public
    function Syntax: String;
    function Content: Boolean;
    constructor Create(const Content: Boolean);
    class function New(const Content: Boolean): IBooleanSQLParameterValue;
  end;

implementation

function TBooleanSQLParameterValue.Syntax: String;
const
  BOOLEAN_VALUE: array [Boolean] of char = ('0', '1');
begin
  Result := BOOLEAN_VALUE[Content];
end;

function TBooleanSQLParameterValue.Content: Boolean;
begin
  Result := _Content;
end;

constructor TBooleanSQLParameterValue.Create(const Content: Boolean);
begin
  _Content := Content;
end;

class function TBooleanSQLParameterValue.New(const Content: Boolean): IBooleanSQLParameterValue;
begin
  Result := TBooleanSQLParameterValue.Create(Content);
end;

end.
