{
  Copyright (c) 2020, Vencejo Software
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
    procedure TenReturnContent10;
    procedure MinusTenReturnValue10;
  end;

implementation

procedure TIntegerSQLParameterValueTest.TenReturnContent10;
var
  Value: IIntegerSQLParameterValue;
begin
  Value := TIntegerSQLParameterValue.New(10);
  CheckEquals('10', Value.Content);
end;

procedure TIntegerSQLParameterValueTest.MinusTenReturnValue10;
var
  Value: IIntegerSQLParameterValue;
begin
  Value := TIntegerSQLParameterValue.New( - 10);
  CheckEquals( - 10, Value.Value);
end;

initialization

RegisterTest('Parameter', TIntegerSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
