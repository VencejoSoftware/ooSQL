{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit FileStoredText_test;

interface

uses
  Classes, SysUtils,
  FileStoredText,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFileStoredTextTest = class sealed(TTestCase)
  const
    FILE_PATH = '..\..\resources\select1.sql';
  published
    procedure IDIsPath;
    procedure TextIsSQL;
    procedure UnexistsIDRaisesError;
  end;

implementation

procedure TFileStoredTextTest.IDIsPath;
begin
  CheckEquals(FILE_PATH, TFileStoredText.New(FILE_PATH).ID);
end;

procedure TFileStoredTextTest.TextIsSQL;
const
  TEXT = 'SELECT FIELD1, Field2, ''ñ''' + sLineBreak + 'FROM TEST' + sLineBreak + 'WHERE' + sLineBreak +
    '  FIELD1 = :FIELD + 1' + sLineBreak + 'ORDER BY' + sLineBreak + '  FIELD1;' + sLineBreak;
begin
  CheckEquals(TEXT, TFileStoredText.New(FILE_PATH).Content);
end;

procedure TFileStoredTextTest.UnexistsIDRaisesError;
var
  ErrorFounded: Boolean;
begin
  ErrorFounded := False;
  try
    CheckEquals(EmptyStr, TFileStoredText.New('NON_EXISTS').Content);
  except
    on E: EFilerError do
      ErrorFounded := True;
  end;
  CheckTrue(ErrorFounded);
end;

initialization

RegisterTest('Stored', TFileStoredTextTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
