{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StringSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  StringSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStringSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure TextReturnContentQuotedText;
    procedure ValueIsText;
    procedure EmptyValueReturnQuotedEmpty;
  end;

implementation

procedure TStringSQLParameterValueTest.TextReturnContentQuotedText;
var
  Value: IStringSQLParameterValue;
begin
  Value := TStringSQLParameterValue.New('Text');
  CheckEquals('''Text''', Value.Content);
end;

procedure TStringSQLParameterValueTest.ValueIsText;
var
  Value: IStringSQLParameterValue;
begin
  Value := TStringSQLParameterValue.New('Text');
  CheckEquals('Text', Value.Value);
end;

procedure TStringSQLParameterValueTest.EmptyValueReturnQuotedEmpty;
var
  Value: IStringSQLParameterValue;
begin
  Value := TStringSQLParameterValue.New(EmptyStr);
  CheckEquals('''''', Value.Content);
end;

initialization

RegisterTest('Parameter', TStringSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
