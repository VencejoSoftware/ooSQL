{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL NULL parameter value content object
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
  Return NULL value as plain text
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(Create Object constructor)
  @member(New Create a new @classname as interface)
}
{$ENDREGION}
  TNullSQLParameterValue = class sealed(TInterfacedObject, ISQLParameterValue)
  public
    function Content: String;
    class function New: ISQLParameterValue;
  end;

implementation

function TNullSQLParameterValue.Content: String;
begin
  Result := 'NULL';
end;

class function TNullSQLParameterValue.New: ISQLParameterValue;
begin
  Result := TNullSQLParameterValue.Create;
end;

end.
