{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ListSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  StringSQLParameterValue, IntegerSQLParameterValue, DateSQLParameterValue,
  ListSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};
{$IFNDEF FPC}{$IF CompilerVersion > 21}{$DEFINE FormatSettingsScope}{$IFEND}{$ENDIF}

type
  TListSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure SyntaxReturnItemsSyntax;
    procedure ItemsReturnCountThree;
    procedure EmptyItemsReturnEmptySyntaxEnclosed;
  end;

implementation

procedure TListSQLParameterValueTest.ItemsReturnCountThree;
var
  Value: IListSQLParameterValue;
  Value1: IIntegerSQLParameterValue;
  Value2: IStringSQLParameterValue;
  Value3: IDateSQLParameterValue;
begin
  Value1 := TIntegerSQLParameterValue.New(666);
  Value2 := TStringSQLParameterValue.New('Text');
  Value3 := TDateSQLParameterValue.NewDefault(EncodeDate(2010, 2, 11));
  Value := TListSQLParameterValue.New([Value1, Value2, Value3]);
  CheckEquals(3, Length(Value.Items));
end;

procedure TListSQLParameterValueTest.SyntaxReturnItemsSyntax;
var
  Value: IListSQLParameterValue;
  Value1: IIntegerSQLParameterValue;
  Value2: IStringSQLParameterValue;
  Value3: IDateSQLParameterValue;
  DateText: String;
begin
  Value1 := TIntegerSQLParameterValue.New(666);
  Value2 := TStringSQLParameterValue.New('Text');
  Value3 := TDateSQLParameterValue.NewDefault(EncodeDate(2010, 2, 11));
  Value := TListSQLParameterValue.New([Value1, Value2, Value3]);
  DateText := FormatDateTime({$IFDEF FormatSettingsScope} FormatSettings.{$ENDIF} ShortDateFormat,
    EncodeDate(2010, 2, 11));
  CheckEquals('(666,''Text'',''' + DateText + ''')', Value.Syntax);
end;

procedure TListSQLParameterValueTest.EmptyItemsReturnEmptySyntaxEnclosed;
var
  Value: IListSQLParameterValue;
begin
  Value := TListSQLParameterValue.New([]);
  CheckEquals('()', Value.Syntax);
end;

initialization

RegisterTest(TListSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
