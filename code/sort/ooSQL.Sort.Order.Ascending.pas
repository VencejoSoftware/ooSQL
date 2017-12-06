{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Sort.Order.Ascending;

interface

uses
  ooText.Beautify.Intf,
  ooSort.Order.Intf;

type
  TSQLSortOrderAsc = class(TInterfacedObject, ISortOrder)
  strict private
    _Key: String;
  public
    function Key: String;
    function Direction: TSortOrderDirection;
    function Parse(const Beautify: ITextBeautify): String;

    constructor Create(const Key: String);

    class function New(const Key: String): ISortOrder;
  end;

implementation

function TSQLSortOrderAsc.Direction: TSortOrderDirection;
begin
  Result := sodAscending;
end;

function TSQLSortOrderAsc.Key: String;
begin
  Result := _Key;
end;

function TSQLSortOrderAsc.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, 'ASC']);
end;

constructor TSQLSortOrderAsc.Create(const Key: String);
begin
  _Key := Key;
end;

class function TSQLSortOrderAsc.New(const Key: String): ISortOrder;
begin
  Result := TSQLSortOrderAsc.Create(Key);
end;

end.
