{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter unsigned integer value syntax object
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
  @abstract(SQL parameter unsigned integer value syntax object)
  Object to resolve a SQL parameter value with unsigned integers
  @member(
    Content Unsigned integer value
    @return(Unsigned integer value)
  )
}
{$ENDREGION}
  IUIntegerSQLParameterValue = interface(ISQLParameterValue)
    ['{62D506C7-5C7D-49A2-A96E-8884E4527AF1}']
    function Content: NativeUInt;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IUIntegerSQLParameterValue))
  Return the syntax value as unsigned integer text
  @member(Content @seealso(IUIntegerSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Content Unsigned integer value)
  )
  @member(
    New Create a new @classname as interface
    @param(Content Unsigned integer value)
  )
}
{$ENDREGION}

  TUIntegerSQLParameterValue = class sealed(TInterfacedObject, IUIntegerSQLParameterValue)
  strict private
    _Content: NativeUInt;
  public
    function Syntax: String;
    function Content: NativeUInt;
    constructor Create(const Content: NativeUInt);
    class function New(const Content: NativeUInt): IUIntegerSQLParameterValue;
  end;

implementation

function TUIntegerSQLParameterValue.Syntax: String;
begin
  Result := IntToStr(_Content);
end;

function TUIntegerSQLParameterValue.Content: NativeUInt;
begin
  Result := _Content;
end;

constructor TUIntegerSQLParameterValue.Create(const Content: NativeUInt);
begin
  _Content := Content;
end;

class function TUIntegerSQLParameterValue.New(const Content: NativeUInt): IUIntegerSQLParameterValue;
begin
  Result := TUIntegerSQLParameterValue.Create(Content);
end;

end.
