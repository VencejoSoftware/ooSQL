{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL replaceable parameter content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ReplaceableSQLParameterValue;

interface

uses
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameterValue))
  Returns a Content for a replaceable value, with the format :[VALUE] or  [#123VALUE#125]
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(
    Create Object constructor
    @param(Name Name for the replaceable value)
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
  @member(
    New Create a new @classname as interface
    @param(Name Name for the replaceable value)
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
}
{$ENDREGION}
  TReplaceableSQLParameterValue = class sealed(TInterfacedObject, ISQLParameterValue)
  strict private
    _Name: String;
    _UsePrefix: Boolean;
  public
    function Content: String;
    constructor Create(const Name: String; const UsePrefix: Boolean);
    class function New(const Name: String; const UsePrefix: Boolean = True): ISQLParameterValue;
  end;

implementation

function TReplaceableSQLParameterValue.Content: String;
const
  Replaceable_PREFIX = ':';
  ENCLOSE_START = '{';
  ENCLOSE_END = '}';
begin
  if _UsePrefix then
    Result := Replaceable_PREFIX + _Name
  else
    Result := ENCLOSE_START + _Name + ENCLOSE_END;
end;

constructor TReplaceableSQLParameterValue.Create(const Name: String; const UsePrefix: Boolean);
begin
  _Name := Name;
  _UsePrefix := UsePrefix;
end;

class function TReplaceableSQLParameterValue.New(const Name: String; const UsePrefix: Boolean): ISQLParameterValue;
begin
  Result := TReplaceableSQLParameterValue.Create(Name, UsePrefix);
end;

end.
