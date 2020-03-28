{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL sorting object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLSort;

interface

uses
  SQLField,
  Statement;

type
{$REGION 'documentation'}
{
  Enum for sort direction
  @value None Skip sort
  @value Ascending Ascending sort
  @value Descending Descending sort
}
{$ENDREGION}
  TSQLSortDirection = (None, Ascending, Descending);

{$REGION 'documentation'}
{
  @abstract(SQL sorting object)
  Object to resolve a SQL sort syntax
  @member(
    Key Field to sort
    @return(@link(ISQLField Field object))
  )
  @member(
    Direction Sort kind direction
    @return(@link(TSQLSortDirection Sort direction))
  )
}
{$ENDREGION}

  ISQLSort = interface(IStatement)
    ['{F27AB525-F4AD-4816-B4C4-D5C8C09A36B5}']
    function Field: ISQLField;
    function Direction: TSQLSortDirection;
  end;

implementation

end.
