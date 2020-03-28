{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL descending sort syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit DescendingSQLSort;

interface

uses
  SQLField,
  SQLSort;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLSort))
  Resolve SQL sort descending as syntax. For example: [FIELD] DESC
  @member(Field @seealso(ISQLSort.Field))
  @member(Direction @seealso(ISQLSort.Direction))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Field Field to sort)
  )
  @member(
    New Create a new @classname as interface
    @param(Field Field to sort)
  )
}
{$ENDREGION}
  TDescendingSQLSort = class(TInterfacedObject, ISQLSort)
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

function TDescendingSQLSort.Field: ISQLField;
begin
  Result := _Field;
end;

function TDescendingSQLSort.Direction: TSQLSortDirection;
begin
  Result := Descending;
end;

function TDescendingSQLSort.Syntax: String;
begin
  Result := Field.Name + ' DESC';
end;

constructor TDescendingSQLSort.Create(const Field: ISQLField);
begin
  _Field := Field;
end;

class function TDescendingSQLSort.New(const Field: ISQLField): ISQLSort;
begin
  Result := TDescendingSQLSort.Create(Field);
end;

end.
