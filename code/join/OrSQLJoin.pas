{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL syntax for OR join object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit OrSQLJoin;

interface

uses
  SQLJoin;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLJoin))
  Resolve SQL OR join as syntax. For example: OR  ...
  @member(Syntax @seealso(ISQLJoin.Syntax))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TOrSQLJoin = class sealed(TInterfacedObject, ISQLJoin)
  public
    function Syntax: String;
    class function New: ISQLJoin;
  end;

implementation

function TOrSQLJoin.Syntax: String;
begin
  Result := 'OR';
end;

class function TOrSQLJoin.New: ISQLJoin;
begin
  Result := TOrSQLJoin.Create;
end;

end.
