{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL ascending sort syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit AscendingSQLSort;

interface

uses
  SQLField,
  SQLSort;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLSort))
  Resolve SQL sort ascending as syntax. For example: [FIELD] DESC
  @member(Field @seealso(ISQLSort.Field))
  @member(Direction @seealso(ISQLSort.Direction))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Field Field to sort)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Field Field to sort)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}
  TAscendingSQLSort = class(TInterfacedObject, ISQLSort)
  strict private
    _Field: ISQLField;
  public
    function Field: ISQLField;
    function Direction: TSQLSortDirection;
    function Syntax: String;
    constructor Create(const Field: ISQLField);
    class function New(const Field: ISQLField): ISQLSort;
  end;

implementation

function TAscendingSQLSort.Field: ISQLField;
begin
  Result := _Field;
end;

function TAscendingSQLSort.Direction: TSQLSortDirection;
begin
  Result := Ascending;
end;

function TAscendingSQLSort.Syntax: String;
begin
  Result := Field.Name + ' ASC';
end;

constructor TAscendingSQLSort.Create(const Field: ISQLField);
begin
  _Field := Field;
end;

class function TAscendingSQLSort.New(const Field: ISQLField): ISQLSort;
begin
  Result := TAscendingSQLSort.Create(Field);
end;

end.
