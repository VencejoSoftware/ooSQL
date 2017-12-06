{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinNone;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TSQLJoinNone = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TSQLJoinNone.Parse(const Beautify: ITextBeautify): String;
begin
  Result := EmptyStr;
end;

function TSQLJoinNone.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLJoinNone.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TSQLJoinNone.New: IFilterJoin;
begin
  Result := TSQLJoinNone.Create;
end;

end.
