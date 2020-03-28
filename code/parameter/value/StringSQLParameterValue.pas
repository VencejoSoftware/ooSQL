{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL string parameter value content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit StringSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter string value content)
  Object to resolve a SQL parameter value as a string
  @member(
    Value String value
    @return(String value)
  )
}
{$ENDREGION}
  IStringSQLParameterValue = interface(ISQLParameterValue)
    ['{1CB252E0-80EB-43EC-8DA1-2D0E02B576EF}']
    function Value: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameterValue))
  Return the Content value as string
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(Value @seealso(ISQLParameterValue.Value))
  @member(
    Create Object constructor
    @param(Value String value)
  )
  @member(
    New Create a new @classname as interface
    @param(Value String value)
  )
}
{$ENDREGION}

  TStringSQLParameterValue = class sealed(TInterfacedObject, IStringSQLParameterValue)
  strict private
    _Value: String;
  public
    function Content: String;
    function Value: String;
    constructor Create(const Value: String);
    class function New(const Value: String): IStringSQLParameterValue;
  end;

implementation

function TStringSQLParameterValue.Content: String;
begin
  Result := QuotedStr(_Value);
end;

function TStringSQLParameterValue.Value: String;
begin
  Result := _Value;
end;

constructor TStringSQLParameterValue.Create(const Value: String);
begin
  _Value := Value;
end;

class function TStringSQLParameterValue.New(const Value: String): IStringSQLParameterValue;
begin
  Result := TStringSQLParameterValue.Create(Value);
end;

end.
