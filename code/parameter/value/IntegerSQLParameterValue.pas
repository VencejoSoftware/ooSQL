{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL integer parameter value content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit IntegerSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter integer value content)
  Object to resolve a SQL parameter value with integers
  @member(
    Value Integer value
    @return(Integer value)
  )
}
{$ENDREGION}
  IIntegerSQLParameterValue = interface(ISQLParameterValue)
    ['{4BC382A5-CBB4-4991-B7A0-72125096E444}']
    function Value: NativeInt;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IIntegerSQLParameterValue))
  Return value content as casted integer text
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(Value @seealso(IIntegerSQLParameterValue.Value))
  @member(
    Create Object constructor
    @param(Value Integer value)
  )
  @member(
    New Create a new @classname as interface
    @param(Value Integer value)
  )
}
{$ENDREGION}

  TIntegerSQLParameterValue = class sealed(TInterfacedObject, IIntegerSQLParameterValue)
  strict private
    _Value: NativeInt;
  public
    function Content: String;
    function Value: NativeInt;
    constructor Create(const Value: NativeInt);
    class function New(const Value: NativeInt): IIntegerSQLParameterValue;
  end;

implementation

function TIntegerSQLParameterValue.Content: String;
begin
  Result := IntToStr(_Value);
end;

function TIntegerSQLParameterValue.Value: NativeInt;
begin
  Result := _Value;
end;

constructor TIntegerSQLParameterValue.Create(const Value: NativeInt);
begin
  _Value := Value;
end;

class function TIntegerSQLParameterValue.New(const Value: NativeInt): IIntegerSQLParameterValue;
begin
  Result := TIntegerSQLParameterValue.Create(Value);
end;

end.
