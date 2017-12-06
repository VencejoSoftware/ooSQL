{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Sort.Order.Descending;

interface

uses
  ooText.Beautify.Intf,
  ooSort.Order.Intf;

type
  TSQLSortOrderDesc = class(TInterfacedObject, ISortOrder)
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

function TSQLSortOrderDesc.Direction: TSortOrderDirection;
begin
  Result := sodDescending;
end;

function TSQLSortOrderDesc.Key: String;
begin
  Result := _Key;
end;

function TSQLSortOrderDesc.Parse(const Beautify: ITextBeautify): String;
begin
  Result := Beautify.Apply([_Key, 'DESC']);
end;

constructor TSQLSortOrderDesc.Create(const Key: String);
begin
  _Key := Key;
end;

class function TSQLSortOrderDesc.New(const Key: String): ISortOrder;
begin
  Result := TSQLSortOrderDesc.Create(Key);
end;

end.
