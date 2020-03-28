{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DynamicSQLParameter_test;

interface

uses
  SysUtils,
  SQLParameter, DynamicSQLParameter,
  SQLParameterValue,
  UIntegerSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TDynamicSQLParameterTest = class sealed(TTestCase)
  private
    function ParameterValueCallback(const Parameter: ISQLParameter): ISQLParameterValue;
  published
    procedure NameIsParameter1;
    procedure SyntaxIsParameter1;
    procedure IsNullIsTrue;
    procedure IsNullIsFalse;
    procedure AssignedCallbackContentReturnMaxInt;
    procedure NotAssignedCallbackContentReturnNil;
  end;

implementation

function TDynamicSQLParameterTest.ParameterValueCallback(const Parameter: ISQLParameter): ISQLParameterValue;
begin
  if Parameter.Name = 'Parameter1' then
    Result := TUIntegerSQLParameterValue.New(MaxInt)
  else
    Result := nil;
end;

procedure TDynamicSQLParameterTest.NameIsParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1', {$IFDEF FPC}nil, {$ENDIF} ParameterValueCallback);
  CheckEquals('Parameter1', Parameter.Name);
end;

procedure TDynamicSQLParameterTest.SyntaxIsParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1', {$IFDEF FPC}nil, {$ENDIF} ParameterValueCallback);
  CheckEquals(':Parameter1', Parameter.Syntax);
end;

procedure TDynamicSQLParameterTest.IsNullIsFalse;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1', {$IFDEF FPC}nil, {$ENDIF} ParameterValueCallback);
  CheckFalse(Parameter.IsNull);
end;

procedure TDynamicSQLParameterTest.IsNullIsTrue;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1', {$IFDEF FPC}nil, {$ENDIF} nil);
  CheckTrue(Parameter.IsNull);
end;

procedure TDynamicSQLParameterTest.AssignedCallbackContentReturnMaxInt;
var
  Parameter: ISQLParameter;
  Value: ISQLParameterValue;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1', {$IFDEF FPC}nil, {$ENDIF} ParameterValueCallback);
  Value := Parameter.Value;
  CheckTrue(Supports(Value, IUIntegerSQLParameterValue));
  if Supports(Value, IUIntegerSQLParameterValue) then
    CheckEquals(MaxInt, (Value as IUIntegerSQLParameterValue).Value);
end;

procedure TDynamicSQLParameterTest.NotAssignedCallbackContentReturnNil;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1', {$IFDEF FPC}nil, {$ENDIF} nil);
  CheckFalse(Assigned(Parameter.Value));
end;

initialization

RegisterTest('Parameter', TDynamicSQLParameterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
