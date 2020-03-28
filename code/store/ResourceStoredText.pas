{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Resource file store object
  @created(22/03/2020)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ResourceStoredText;

interface

uses
  Classes,
{$IFDEF FPC}
  LResources,
{$ENDIF}
  StoredText;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(StoredText))
  Store text content in a resource file
  @member(ID @seealso(IStoredText.ID))
  @member(Content @seealso(IStoredText.Content))
  @member(
    ReadResource Read the resource file
    @param(ID Resource identificator)
  )
  @member(
    Create Object constructor
    @param(ID Resource identificator)
  )
  @member(
    New Create a new @classname as interface
    @param(ID Resource identificator)
  )
}
{$ENDREGION}
  TResourceStoredText = class sealed(TInterfacedObject, IStoredText)
  strict private
    _ID: String;
  private
    function ReadResource(const ID: String): String;
  public
    function ID: String;
    function Content: String;
    constructor Create(const ID: String);
    class function New(const ID: String): IStoredText;
  end;

implementation

function TResourceStoredText.ReadResource(const ID: String): String;
const
  RC_TEXT = 'TEXT';
var
  ResourceStream: TResourceStream;
  TextStream: TStringStream;
begin
  ResourceStream := TResourceStream.Create(0, ID, RC_TEXT);
  try
{$IFDEF FPC}
    SetLength(Result, ResourceStream.Size);
    ResourceStream.Read(Result[1], ResourceStream.Size);
{$ELSE}
    TextStream := TStringStream.Create;
    try
      TextStream.LoadFromStream(ResourceStream);
      Result := TextStream.DataString;
    finally
      TextStream.Free;
    end;
{$ENDIF};
  finally
    ResourceStream.Free;
  end;
end;

function TResourceStoredText.ID: String;
begin
  Result := _ID;
end;

function TResourceStoredText.Content: String;
begin
  Result := ReadResource(ID);
end;

constructor TResourceStoredText.Create(const ID: String);
begin
  _ID := ID;
end;

class function TResourceStoredText.New(const ID: String): IStoredText;
begin
  Result := TResourceStoredText.Create(ID);
end;

end.
