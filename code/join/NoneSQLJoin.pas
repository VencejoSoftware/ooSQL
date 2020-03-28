{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL syntax for empty join object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit NoneSQLJoin;

interface

uses
  SysUtils,
  SQLJoin;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLJoin))
  Resolve SQL empty join as syntax.
  @member(Syntax @seealso(ISQLJoin.Syntax))
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TNoneSQLJoin = class sealed(TInterfacedObject, ISQLJoin)
  public
    function Syntax: String;
    class function New: ISQLJoin;
  end;

implementation

function TNoneSQLJoin.Syntax: String;
begin
  Result := EmptyStr;
end;

class function TNoneSQLJoin.New: ISQLJoin;
begin
  Result := TNoneSQLJoin.Create;
end;

end.
