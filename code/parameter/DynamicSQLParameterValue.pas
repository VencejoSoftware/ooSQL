{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter replaceable value syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit DynamicSQLParameterValue;

interface

uses
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameterValue))
  Return a syntax for a replaceable value, with the format :[VALUE]
  @member(Content @seealso(IBooleanSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Name Name for the replaceable value)
  )
  @member(
    New Create a new @classname as interface
    @param(Name Name for the replaceable value)
  )
}
{$ENDREGION}
  TDynamicSQLParameterValue = class sealed(TInterfacedObject, ISQLParameterValue)
  const
    DYNAMIC_PREFIX = ':';
  strict private
    _Name: String;
  public
    function Syntax: String;
    constructor Create(const Name: String);
    class function New(const Name: String): ISQLParameterValue;
  end;

implementation

function TDynamicSQLParameterValue.Syntax: String;
begin
  Result := DYNAMIC_PREFIX + _Name;
end;

constructor TDynamicSQLParameterValue.Create(const Name: String);
begin
  _Name := Name;
end;

class function TDynamicSQLParameterValue.New(const Name: String): ISQLParameterValue;
begin
  Result := TDynamicSQLParameterValue.Create(Name);
end;

end.
