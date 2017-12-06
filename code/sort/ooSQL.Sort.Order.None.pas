{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Sort.Order.None;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooSort.Order.Intf;

type
  TSQLSortOrderNone = class(TInterfacedObject, ISortOrder)
  public
    function Key: String;
    function Direction: TSortOrderDirection;
    function Parse(const Beautify: ITextBeautify): String;

    class function New: ISortOrder;
  end;

implementation

function TSQLSortOrderNone.Direction: TSortOrderDirection;
begin
  Result := sodAscending;
end;

function TSQLSortOrderNone.Key: String;
begin
  Result := EmptyStr;
end;

function TSQLSortOrderNone.Parse(const Beautify: ITextBeautify): String;
begin
  Result := EmptyStr;
end;

class function TSQLSortOrderNone.New: ISortOrder;
begin
  Result := TSQLSortOrderNone.Create;
end;

end.
