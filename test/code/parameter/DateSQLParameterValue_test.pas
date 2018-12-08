{
  Copyright (c) 2018, Vencejo Software
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
    procedure NewDefaultReturnSyntax20112018;
    procedure FormatDD_MM_YYReturnSyntax20_11_18;
    procedure ContentReturn20112018;
  end;

implementation

procedure TDateSQLParameterValueTest.NewDefaultReturnSyntax20112018;
var
  Value: IDateSQLParameterValue;
begin
  Value := TDateSQLParameterValue.NewDefault(EncodeDate(2018, 11, 20));
  CheckEquals('''20/11/2018''', Value.Syntax);
end;

procedure TDateSQLParameterValueTest.FormatDD_MM_YYReturnSyntax20_11_18;
var
  Value: IDateSQLParameterValue;
begin
  Value := TDateSQLParameterValue.New(EncodeDate(2018, 11, 20), 'DD_MM_YY');
  CheckEquals('''20_11_18''', Value.Syntax);
end;

procedure TDateSQLParameterValueTest.ContentReturn20112018;
var
  Value: IDateSQLParameterValue;
begin
  Value := TDateSQLParameterValue.NewDefault(EncodeDate(2018, 11, 20));
  CheckTrue(EncodeDate(2018, 11, 20) = Value.Content);
end;

initialization

RegisterTest(TDateSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
