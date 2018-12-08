{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
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
  Key,
  SyntaxFormat,
  SQLSort;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLSort))
  Resolve SQL sort descending as syntax. For example: [KEY_FIELD] DESC
  @member(Key @seealso(ISQLSort.Key))
  @member(Direction @seealso(ISQLSort.Direction))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Key Field to sort)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Key Field to sort)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}
  TDescendingSQLSort = class(TInterfacedObject, ISQLSort)
  strict private
    _Key: ITextKey;
    _SyntaxFormat: ISyntaxFormat;
  public
    function Key: ITextKey;
    function Direction: TSQLSortDirection;
    function Syntax: String;
    constructor Create(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat);
    class function New(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat): ISQLSort;
  end;

implementation

function TDescendingSQLSort.Key: ITextKey;
begin
  Result := _Key;
end;

function TDescendingSQLSort.Direction: TSQLSortDirection;
begin
  Result := Descending;
end;

function TDescendingSQLSort.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([Key.Value, 'DESC'], [Spaced]);
end;

constructor TDescendingSQLSort.Create(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat);
begin
  _Key := Key;
  _SyntaxFormat := SyntaxFormat;
end;

class function TDescendingSQLSort.New(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat): ISQLSort;
begin
  Result := TDescendingSQLSort.Create(Key, SyntaxFormat);
end;

end.
