{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
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
  Key,
  SQLSort;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLSort))
  @member(Key @seealso(ISQLSort.Key))
  @member(Direction @seealso(ISQLSort.Direction))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}
  TNoneSQLSort = class(TInterfacedObject, ISQLSort)
  public
    function Key: ITextKey;
    function Direction: TSQLSortDirection;
    function Syntax: String;
    class function New: ISQLSort;
  end;

implementation

function TNoneSQLSort.Key: ITextKey;
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
