{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL field object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLField;

interface

type
{$REGION 'documentation'}
{
  @abstract(SQL field object)
  @member(
    Name Field name
    @return(String with the field name)
  )
}
{$ENDREGION}
  ISQLField = interface
    ['{1B9FAA15-6D89-492B-84F0-E2754DEBBBF4}']
    function Name: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLField))
  @member(Name @seealso(ISQLField.Name))
  @member(
    Create Object constructor
    @param(Name Field name)
  )
  @member(
    New Create a new @classname as interface
    @param(Name Field name)
  )
}
{$ENDREGION}

  TSQLField = class sealed(TInterfacedObject, ISQLField)
  strict private
    _Name: String;
  public
    function Name: String;
    constructor Create(const Name: String);
    class function New(const Name: String): ISQLField;
  end;

implementation

function TSQLField.Name: String;
begin
  Result := _Name;
end;

constructor TSQLField.Create(const Name: String);
begin
  _Name := Name;
end;

class function TSQLField.New(const Name: String): ISQLField;
begin
  Result := TSQLField.Create(Name);
end;

end.
