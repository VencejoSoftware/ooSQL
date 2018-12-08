{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter integer value syntax object
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
  @abstract(SQL parameter integer value syntax)
  Object to resolve a SQL parameter value with integers
  @member(
    Content Integer value
    @return(Integer value)
  )
}
{$ENDREGION}
  IIntegerSQLParameterValue = interface(ISQLParameterValue)
    ['{4BC382A5-CBB4-4991-B7A0-72125096E444}']
    function Content: NativeInt;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IIntegerSQLParameterValue))
  Return value syntax as casted integer text
  @member(Content @seealso(IIntegerSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Content Integer value)
  )
  @member(
    New Create a new @classname as interface
    @param(Content Integer value)
  )
}
{$ENDREGION}

  TIntegerSQLParameterValue = class sealed(TInterfacedObject, IIntegerSQLParameterValue)
  strict private
    _Content: NativeInt;
  public
    function Syntax: String;
    function Content: NativeInt;
    constructor Create(const Content: NativeInt);
    class function New(const Content: NativeInt): IIntegerSQLParameterValue;
  end;

implementation

function TIntegerSQLParameterValue.Syntax: String;
begin
  Result := IntToStr(_Content);
end;

function TIntegerSQLParameterValue.Content: NativeInt;
begin
  Result := _Content;
end;

constructor TIntegerSQLParameterValue.Create(const Content: NativeInt);
begin
  _Content := Content;
end;

class function TIntegerSQLParameterValue.New(const Content: NativeInt): IIntegerSQLParameterValue;
begin
  Result := TIntegerSQLParameterValue.Create(Content);
end;

end.
