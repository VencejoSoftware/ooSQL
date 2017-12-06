{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Like_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.Like,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionLikeTest = class(TTestCase)
  published
    procedure FieldTestLike200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionLikeTest.FieldTestLike200;
begin
  CheckEquals('FieldTest LIKE ''200%''', TSQLConditionLike.New('FieldTest', '200%').Parse(TSQLFilterSimpleFormatter.New)
    );
end;

procedure TSQLConditionLikeTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionLike.New('FieldTest', EmptyStr).IsEmpty);
end;

procedure TSQLConditionLikeTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionLike.New('FieldTest', EmptyStr).IsReplaceable);
  CheckTrue(TSQLConditionLike.New('FieldTest', ':VALUE1').IsReplaceable);
end;

procedure TSQLConditionLikeTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionLike.New('FieldTest', EmptyStr).IsValid);
  CheckFalse(TSQLConditionLike.New(EmptyStr, '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionLikeTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
