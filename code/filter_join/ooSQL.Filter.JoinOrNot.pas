{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinOrNot;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TSQLJoinOrNot = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TSQLJoinOrNot.Parse(const Beautify: ITextBeautify): String;
begin
  Result := 'OR NOT';
end;

function TSQLJoinOrNot.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLJoinOrNot.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TSQLJoinOrNot.New: IFilterJoin;
begin
  Result := TSQLJoinOrNot.Create;
end;

end.
