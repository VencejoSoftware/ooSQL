{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter replaceable/dynamic syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit DynamicSQLParameter;

interface

uses
  SQLParameterValue,
  SQLParameter;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameter))
  Definition for replaceable parameters, using a format PREFIX + NAME, for example: :PARAM1
  @member(Name @seealso(ISQLParameter.Name))
  @member(Syntax @seealso(ISQLParameter.Syntax))
  @member(Value @seealso(ISQLParameter.Value))
  @member(IsNull @seealso(ISQLParameter.IsNull))
  @member(ChangeValue @seealso(ISQLParameter.ChangeValue))
  @member(Clear @seealso(ISQLParameter.Clear))
  @member(
    Create Object constructor
    @param(Name Name for replaceable parameter)
  )
  @member(
    New Create a new @classname as interface
    @param(Name Name for replaceable parameter)
  )
}
{$ENDREGION}
  TDynamicSQLParameter = class sealed(TInterfacedObject, ISQLParameter)
  const
    DYNAMIC_PREFIX = ':';
  strict private
    _Param: ISQLParameter;
  public
    function Name: String;
    function Syntax: String;
    function Value: ISQLParameterValue;
    function IsNull: Boolean;
    procedure ChangeValue(const Value: ISQLParameterValue);
    procedure Clear;
    constructor Create(const Name: String);
    class function New(const Name: String): ISQLParameter;
  end;

implementation

function TDynamicSQLParameter.Name: String;
begin
  Result := _Param.Name;
end;

function TDynamicSQLParameter.Syntax: String;
begin
  Result := DYNAMIC_PREFIX + _Param.Name;
end;

function TDynamicSQLParameter.Value: ISQLParameterValue;
begin
  Result := _Param.Value;
end;

function TDynamicSQLParameter.IsNull: Boolean;
begin
  Result := _Param.IsNull;
end;

procedure TDynamicSQLParameter.ChangeValue(const Value: ISQLParameterValue);
begin
  _Param.ChangeValue(Value);
end;

procedure TDynamicSQLParameter.Clear;
begin
  _Param.Clear;
end;

constructor TDynamicSQLParameter.Create(const Name: String);
begin
  _Param := TSQLParameter.New(Name);
end;

class function TDynamicSQLParameter.New(const Name: String): ISQLParameter;
begin
  Result := TDynamicSQLParameter.Create(Name);
end;

end.
