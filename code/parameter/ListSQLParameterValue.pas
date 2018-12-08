{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter list of values syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ListSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter value list type)
}
{$ENDREGION}
  TParameterValueItems = array of ISQLParameterValue;

{$REGION 'documentation'}
{
  @abstract(SQL parameter list of values syntax)
  Object to resolve a SQL value parameter list
  @member(
    Items List of parameter values
    @return(List object)
  )
}
{$ENDREGION}

  IListSQLParameterValue = interface(ISQLParameterValue)
    ['{6780F550-AB6D-4386-8430-1ABCF6638B87}']
    function Items: TParameterValueItems;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IListSQLParameterValue))
  Concatenate each parameter value syntax
  @member(Items @seealso(IListSQLParameterValue.Items))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Items Parameter value list)
  )
  @member(
    New Create a new @classname as interface
    @param(Items Parameter value list)
  )
}
{$ENDREGION}

  TListSQLParameterValue = class sealed(TInterfacedObject, IListSQLParameterValue)
  strict private
    _Items: TParameterValueItems;
  public
    function Syntax: String;
    function Items: TParameterValueItems;
    constructor Create(const Items: array of ISQLParameterValue);
    class function New(const Items: array of ISQLParameterValue): IListSQLParameterValue;
  end;

implementation

function TListSQLParameterValue.Syntax: String;
const
  LIST_SEPARATOR = ',';
var
  Item: ISQLParameterValue;
begin
  Result := EmptyStr;
  for Item in _Items do
    Result := Result + Item.Syntax + LIST_SEPARATOR;
  Result := Copy(Result, 1, Length(Result) - Length(LIST_SEPARATOR));
  Result := '(' + Result + ')';
end;

function TListSQLParameterValue.Items: TParameterValueItems;
begin
  Result := _Items;
end;

constructor TListSQLParameterValue.Create(const Items: array of ISQLParameterValue);
var
  i: Integer;
begin
  SetLength(_Items, Length(Items));
  for i := 0 to High(Items) do
    _Items[i] := Items[i];
end;

class function TListSQLParameterValue.New(const Items: array of ISQLParameterValue): IListSQLParameterValue;
begin
  Result := TListSQLParameterValue.Create(Items);
end;

end.
