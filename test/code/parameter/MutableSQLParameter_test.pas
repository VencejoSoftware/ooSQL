{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MutableSQLParameter_test;

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
  SQLParameter, MutableSQLParameter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TMutableSQLParameterTest = class sealed(TTestCase)
  published
    procedure NameIsParameter1;
    procedure SyntaxIsParameter1;
    procedure IsNullIsTrue;
    procedure ChangeValueReturnIsNullFalse;
    procedure AssignedValueAndClearReturnIsNullTrue;
  end;

implementation

procedure TMutableSQLParameterTest.NameIsParameter1;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TMutableSQLParameter.New('Parameter1');
  CheckEquals('Parameter1', Parameter.Name);
end;

procedure TMutableSQLParameterTest.SyntaxIsParameter1;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TMutableSQLParameter.New('Parameter1');
  CheckEquals(':Parameter1', Parameter.Syntax);
end;

procedure TMutableSQLParameterTest.IsNullIsTrue;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TMutableSQLParameter.New('Parameter1');
  CheckTrue(Parameter.IsNull);
end;

procedure TMutableSQLParameterTest.ChangeValueReturnIsNullFalse;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TMutableSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  CheckFalse(Parameter.IsNull);
end;

procedure TMutableSQLParameterTest.AssignedValueAndClearReturnIsNullTrue;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TMutableSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  Parameter.Clear;
  CheckTrue(Parameter.IsNull);
end;

initialization

RegisterTest('Parameter', TMutableSQLParameterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
