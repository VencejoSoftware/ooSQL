{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinWhere;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TSQLJoinWhere = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TSQLJoinWhere.Parse(const Beautify: ITextBeautify): String;
begin
  Result := 'WHERE';
end;

function TSQLJoinWhere.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLJoinWhere.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TSQLJoinWhere.New: IFilterJoin;
begin
  Result := TSQLJoinWhere.Create;
end;

end.
