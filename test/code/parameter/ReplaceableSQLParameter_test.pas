{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ReplaceableSQLParameter_test;

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
  MutableSQLParameter, ReplaceableSQLParameter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TReplaceableSQLParameterTest = class sealed(TTestCase)
  published
    procedure NameIsParameter1;
    procedure SyntaxIsPrefixParameter1;
    procedure SyntaxEnclosedIsEncloseStartParameter1EncloseEnd;
    procedure IsNullIsTrue;
    procedure ChangeValueReturnIsNullFalse;
    procedure AssignedValueAndClearReturnIsNullTrue;
  end;

implementation

procedure TReplaceableSQLParameterTest.NameIsParameter1;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TReplaceableSQLParameter.New('Parameter1');
  CheckEquals('Parameter1', Parameter.Name);
end;

procedure TReplaceableSQLParameterTest.SyntaxIsPrefixParameter1;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TReplaceableSQLParameter.New('Parameter1');
  CheckEquals(':Parameter1', Parameter.Syntax);
end;

procedure TReplaceableSQLParameterTest.SyntaxEnclosedIsEncloseStartParameter1EncloseEnd;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TReplaceableSQLParameter.New('Parameter1', False);
  CheckEquals('{Parameter1}', Parameter.Syntax);
end;

procedure TReplaceableSQLParameterTest.IsNullIsTrue;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TReplaceableSQLParameter.New('Parameter1');
  CheckTrue(Parameter.IsNull);
end;

procedure TReplaceableSQLParameterTest.ChangeValueReturnIsNullFalse;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TReplaceableSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  CheckFalse(Parameter.IsNull);
end;

procedure TReplaceableSQLParameterTest.AssignedValueAndClearReturnIsNullTrue;
var
  Parameter: IMutableSQLParameter;
begin
  Parameter := TReplaceableSQLParameter.New('Parameter1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(666));
  Parameter.Clear;
  CheckTrue(Parameter.IsNull);
end;

initialization

RegisterTest('Parameter', TReplaceableSQLParameterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
