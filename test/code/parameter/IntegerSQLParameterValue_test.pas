{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit IntegerSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  IntegerSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TIntegerSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure TenReturnSyntax10;
    procedure MinusTenReturnContent10;
  end;

implementation

procedure TIntegerSQLParameterValueTest.TenReturnSyntax10;
var
  Value: IIntegerSQLParameterValue;
begin
  Value := TIntegerSQLParameterValue.New(10);
  CheckEquals('10', Value.Syntax);
end;

procedure TIntegerSQLParameterValueTest.MinusTenReturnContent10;
var
  Value: IIntegerSQLParameterValue;
begin
  Value := TIntegerSQLParameterValue.New( - 10);
  CheckEquals( - 10, Value.Content);
end;

initialization

RegisterTest(TIntegerSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
