{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Dynamic SQL parameter object, using a callback to resolve value content
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit DynamicSQLParameter;

interface

uses
  SQLParameter,
  SQLParameterValue,
  ReplaceableSQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(Callback to resolve parameter value)
  @member(Parameter @seealso(ISQLParameter SQL parameter object))
  @return(@link(ISQLParameterValue Value object))
}
{$ENDREGION}
{$IFDEF FPC}
  TSQLParameterValueCallback = function(const Parameter: ISQLParameter): ISQLParameterValue;
  TSQLParameterValueCallbackOfObject = function(const Parameter: ISQLParameter): ISQLParameterValue of object;
{$ELSE}
  TSQLParameterValueCallback = reference to function(const Parameter: ISQLParameter): ISQLParameterValue;
{$ENDIF}
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameter))
  Parameter object which resolves the value content executing a callback
  @member(Name @seealso(ISQLParameter.Name))
  @member(Syntax @seealso(ISQLParameter.Syntax))
  @member(Value @seealso(ISQLParameter.Value))
  @member(IsNull @seealso(ISQLParameter.IsNull))
  @member(
    Create Object constructor
    @param(Name Name for replaceable parameter)
    @param(ValueCallback @link(TSQLParameterValueCallback Callback to resolve value content))
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
  @member(
    New Create a new @classname as interface
    @param(Name Name for replaceable parameter)
    @param(ValueCallback @link(TSQLParameterValueCallback Callback to resolve value content))
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
}
{$ENDREGION}

  TDynamicSQLParameter = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Name: String;
    _ValueCallback: TSQLParameterValueCallback;
{$IFDEF FPC}_ValueCallbackOfObject: TSQLParameterValueCallbackOfObject; {$ENDIF}
    _Syntax: String;
  public
    function Name: String;
    function Syntax: String;
    function Value: ISQLParameterValue;
    function IsNull: Boolean;
    constructor Create(const Name: String; const ValueCallback: TSQLParameterValueCallback;
{$IFDEF FPC}const ValueCallbackOfObject: TSQLParameterValueCallbackOfObject; {$ENDIF} const UsePrefix: Boolean);
    class function New(const Name: String; const ValueCallback: TSQLParameterValueCallback;
{$IFDEF FPC}const ValueCallbackOfObject: TSQLParameterValueCallbackOfObject; {$ENDIF}
      const UsePrefix: Boolean = True): ISQLParameter;
  end;

implementation

function TDynamicSQLParameter.Name: String;
begin
  Result := _Name;
end;

function TDynamicSQLParameter.Syntax: String;
begin
  Result := _Syntax;
end;

function TDynamicSQLParameter.Value: ISQLParameterValue;
begin
  if Assigned(_ValueCallback) then
    Result := _ValueCallback(Self)
{$IFDEF FPC}
  else
    if Assigned(_ValueCallbackOfObject) then
      Result := _ValueCallbackOfObject(Self)
{$ENDIF}
    else
      Result := nil;
end;

function TDynamicSQLParameter.IsNull: Boolean;
begin
  if Assigned(_ValueCallback) then
    Result := not Assigned(_ValueCallback(Self))
{$IFDEF FPC}
  else
    if Assigned(_ValueCallbackOfObject) then
      Result := not Assigned(_ValueCallbackOfObject(Self))
{$ENDIF}
    else
      Result := True;
end;

constructor TDynamicSQLParameter.Create(const Name: String; const ValueCallback: TSQLParameterValueCallback;
{$IFDEF FPC}const ValueCallbackOfObject: TSQLParameterValueCallbackOfObject; {$ENDIF} const UsePrefix: Boolean);
begin
  _Name := Name;
  _Syntax := TReplaceableSQLParameterValue.New(Name, UsePrefix).Content;
  _ValueCallback := ValueCallback;
{$IFDEF FPC}
  _ValueCallbackOfObject := ValueCallbackOfObject;
{$ENDIF}
end;

class function TDynamicSQLParameter.New(const Name: String; const ValueCallback: TSQLParameterValueCallback;
{$IFDEF FPC}const ValueCallbackOfObject: TSQLParameterValueCallbackOfObject;
{$ENDIF} const UsePrefix: Boolean): ISQLParameter;
begin
  Result := TDynamicSQLParameter.Create(Name, ValueCallback, {$IFDEF FPC}ValueCallbackOfObject, {$ENDIF} UsePrefix);
end;

end.
