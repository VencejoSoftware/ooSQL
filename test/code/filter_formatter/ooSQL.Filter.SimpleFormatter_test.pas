{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.SimpleFormatter_test;

interface

uses
  SysUtils,
  ooText.Beautify.Intf,
  ooSQL.Filter.SimpleFormatter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterSimpleFormatterTest = class(TTestCase)
  published
    procedure ChangeMarginInTextTest;
    procedure ApplyText1234;
    procedure DelimitedList1234;
  end;

implementation

procedure TSQLFilterSimpleFormatterTest.ApplyText1234;
begin
  CheckEquals('1 2 3 4', TSQLFilterSimpleFormatter.New.Apply(['1', '2', '3', '4']));
end;

procedure TSQLFilterSimpleFormatterTest.ChangeMarginInTextTest;
var
  Beautify: ITextBeautify;
begin
  Beautify := TSQLFilterSimpleFormatter.New;
  CheckEquals('test', Beautify.Apply(['test']));
  Beautify.ChangeMargin(2);
  CheckEquals('  test', Beautify.Apply(['test']));
end;

procedure TSQLFilterSimpleFormatterTest.DelimitedList1234;
begin
  CheckEquals('(1, 2, 3, 4)', TSQLFilterSimpleFormatter.New.DelimitedList('1, 2, 3, 4'));
end;

initialization

RegisterTest(TSQLFilterSimpleFormatterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
