{
  Copyright (c) 2018, Vencejo Software
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
    procedure TextReturnSyntaxQuotedText;
    procedure ContentIsText;
    procedure EmptyValueReturnQuotedEmpty;
  end;

implementation

procedure TStringSQLParameterValueTest.TextReturnSyntaxQuotedText;
var
  Value: IStringSQLParameterValue;
begin
  Value := TStringSQLParameterValue.New('Text');
  CheckEquals('''Text''', Value.Syntax);
end;

procedure TStringSQLParameterValueTest.ContentIsText;
var
  Value: IStringSQLParameterValue;
begin
  Value := TStringSQLParameterValue.New('Text');
  CheckEquals('Text', Value.Content);
end;

procedure TStringSQLParameterValueTest.EmptyValueReturnQuotedEmpty;
var
  Value: IStringSQLParameterValue;
begin
  Value := TStringSQLParameterValue.New(EmptyStr);
  CheckEquals('''''', Value.Syntax);
end;

initialization

RegisterTest(TStringSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
