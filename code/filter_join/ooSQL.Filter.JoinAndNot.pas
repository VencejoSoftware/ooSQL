{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinAndNot;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooFilter.Join.Intf;

type
  TSQLJoinAndNot = class sealed(TInterfacedObject, IFilterJoin)
  public
    function Parse(const Beautify: ITextBeautify): String;
    function IsEmpty: Boolean;
    function IsReplaceable: Boolean;

    class function New: IFilterJoin;
  end;

implementation

function TSQLJoinAndNot.Parse(const Beautify: ITextBeautify): String;
begin
  Result := 'AND NOT';
end;

function TSQLJoinAndNot.IsEmpty: Boolean;
begin
  Result := False;
end;

function TSQLJoinAndNot.IsReplaceable: Boolean;
begin
  Result := False;
end;

class function TSQLJoinAndNot.New: IFilterJoin;
begin
  Result := TSQLJoinAndNot.Create;
end;

end.
