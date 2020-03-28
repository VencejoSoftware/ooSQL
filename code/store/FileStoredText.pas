{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  File store object
  @created(22/03/2020)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit FileStoredText;

interface

uses
  Dialogs,
  Classes, SysUtils,
  StoredText;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(StoredText))
  Store text content in a plain file
  @member(ID @seealso(IStoredText.ID))
  @member(Content @seealso(IStoredText.Content))
  @member(
    ReadFile Read all file
    @param(FilePath File path)
    @return(String with file content)
  )
  @member(
    Create Object constructor
    @param(FilePath File path)
  )
  @member(
    New Create a new @classname as interface
    @param(FilePath File path)
  )
}
{$ENDREGION}
  TFileStoredText = class sealed(TInterfacedObject, IStoredText)
  strict private
    _FilePath: String;
  private
    function ReadFile(const FilePath: String): String;
  public
    function ID: String;
    function Content: String;
    constructor Create(const FilePath: String);
    class function New(const FilePath: String): IStoredText;
  end;

implementation

function TFileStoredText.ReadFile(const FilePath: String): String;
var
  TextStream: TextFile;
  TextLine: String;
begin
  Result := EmptyStr;
  AssignFile(TextStream, FilePath);
  try
    Reset(TextStream);
    while not Eof(TextStream) do
    begin
      Readln(TextStream, TextLine);
      Result := Result + TextLine + sLineBreak;
    end;
  finally
    CloseFile(TextStream);
  end;
end;

function TFileStoredText.ID: String;
begin
  Result := _FilePath;
end;

function TFileStoredText.Content: String;
begin
  Result := ReadFile(ID);
end;

constructor TFileStoredText.Create(const FilePath: String);
begin
  if not FileExists(FilePath) then
    raise EFilerError.Create('File not found');
  _FilePath := FilePath;
end;

class function TFileStoredText.New(const FilePath: String): IStoredText;
begin
  Result := TFileStoredText.Create(FilePath);
end;

end.
