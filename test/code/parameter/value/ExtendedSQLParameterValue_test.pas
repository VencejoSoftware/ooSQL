{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ExtendedSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  ExtendedFormatSetting,
  ExtendedSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TExtendedSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure TenPointNineReturnContent10;
    procedure MinusTenWithFormatReturnContentMinusTenPointDecimals;
    procedure MinusTenReturnValue10;
  end;

implementation

procedure TExtendedSQLParameterValueTest.TenPointNineReturnContent10;
var
  Value: IExtendedSQLParameterValue;
begin
  Value := TExtendedSQLParameterValue.New(10.9, TExtendedFormatSetting.New(',', 2));
  CheckEquals('10,90', Value.Content);
end;

procedure TExtendedSQLParameterValueTest.MinusTenWithFormatReturnContentMinusTenPointDecimals;
var
  Value: IExtendedSQLParameterValue;
begin
  Value := TExtendedSQLParameterValue.NewDefault( - 10);
  CheckEquals('-10.0000', Value.Content);
end;

procedure TExtendedSQLParameterValueTest.MinusTenReturnValue10;
var
  Value: IExtendedSQLParameterValue;
begin
  Value := TExtendedSQLParameterValue.NewDefault( - 10);
  CheckEquals( - 10, Value.Value);
end;

initialization

RegisterTest('Parameter', TExtendedSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
