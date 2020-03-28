{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL unsigned integer parameter value content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit UIntegerSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter unsigned integer value Content object)
  Object to resolve a SQL parameter value with unsigned integers
  @member(
    Value Unsigned integer value
    @return(Unsigned integer value)
  )
}
{$ENDREGION}
  IUIntegerSQLParameterValue = interface(ISQLParameterValue)
    ['{62D506C7-5C7D-49A2-A96E-8884E4527AF1}']
    function Value: NativeUInt;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IUIntegerSQLParameterValue))
  Returns the unsigned integer content value as plain text
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(Value @seealso(IUIntegerSQLParameterValue.Value))
  @member(
    Create Object constructor
    @param(Value Unsigned integer value)
  )
  @member(
    New Create a new @classname as interface
    @param(Value Unsigned integer value)
  )
}
{$ENDREGION}

  TUIntegerSQLParameterValue = class sealed(TInterfacedObject, IUIntegerSQLParameterValue)
  strict private
    _Value: NativeUInt;
  public
    function Content: String;
    function Value: NativeUInt;
    constructor Create(const Value: NativeUInt);
    class function New(const Value: NativeUInt): IUIntegerSQLParameterValue;
  end;

implementation

function TUIntegerSQLParameterValue.Content: String;
begin
  Result := IntToStr(_Value);
end;

function TUIntegerSQLParameterValue.Value: NativeUInt;
begin
  Result := _Value;
end;

constructor TUIntegerSQLParameterValue.Create(const Value: NativeUInt);
begin
  _Value := Value;
end;

class function TUIntegerSQLParameterValue.New(const Value: NativeUInt): IUIntegerSQLParameterValue;
begin
  Result := TUIntegerSQLParameterValue.Create(Value);
end;

end.
