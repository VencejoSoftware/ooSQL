{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter extended/float value syntax object
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
  @abstract(SQL parameter extended/float value syntax object)
  Object to resolve a SQL parameter value with floats
  @member(
    Content Extended value
    @return(Extended value)
  )
}
{$ENDREGION}
  IExtendedSQLParameterValue = interface(ISQLParameterValue)
    ['{89FF3157-4FC9-45F5-A09C-139EDE501297}']
    function Content: Extended;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IExtendedSQLParameterValue))
  Return the syntax value of extended as formatted text
  @member(Content @seealso(IExtendedSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Content Extended value)
    @param(Format Object formatter)
  )
  @member(
    New Create a new @classname as interface
    @param(Content Extended value)
    @param(Format Object formatter)
  )
  @member(
    NewDefault Create a new @classname as interface using a default formatter
    @param(Content Extended value)
  )
}
{$ENDREGION}

  TExtendedSQLParameterValue = class sealed(TInterfacedObject, IExtendedSQLParameterValue)
  strict private
    _Content: Extended;
    _Format: IExtendedFormatSetting;
  public
    function Syntax: String;
    function Content: Extended;
    constructor Create(const Content: Extended; const Format: IExtendedFormatSetting);
    class function New(const Content: Extended; const Format: IExtendedFormatSetting): IExtendedSQLParameterValue;
    class function NewDefault(const Content: Extended): IExtendedSQLParameterValue;
  end;

implementation

function TExtendedSQLParameterValue.Syntax: String;
begin
  Result := _Format.Apply(_Content);
end;

function TExtendedSQLParameterValue.Content: Extended;
begin
  Result := _Content;
end;

constructor TExtendedSQLParameterValue.Create(const Content: Extended; const Format: IExtendedFormatSetting);
begin
  _Format := Format;
  _Content := Content;
end;

class function TExtendedSQLParameterValue.New(const Content: Extended; const Format: IExtendedFormatSetting)
  : IExtendedSQLParameterValue;
begin
  Result := TExtendedSQLParameterValue.Create(Content, Format);
end;

class function TExtendedSQLParameterValue.NewDefault(const Content: Extended): IExtendedSQLParameterValue;
begin
  Result := TExtendedSQLParameterValue.New(Content, TExtendedFormatSetting.NewDefault);
end;

end.
