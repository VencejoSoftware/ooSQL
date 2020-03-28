{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Extended value formatter object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ExtendedFormatSetting;

interface

uses
  SysUtils;

type
{$REGION 'documentation'}
{
  @abstract(Type for format decimals)
}
{$ENDREGION}
  TDecimals = 0 .. 100;

{$REGION 'documentation'}
{
  @abstract(Extended value formatter object)
  Object to format a extended/float value as text
  @member(
    DecimalSeparator Decimals text separator
    @return(Char decimal separator)
  )
  @member(
    Decimals Number of max decimals when format
    @return(Number with max decimals)
  )
  @member(
    Apply Apply format over extended value
    @param(Value Extended value to format as text)
    @return(Formatted text)
  )
}
{$ENDREGION}

  IExtendedFormatSetting = interface
    ['{809B0E13-0492-4BEC-9D46-B825DED35314}']
    function DecimalSeparator: Char;
    function Decimals: TDecimals;
    function Apply(const Value: Extended): String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IExtendedFormatSetting))
  @member(DecimalSeparator @seealso(IExtendedFormatSetting.DecimalSeparator))
  @member(Decimals @seealso(IExtendedFormatSetting.Decimals))
  @member(Apply @seealso(IExtendedFormatSetting.Apply))
  @member(
    Create Object constructor
    @param(DecimalSeparator Decimal char separator)
    @param(Decimals Number of max decimals)
  )
  @member(
    New Create a new @classname as interface
    @param(DecimalSeparator Decimal char separator)
    @param(Decimals Number of max decimals)
  )
  @member(
    NewDefault Create a new @classname as interface, with point as separator and four decimals max
  )
}
{$ENDREGION}

  TExtendedFormatSetting = class sealed(TInterfacedObject, IExtendedFormatSetting)
  strict private
    _DecimalSeparator: Char;
    _Decimals: TDecimals;
  public
    function DecimalSeparator: Char;
    function Decimals: TDecimals;
    function Apply(const Value: Extended): String;
    constructor Create(const DecimalSeparator: Char; const Decimals: TDecimals);
    class function New(const DecimalSeparator: Char; const Decimals: TDecimals): IExtendedFormatSetting;
    class function NewDefault: IExtendedFormatSetting;
  end;

implementation

function TExtendedFormatSetting.DecimalSeparator: Char;
begin
  Result := _DecimalSeparator;
end;

function TExtendedFormatSetting.Decimals: TDecimals;
begin
  Result := _Decimals;
end;

function TExtendedFormatSetting.Apply(const Value: Extended): String;
var
  FormatTemplate: String;
begin
  if _Decimals > 0 then
    FormatTemplate := '0.' + StringOfChar('0', _Decimals);
  Result := FormatFloat(FormatTemplate, Value);
  Result := StringReplace(Result, FormatSettings.DecimalSeparator, _DecimalSeparator, [rfIgnoreCase]);
end;

constructor TExtendedFormatSetting.Create(const DecimalSeparator: Char; const Decimals: TDecimals);
begin
  _DecimalSeparator := DecimalSeparator;
  _Decimals := Decimals;
end;

class function TExtendedFormatSetting.New(const DecimalSeparator: Char; const Decimals: TDecimals)
  : IExtendedFormatSetting;
begin
  Result := TExtendedFormatSetting.Create(DecimalSeparator, Decimals);
end;

class function TExtendedFormatSetting.NewDefault: IExtendedFormatSetting;
begin
  Result := TExtendedFormatSetting.New('.', 4);
end;

end.
