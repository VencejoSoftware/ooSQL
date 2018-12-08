{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
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
  Key,
  SyntaxFormat,
  SQLSort;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLSort))
  Resolve SQL sort ascending as syntax. For example: [KEY_FIELD] DESC
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
  TAscendingSQLSort = class(TInterfacedObject, ISQLSort)
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

function TAscendingSQLSort.Key: ITextKey;
begin
  Result := _Key;
end;

function TAscendingSQLSort.Direction: TSQLSortDirection;
begin
  Result := Ascending;
end;

function TAscendingSQLSort.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([Key.Value, 'ASC'], [Spaced]);
end;

constructor TAscendingSQLSort.Create(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat);
begin
  _Key := Key;
  _SyntaxFormat := SyntaxFormat;
end;

class function TAscendingSQLSort.New(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat): ISQLSort;
begin
  Result := TAscendingSQLSort.Create(Key, SyntaxFormat);
end;

end.
