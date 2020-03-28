{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL extended parameter value content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ExtendedSQLParameterValue;

interface

uses
  SysUtils,
  SQLParameterValue,
  ExtendedFormatSetting;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter extended/float content object)
  Object to resolve a SQL parameter value with floats
  @member(
    Value Extended value
    @return(Extended value)
  )
}
{$ENDREGION}
  IExtendedSQLParameterValue = interface(ISQLParameterValue)
    ['{89FF3157-4FC9-45F5-A09C-139EDE501297}']
    function Value: Extended;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IExtendedSQLParameterValue))
  Return the content value of extended as formatted text
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(Value @seealso(IExtendedSQLParameterValue.Value))
  @member(
    Create Object constructor
    @param(Value Extended value)
    @param(Format Object formatter)
  )
  @member(
    New Create a new @classname as interface
    @param(Value Extended value)
    @param(Format Object formatter)
  )
  @member(
    NewDefault Create a new @classname as interface using a default formatter
    @param(Value Extended value)
  )
}
{$ENDREGION}

  TExtendedSQLParameterValue = class sealed(TInterfacedObject, IExtendedSQLParameterValue)
  strict private
    _Value: Extended;
    _Format: IExtendedFormatSetting;
  public
    function Content: String;
    function Value: Extended;
    constructor Create(const Value: Extended; const Format: IExtendedFormatSetting);
    class function New(const Value: Extended; const Format: IExtendedFormatSetting): IExtendedSQLParameterValue;
    class function NewDefault(const Value: Extended): IExtendedSQLParameterValue;
  end;

implementation

function TExtendedSQLParameterValue.Content: String;
begin
  Result := _Format.Apply(_Value);
end;

function TExtendedSQLParameterValue.Value: Extended;
begin
  Result := _Value;
end;

constructor TExtendedSQLParameterValue.Create(const Value: Extended; const Format: IExtendedFormatSetting);
begin
  _Format := Format;
  _Value := Value;
end;

class function TExtendedSQLParameterValue.New(const Value: Extended; const Format: IExtendedFormatSetting)
  : IExtendedSQLParameterValue;
begin
  Result := TExtendedSQLParameterValue.Create(Value, Format);
end;

class function TExtendedSQLParameterValue.NewDefault(const Value: Extended): IExtendedSQLParameterValue;
begin
  Result := TExtendedSQLParameterValue.New(Value, TExtendedFormatSetting.NewDefault);
end;

end.
