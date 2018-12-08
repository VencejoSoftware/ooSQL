{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter NULL value syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit NullSQLParameterValue;

interface

uses
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameterValue))
  Return the syntax for NULL value
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
  )
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}
  TNullSQLParameterValue = class sealed(TInterfacedObject, ISQLParameterValue)
  public
    function Syntax: String;
    class function New: ISQLParameterValue;
  end;

implementation

function TNullSQLParameterValue.Syntax: String;
begin
  Result := 'NULL';
end;

class function TNullSQLParameterValue.New: ISQLParameterValue;
begin
  Result := TNullSQLParameterValue.Create;
end;

end.
