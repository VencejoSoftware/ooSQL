{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Text stored object
  @created(22/03/2020)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit StoredText;

interface

type
{$REGION 'documentation'}
{
  @abstract(Stored text object)
  Store text in some repository
  @member(ID Identification)
  @member(Content Text content)
}
{$ENDREGION}
  IStoredText = interface
    ['{F4A57687-5FB6-4F83-A707-8BE3C194C250}']
    function ID: String;
    function Content: String;
  end;

implementation

end.
