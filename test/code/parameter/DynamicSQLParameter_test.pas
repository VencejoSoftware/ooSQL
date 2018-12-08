{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DynamicSQLParameter_test;

interface

uses
  SysUtils,
  BooleanSQLParameterValue,
  DateSQLParameterValue,
  ExtendedSQLParameterValue,
  IntegerSQLParameterValue,
  UIntegerSQLParameterValue,
  StringSQLParameterValue,
  DateTimeSQLParameterValue,
  ListSQLParameterValue,
  SQLParameter,
  DynamicSQLParameter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TDynamicSQLParameterTest = class sealed(TTestCase)
  published
    procedure NameIsParameter1;
    procedure SyntaxIsPrefixParameter1;
    procedure IsNullIsTrue;
    procedure ChangeValueReturnIsNullFalse;
    procedure AssignedValueAndClearReturnIsNullTrue;
  end;

implementation

procedure TDynamicSQLParameterTest.NameIsParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1');
  CheckEquals('Parameter1', Parameter.Name);
end;

procedure TDynamicSQLParameterTest.SyntaxIsPrefixParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1');
  CheckEquals(':Parameter1', Parameter.Syntax);
end;

procedure TDynamicSQLParameterTest.IsNullIsTrue;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1');
  CheckTrue(Parameter.IsNull);
end;

procedure TDynamicSQLParameterTest.ChangeValueReturnIsNullFalse;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  CheckFalse(Parameter.IsNull);
end;

procedure TDynamicSQLParameterTest.AssignedValueAndClearReturnIsNullTrue;
var
  Parameter: ISQLParameter;
begin
  Parameter := TDynamicSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  Parameter.Clear;
  CheckTrue(Parameter.IsNull);
end;

initialization

RegisterTest(TDynamicSQLParameterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
