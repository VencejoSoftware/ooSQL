{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL syntax for AND NOT join object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit AndNotSQLJoin;

interface

uses
  SQLJoin;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLJoin))
  Resolve SQL AND NOT join as syntax. For example: AND NOT ...
  @member(Syntax @seealso(ISQLJoin.Syntax))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TAndNotSQLJoin = class sealed(TInterfacedObject, ISQLJoin)
  public
    function Syntax: String;
    class function New: ISQLJoin;
  end;

implementation

function TAndNotSQLJoin.Syntax: String;
begin
  Result := 'AND NOT';
end;

class function TAndNotSQLJoin.New: ISQLJoin;
begin
  Result := TAndNotSQLJoin.Create;
end;

end.
