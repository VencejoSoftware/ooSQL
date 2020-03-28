{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter value object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLParameterValue;

interface

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter value object)
  Object to resolve a SQL parameter value as a plain text
  @member(
    Content Text value
    @return(Text value)
  )
}
{$ENDREGION}
  ISQLParameterValue = interface
    ['{AE68C9E1-3D32-4899-987E-43140F550CFC}']
    function Content: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IRawSQLParameterValue))
  @member(Content @seealso(ISQLParameterValue.Content))
  @member(
    Create Object constructor
    @param(Content Text value)
  )
  @member(
    New Create a new @classname as interface
    @param(Content Text value)
  )
}
{$ENDREGION}

  TSQLParameterValue = class sealed(TInterfacedObject, ISQLParameterValue)
  strict private
    _Content: String;
  public
    function Content: String;
    constructor Create(const Content: String);
    class function New(const Content: String): ISQLParameterValue;
  end;

implementation

function TSQLParameterValue.Content: String;
begin
  Result := _Content;
end;

constructor TSQLParameterValue.Create(const Content: String);
begin
  _Content := Content;
end;

class function TSQLParameterValue.New(const Content: String): ISQLParameterValue;
begin
  Result := TSQLParameterValue.Create(Content);
end;

end.
