{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit UIntegerSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  UIntegerSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TUIntegerSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure TenReturnContent10;
    procedure TenReturnValue10;
  end;

implementation

procedure TUIntegerSQLParameterValueTest.TenReturnContent10;
var
  Value: IUIntegerSQLParameterValue;
begin
  Value := TUIntegerSQLParameterValue.New(10);
  CheckEquals('10', Value.Content);
end;

procedure TUIntegerSQLParameterValueTest.TenReturnValue10;
var
  Value: IUIntegerSQLParameterValue;
begin
  Value := TUIntegerSQLParameterValue.New(10);
  CheckEquals(10, Value.Value);
end;

initialization

RegisterTest('Parameter', TUIntegerSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
