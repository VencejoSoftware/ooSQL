{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL syntax for AND join object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit AndSQLJoin;

interface

uses
  SQLJoin;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLJoin))
  Resolve SQL AND join as syntax. For example: AND ...
  @member(Syntax @seealso(ISQLJoin.Syntax))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TAndSQLJoin = class sealed(TInterfacedObject, ISQLJoin)
  public
    function Syntax: String;
    class function New: ISQLJoin;
  end;

implementation

function TAndSQLJoin.Syntax: String;
begin
  Result := 'AND';
end;

class function TAndSQLJoin.New: ISQLJoin;
begin
  Result := TAndSQLJoin.Create;
end;

end.
