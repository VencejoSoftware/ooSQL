{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DateSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  DateSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TDateSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure NewDefaultReturnContent20112018;
    procedure FormatDD_MM_YYReturnContent20_11_18;
    procedure ValueReturn20112018;
  end;

implementation

procedure TDateSQLParameterValueTest.NewDefaultReturnContent20112018;
var
  Value: IDateSQLParameterValue;
begin
  Value := TDateSQLParameterValue.NewDefault(EncodeDate(2018, 11, 20));
  CheckEquals('''20/11/2018''', Value.Content);
end;

procedure TDateSQLParameterValueTest.FormatDD_MM_YYReturnContent20_11_18;
var
  Value: IDateSQLParameterValue;
begin
  Value := TDateSQLParameterValue.New(EncodeDate(2018, 11, 20), 'DD_MM_YY');
  CheckEquals('''20_11_18''', Value.Content);
end;

procedure TDateSQLParameterValueTest.ValueReturn20112018;
var
  Value: IDateSQLParameterValue;
begin
  Value := TDateSQLParameterValue.NewDefault(EncodeDate(2018, 11, 20));
  CheckTrue(EncodeDate(2018, 11, 20) = Value.Value);
end;

initialization

RegisterTest('Parameter', TDateSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
