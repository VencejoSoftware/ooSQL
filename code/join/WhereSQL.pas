{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL syntax for WHERE join object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit WhereSQL;

interface

uses
  SQLJoin;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLJoin))
  Resolve SQL WHERE join as syntax. For example: WHERE ...
  @member(Syntax @seealso(ISQLJoin.Syntax))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TWhereSQL = class sealed(TInterfacedObject, ISQLJoin)
  public
    function Syntax: String;
    class function New: ISQLJoin;
  end;

implementation

function TWhereSQL.Syntax: String;
begin
  Result := 'WHERE';
end;

class function TWhereSQL.New: ISQLJoin;
begin
  Result := TWhereSQL.Create;
end;

end.
