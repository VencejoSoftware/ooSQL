{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL syntax for OR NOT join object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit OrNotSQLJoin;

interface

uses
  SQLJoin;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLJoin))
  Resolve SQL OR NOT join as syntax. For example: OR NOT ...
  @member(Syntax @seealso(ISQLJoin.Syntax))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TOrNotSQLJoin = class sealed(TInterfacedObject, ISQLJoin)
  public
    function Syntax: String;
    class function New: ISQLJoin;
  end;

implementation

function TOrNotSQLJoin.Syntax: String;
begin
  Result := 'OR NOT';
end;

class function TOrNotSQLJoin.New: ISQLJoin;
begin
  Result := TOrNotSQLJoin.Create;
end;

end.
