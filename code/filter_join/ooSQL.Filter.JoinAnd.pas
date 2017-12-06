{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinAnd;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TSQLJoinAnd = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TSQLJoinAnd.Parse(const Beautify: ITextBeautify): String;
begin
  Result := 'AND';
end;

function TSQLJoinAnd.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLJoinAnd.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TSQLJoinAnd.New: IFilterJoin;
begin
  Result := TSQLJoinAnd.Create;
end;

end.
