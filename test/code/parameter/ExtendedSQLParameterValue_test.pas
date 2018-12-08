{
  Copyright (c) 2018, Vencejo Software
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
    procedure TenPointNineReturnSyntax10;
    procedure MinusTenWithFormatReturnSyntaxMinusTenPointDecimals;
    procedure MinusTenReturnContent10;
  end;

implementation

procedure TExtendedSQLParameterValueTest.TenPointNineReturnSyntax10;
var
  Value: IExtendedSQLParameterValue;
begin
  Value := TExtendedSQLParameterValue.New(10.9, TExtendedFormatSetting.New(',', 2));
  CheckEquals('10,90', Value.Syntax);
end;

procedure TExtendedSQLParameterValueTest.MinusTenWithFormatReturnSyntaxMinusTenPointDecimals;
var
  Value: IExtendedSQLParameterValue;
begin
  Value := TExtendedSQLParameterValue.NewDefault( - 10);
  CheckEquals('-10.0000', Value.Syntax);
end;

procedure TExtendedSQLParameterValueTest.MinusTenReturnContent10;
var
  Value: IExtendedSQLParameterValue;
begin
  Value := TExtendedSQLParameterValue.NewDefault( - 10);
  CheckEquals( - 10, Value.Content);
end;

initialization

RegisterTest(TExtendedSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
