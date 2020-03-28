{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ResourceStoredText_test;

interface

uses
  Classes, SysUtils,
  ResourceStoredText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TResourceStoredTextTest = class sealed(TTestCase)
  published
    procedure IDIsID_SQL1;
    procedure TextIsSQL;
    procedure UnexistsIDRaisesError;
  end;

implementation

procedure TResourceStoredTextTest.IDIsID_SQL1;
begin
  CheckEquals('ID_SQL1', TResourceStoredText.New('ID_SQL1').ID);
end;

procedure TResourceStoredTextTest.TextIsSQL;
const
  TEXT = 'SELECT FIELD1, Field2, ''ñ''' + sLineBreak + 'FROM TEST' + sLineBreak + 'WHERE' + sLineBreak +
    '  FIELD1 = :FIELD + 1' + sLineBreak + 'ORDER BY' + sLineBreak + '  FIELD1;' + sLineBreak;
begin
  CheckEquals(TEXT, TResourceStoredText.New('ID_SQL1').Content);
end;

procedure TResourceStoredTextTest.UnexistsIDRaisesError;
var
  ErrorFounded: Boolean;
begin
  ErrorFounded := False;
  try
    CheckEquals(EmptyStr, TResourceStoredText.New('NON_EXISTS').Content);
  except
    on E: EResNotFound do
      ErrorFounded := True;
  end;
  CheckTrue(ErrorFounded);
end;

initialization

RegisterTest('Stored', TResourceStoredTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
