{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQLParameter_test;

interface

uses
  SysUtils,
  Generics.Collections,
  ooFilter.Parameter,
  ooSQL.Parameter.Intf,
  ooSQL.Parameter.Str, ooSQL.Parameter.Dbl, ooSQL.Parameter.Bool, ooSQL.Parameter.Date, ooSQL.Parameter.Int,
  ooSQL.Parameter.TimeStamp, ooSQL.Parameter.Text, ooSQL.Parameter.List,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};
{$IFNDEF FPC}{$IF CompilerVersion > 21}{$DEFINE FormatSettingsScope}{$IFEND}{$ENDIF}

type
  TSQLParameterTest = class(TTestCase)
  const
    PARAM_NAME = 'ParamName1';
  private
    _Parameter: ISQLParameter;
  published
    procedure TestString;
    procedure TestText;
    procedure TestTextNull;
    procedure TestInteger;
    procedure TestIntegerNull;
    procedure TestBooleanTrue;
    procedure TestBooleanFalse;
    procedure TestBooleanNull;
    procedure TestDate;
    procedure TestDateNull;
    procedure TestTimeStamp;
    procedure TestTimeStampNull;
    procedure TestDouble;
    procedure TestDoubleNull;
    procedure TestList;
    procedure TestListNull;
    procedure TestGetParsedValueNull;
    procedure TestGetParsedValueError;
    procedure TestGetNameToParse;
  end;

implementation

procedure TSQLParameterTest.TestBooleanNull;
begin
  _Parameter := TSQLParameterBool.New(PARAM_NAME, True);
  CheckFalse(_Parameter.IsNull);
  _Parameter.Clear;
  CheckTrue(_Parameter.IsNull);
  CheckEquals(PARAMETER_NULL, _Parameter.ValueParsed);
end;

procedure TSQLParameterTest.TestBooleanTrue;
begin
  _Parameter := TSQLParameterBool.New(PARAM_NAME, True);
  CheckEquals('1', _Parameter.ValueParsed, 'Value are different!');
end;

procedure TSQLParameterTest.TestBooleanFalse;
begin
  _Parameter := TSQLParameterBool.New(PARAM_NAME, False);
  CheckEquals('0', _Parameter.ValueParsed, 'Value are different!');
end;

procedure TSQLParameterTest.TestInteger;
begin
  _Parameter := TSQLParameterInt.New(PARAM_NAME, 22);
  CheckEquals(PARAMETER_PREFIX + PARAM_NAME, _Parameter.NameParsed);
  CheckEquals('22', _Parameter.ValueParsed, 'Value are different!');
end;

procedure TSQLParameterTest.TestIntegerNull;
begin
  _Parameter := TSQLParameterInt.New(PARAM_NAME, 22);
  CheckFalse(_Parameter.IsNull);
  _Parameter.Clear;
  CheckTrue(_Parameter.IsNull);
  CheckEquals(PARAMETER_NULL, _Parameter.ValueParsed);
end;

procedure TSQLParameterTest.TestString;
begin
  _Parameter := TSQLParameterStr.New(PARAM_NAME, 'something');
  CheckEquals('''something''', _Parameter.ValueParsed, 'Value are different!');
end;

procedure TSQLParameterTest.TestText;
begin
  _Parameter := TSQLParameterText.New(PARAM_NAME, 'text for any');
  CheckEquals('text for any', _Parameter.ValueParsed, 'Value are different!');
  CheckEquals(PARAMETER_PREFIX + PARAM_NAME, _Parameter.NameParsed);
end;

procedure TSQLParameterTest.TestTextNull;
begin
  _Parameter := TSQLParameterText.New(PARAM_NAME, 'text for any');
  CheckFalse(_Parameter.IsNull);
  _Parameter.Clear;
  CheckTrue(_Parameter.IsNull);
  CheckEquals(PARAMETER_NULL, _Parameter.ValueParsed);
end;

procedure TSQLParameterTest.TestDate;
begin
  _Parameter := TSQLParameterDate.New(PARAM_NAME, Date);
  CheckEquals(PARAMETER_PREFIX + PARAM_NAME, _Parameter.NameParsed);
  CheckEquals(QuotedStr(FormatDateTime({$IFDEF FormatSettingsScope}FormatSettings.{$ENDIF}ShortDateFormat, Date)),
    _Parameter.ValueParsed, 'Value are different!');
end;

