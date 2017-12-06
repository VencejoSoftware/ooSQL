{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinOr;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TSQLJoinOr = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TSQLJoinOr.Parse(const Beautify: ITextBeautify): String;
begin
  Result := 'OR';
end;

function TSQLJoinOr.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLJoinOr.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TSQLJoinOr.New: IFilterJoin;
begin
  Result := TSQLJoinOr.Create;
end;

end.
