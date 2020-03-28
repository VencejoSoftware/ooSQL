{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit BooleanSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  BooleanSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TBooleanSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure TrueReturnContent1;
    procedure FalseReturnContent0;
    procedure TrueValueIsTrue;
    procedure FalseValueIsFalse;
  end;

implementation

procedure TBooleanSQLParameterValueTest.TrueReturnContent1;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(True);
  CheckEquals('1', Value.Content);
end;

procedure TBooleanSQLParameterValueTest.FalseReturnContent0;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(False);
  CheckEquals('0', Value.Content);
end;

procedure TBooleanSQLParameterValueTest.TrueValueIsTrue;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(True);
  CheckEquals(True, Value.Value);
end;

procedure TBooleanSQLParameterValueTest.FalseValueIsFalse;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(False);
  CheckEquals(False, Value.Value);
end;

initialization

RegisterTest('Parameter', TBooleanSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
