{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Replaceable SQL parameter syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ReplaceableSQLParameter;

interface

uses
  SysUtils,
  SQLParameterValue,
  ReplaceableSQLParameterValue,
  MutableSQLParameter;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameter))
  Definition for replaceable parameters, using a format PREFIX + NAME, for example: :PARAM1, with mutable value
  @member(Name @seealso(ISQLParameter.Name))
  @member(Syntax @seealso(ISQLParameter.Syntax))
  @member(Value @seealso(ISQLParameter.Value))
  @member(IsNull @seealso(ISQLParameter.IsNull))
  @member(ChangeValue @seealso(ISQLParameter.ChangeValue))
  @member(Clear @seealso(ISQLParameter.Clear))
  @member(
    Create Object constructor
    @param(Name Name for replaceable parameter)
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
  @member(
    New Create a new @classname as interface
    @param(Name Name for replaceable parameter)
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
}
{$ENDREGION}
  TReplaceableSQLParameter = class sealed(TInterfacedObject, IMutableSQLParameter)
  strict private
    _Param: IMutableSQLParameter;
    _Syntax: String;
  public
    function Name: String;
    function Syntax: String;
    function Value: ISQLParameterValue;
    function IsNull: Boolean;
    procedure ChangeValue(const Value: ISQLParameterValue);
    procedure Clear;
    constructor Create(const Name: String; const UsePrefix: Boolean);
    class function New(const Name: String; const UsePrefix: Boolean = True): IMutableSQLParameter;
  end;

implementation

function TReplaceableSQLParameter.Name: String;
begin
  Result := _Param.Name;
end;

function TReplaceableSQLParameter.Syntax: String;
begin
  Result := _Syntax;
end;

function TReplaceableSQLParameter.Value: ISQLParameterValue;
begin
  Result := _Param.Value;
end;

function TReplaceableSQLParameter.IsNull: Boolean;
begin
  Result := _Param.IsNull;
end;

procedure TReplaceableSQLParameter.ChangeValue(const Value: ISQLParameterValue);
begin
  _Param.ChangeValue(Value);
end;

procedure TReplaceableSQLParameter.Clear;
begin
  _Param.Clear;
end;

constructor TReplaceableSQLParameter.Create(const Name: String; const UsePrefix: Boolean);
begin
  _Param := TMutableSQLParameter.New(Name);
  _Syntax := TReplaceableSQLParameterValue.New(Name, UsePrefix).Content;
end;

class function TReplaceableSQLParameter.New(const Name: String; const UsePrefix: Boolean): IMutableSQLParameter;
begin
  Result := TReplaceableSQLParameter.Create(Name, UsePrefix);
end;

end.
