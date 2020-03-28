{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL none sort syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit NoneSQLSort;

interface

uses
  SysUtils,
  SQLField,
  SQLSort;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLSort))
  @member(Field @seealso(ISQLSort.Field))
  @member(Direction @seealso(ISQLSort.Direction))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TNoneSQLSort = class(TInterfacedObject, ISQLSort)
  public
    function Field: ISQLField;
    function Direction: TSQLSortDirection;
    function Syntax: String;
    class function New: ISQLSort;
  end;

implementation

function TNoneSQLSort.Field: ISQLField;
begin
  Result := nil;
end;

function TNoneSQLSort.Direction: TSQLSortDirection;
begin
  Result := None;
end;

function TNoneSQLSort.Syntax: String;
begin
  Result := EmptyStr;
end;

class function TNoneSQLSort.New: ISQLSort;
begin
  Result := TNoneSQLSort.Create;
end;

end.