procedure TSQLParameterTest.TestDateNull;
begin
  _Parameter := TSQLParameterDate.New(PARAM_NAME, Date);
  CheckFalse(_Parameter.IsNull);
  _Parameter.Clear;
  CheckTrue(_Parameter.IsNull);
  CheckEquals(PARAMETER_NULL, _Parameter.ValueParsed);
end;

procedure TSQLParameterTest.TestTimeStamp;
var
  CurrentDateTime: TDateTime;
begin
  CurrentDateTime := Now;
  _Parameter := TSQLParameterTimeStamp.New(PARAM_NAME, CurrentDateTime);
  CheckEquals(PARAMETER_PREFIX + PARAM_NAME, _Parameter.NameParsed);
  CheckEquals(QuotedStr(DateTimeToStr(CurrentDateTime)), _Parameter.ValueParsed, 'Value are different!');
end;

procedure TSQLParameterTest.TestTimeStampNull;
begin
  _Parameter := TSQLParameterTimeStamp.New(PARAM_NAME, Now);
  CheckFalse(_Parameter.IsNull);
  _Parameter.Clear;
  CheckTrue(_Parameter.IsNull);
  CheckEquals(PARAMETER_NULL, _Parameter.ValueParsed);
end;

procedure TSQLParameterTest.TestDouble;
const
  FLOAT_VALUE = 123.45678;
begin
  _Parameter := TSQLParameterDbl.New(PARAM_NAME, FLOAT_VALUE);
  CheckEquals(PARAMETER_PREFIX + PARAM_NAME, _Parameter.NameParsed);
  CheckEquals(FloatToStr(FLOAT_VALUE), _Parameter.ValueParsed, 'Value are different!');
end;

procedure TSQLParameterTest.TestDoubleNull;
const
  FLOAT_VALUE = 123.45678;
begin
  _Parameter := TSQLParameterDbl.New(PARAM_NAME, FLOAT_VALUE);
  CheckFalse(_Parameter.IsNull);
  _Parameter.Clear;
  CheckTrue(_Parameter.IsNull);
  CheckEquals(PARAMETER_NULL, _Parameter.ValueParsed);
end;

procedure TSQLParameterTest.TestList;
var
  ListTest: TList<ISQLParameter>;
begin
  ListTest := TList<ISQLParameter>.Create;
  try
    ListTest.Add(TSQLParameterStr.New('A', 'a'));
    ListTest.Add(TSQLParameterStr.New('B', 'b'));
    ListTest.Add(TSQLParameterStr.New('X', 'x'));
    _Parameter := TSQLParameterList.New('PARAM_LIST', ListTest);
    CheckEquals(PARAMETER_PREFIX + 'PARAM_LIST', _Parameter.NameParsed);
    CheckEquals('(''a'',''b'',''x'')', _Parameter.ValueParsed, 'Value are different!');
  finally
    ListTest.Free;
  end;
end;

procedure TSQLParameterTest.TestListNull;
var
  ListTest: TList<ISQLParameter>;
begin
  ListTest := TList<ISQLParameter>.Create;
  try
    ListTest.Add(TSQLParameterStr.New('A', 'a'));
    _Parameter := TSQLParameterList.New('PARAM_LIST', ListTest);
    CheckFalse(_Parameter.IsNull);
    _Parameter.Clear;
    CheckTrue(_Parameter.IsNull);
    CheckEquals(PARAMETER_NULL, _Parameter.ValueParsed);
  finally
    ListTest.Free;
  end;
end;

procedure TSQLParameterTest.TestGetNameToParse;
begin
  _Parameter := TSQLParameterInt.New(PARAM_NAME, 22);
  CheckEquals(':' + PARAM_NAME, _Parameter.NameParsed, 'The parsed name are not equal!');
end;

procedure TSQLParameterTest.TestGetParsedValueNull;
begin
  _Parameter := TSQLParameterStr.New(PARAM_NAME, EmptyStr);
  _Parameter.Clear;
  CheckEquals('NULL', _Parameter.ValueParsed, 'The parsed name are not equal!');
end;

procedure TSQLParameterTest.TestGetParsedValueError;
begin
  _Parameter := TSQLParameterStr.New(PARAM_NAME, EmptyStr);
  try
    _Parameter.ValueParsed;
  except
    on E: Exception do
      Check(E is EParameter);
  end;
end;

initialization

RegisterTest(TSQLParameterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
