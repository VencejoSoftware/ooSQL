{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLParameter_test;

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
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLParameterTest = class sealed(TTestCase)
  published
    procedure NameIsParameter1;
    procedure SyntaxIsParameter1;
    procedure IsNullIsTrue;
    procedure ChangeValueReturnIsNullFalse;
    procedure AssignedValueAndClearReturnIsNullTrue;
  end;

implementation

procedure TSQLParameterTest.NameIsParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TSQLParameter.New('Parameter1');
  CheckEquals('Parameter1', Parameter.Name);
end;

procedure TSQLParameterTest.SyntaxIsParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TSQLParameter.New('Parameter1');
  CheckEquals('Parameter1', Parameter.Syntax);
end;

procedure TSQLParameterTest.IsNullIsTrue;
var
  Parameter: ISQLParameter;
begin
  Parameter := TSQLParameter.New('Parameter1');
  CheckTrue(Parameter.IsNull);
end;

procedure TSQLParameterTest.ChangeValueReturnIsNullFalse;
var
  Parameter: ISQLParameter;
begin
  Parameter := TSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  CheckFalse(Parameter.IsNull);
end;

procedure TSQLParameterTest.AssignedValueAndClearReturnIsNullTrue;
var
  Parameter: ISQLParameter;
begin
  Parameter := TSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  Parameter.Clear;
  CheckTrue(Parameter.IsNull);
end;

initialization

RegisterTest(TSQLParameterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
