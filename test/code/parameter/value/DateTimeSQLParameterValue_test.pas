{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DateTimeSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  DateTimeSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TDateTimeSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure NewDefaultReturnContent2011201823513311;
    procedure ValueReturn2011201823513311;
    procedure FormatDD_MM_YYReturnContent20_11_1823513311;
  end;

implementation

procedure TDateTimeSQLParameterValueTest.NewDefaultReturnContent2011201823513311;
var
  Value: IDateTimeSQLParameterValue;
begin
  Value := TDateTimeSQLParameterValue.NewDefault(EncodeDate(2018, 11, 20) + EncodeTime(23, 51, 33, 11));
  CheckEquals('''20/11/2018 23:51''', Value.Content);
end;

procedure TDateTimeSQLParameterValueTest.ValueReturn2011201823513311;
var
  Value: IDateTimeSQLParameterValue;
  DateTest: TDateTime;
begin
  DateTest := EncodeDate(2018, 11, 20) + EncodeTime(23, 51, 33, 11);
  Value := TDateTimeSQLParameterValue.NewDefault(DateTest);
  CheckTrue(DateTest = Value.Value);
end;

procedure TDateTimeSQLParameterValueTest.FormatDD_MM_YYReturnContent20_11_1823513311;
var
  Value: IDateTimeSQLParameterValue;
begin
  Value := TDateTimeSQLParameterValue.New(EncodeDate(2018, 11, 20) + EncodeTime(23, 51, 33, 11), 'DD_MM_YY HH.NN.SS');
  CheckEquals('''20_11_18 23.51.33''', Value.Content);
end;

initialization

RegisterTest('Parameter', TDateTimeSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
