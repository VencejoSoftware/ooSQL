{
  Copyright (c) 2018, Vencejo Software
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
    procedure TrueReturnSyntax1;
    procedure FalseReturnSyntax0;
    procedure TrueContentIsTrue;
    procedure FalseContentIsFalse;
  end;

implementation

procedure TBooleanSQLParameterValueTest.TrueReturnSyntax1;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(True);
  CheckEquals('1', Value.Syntax);
end;

procedure TBooleanSQLParameterValueTest.FalseReturnSyntax0;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(False);
  CheckEquals('0', Value.Syntax);
end;

procedure TBooleanSQLParameterValueTest.TrueContentIsTrue;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(True);
  CheckEquals(True, Value.Content);
end;

procedure TBooleanSQLParameterValueTest.FalseContentIsFalse;
var
  Value: IBooleanSQLParameterValue;
begin
  Value := TBooleanSQLParameterValue.New(False);
  CheckEquals(False, Value.Content);
end;

initialization

RegisterTest(TBooleanSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
