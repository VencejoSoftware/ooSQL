{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ExtendedFormatSettingValue_test;

interface

uses
  SysUtils,
  ExtendedFormatSetting,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TExtendedFormatSettingTest = class sealed(TTestCase)
  published
    procedure FormatHas3Decimals;
    procedure FormatSeparatorIsComa;
    procedure FormatWithZeroDecimalsReturnNinePointEleven;
    procedure FormatWithTwoDecimalsReturnNinePointEleven;
    procedure FormatWithTwoDecimalsAndComaReturnNineComaEleven;
    procedure NewDefaultReturnNinePointElevenAndFourDecimals;
  end;

implementation

procedure TExtendedFormatSettingTest.FormatHas3Decimals;
begin
  CheckEquals(3, TExtendedFormatSetting.New(',', 3).Decimals);
end;

procedure TExtendedFormatSettingTest.FormatSeparatorIsComa;
begin
  CheckEquals(',', TExtendedFormatSetting.New(',', 3).DecimalSeparator);
end;

procedure TExtendedFormatSettingTest.FormatWithZeroDecimalsReturnNinePointEleven;
begin
  CheckEquals('9.11', TExtendedFormatSetting.New('.', 0).Apply(9.11));
end;

procedure TExtendedFormatSettingTest.FormatWithTwoDecimalsReturnNinePointEleven;
begin
  CheckEquals('9.11', TExtendedFormatSetting.New('.', 2).Apply(9.11));
end;

procedure TExtendedFormatSettingTest.FormatWithTwoDecimalsAndComaReturnNineComaEleven;
begin
  CheckEquals('9,11', TExtendedFormatSetting.New(',', 2).Apply(9.11));
end;

procedure TExtendedFormatSettingTest.NewDefaultReturnNinePointElevenAndFourDecimals;
begin
  CheckEquals('9.1100', TExtendedFormatSetting.NewDefault.Apply(9.11));
end;

initialization

RegisterTest(TExtendedFormatSettingTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
