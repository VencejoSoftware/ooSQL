{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Static/constant parameter object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit StaticSQLParameter;

interface

uses
  SysUtils,
  SQLParameter,
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameter))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(Name @seealso(ISQLParameter.Name))
  @member(Value @seealso(ISQLParameter.Value))
  @member(IsNull @seealso(ISQLParameter.IsNull))
  @member(
    Create Object constructor
    @param(Name Parameter name)
  )
  @member(
    New Create a new @classname as interface
    @param(Name Parameter name)
    @param(Value @link(ISQLParameterValue Value Parameter value))
  )
  @member(
    NewWithOutName Create a new @classname as interface without a specific name
    @param(Value @link(ISQLParameterValue Value Parameter value))
  )
}
{$ENDREGION}
  TStaticSQLParameter = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Name: String;
    _Value: ISQLParameterValue;
  public
    function Name: String;
    function Syntax: String;
    function Value: ISQLParameterValue;
    function IsNull: Boolean;
    constructor Create(const Name: String; const Value: ISQLParameterValue);
    class function New(const Name: String; const Value: ISQLParameterValue = nil): ISQLParameter;
    class function NewWithOutName(const Value: ISQLParameterValue): ISQLParameter;
  end;

implementation

function TStaticSQLParameter.Name: String;
begin
  Result := _Name;
end;

function TStaticSQLParameter.Syntax: String;
begin
  Result := _Name;
end;

function TStaticSQLParameter.Value: ISQLParameterValue;
begin
  Result := _Value;
end;

function TStaticSQLParameter.IsNull: Boolean;
begin
  Result := not Assigned(_Value);
end;

constructor TStaticSQLParameter.Create(const Name: String; const Value: ISQLParameterValue);
begin
  _Name := Name;
  _Value := Value;
end;

class function TStaticSQLParameter.New(const Name: String; const Value: ISQLParameterValue): ISQLParameter;
begin
  Result := TStaticSQLParameter.Create(Name, Value);
end;

class function TStaticSQLParameter.NewWithOutName(const Value: ISQLParameterValue): ISQLParameter;
begin
  Result := TStaticSQLParameter.New(EmptyStr, Value);
end;

end.
