{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter value syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLParameterValue;

interface

uses
  Statement;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter value syntax object)
  Object to resolve a SQL parameter value syntax
}
{$ENDREGION}
  ISQLParameterValue = interface(IStatement)
    ['{AE68C9E1-3D32-4899-987E-43140F550CFC}']
  end;

{$REGION 'documentation'}
{
  @abstract(SQL parameter raw value syntax)
  Object to resolve a SQL parameter value as text
  @member(
    Content Text value
    @return(Text value)
  )
}
{$ENDREGION}

  IRawSQLParameterValue = interface(ISQLParameterValue)
    ['{A75FFCED-A385-4577-B37F-5589AE84DEF0}']
    function Content: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IRawSQLParameterValue))
  @member(Content @seealso(IRawSQLParameterValue.Content))
  @member(Syntax @seealso(IStatement.Syntax))
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

  TRawSQLParameterValue = class sealed(TInterfacedObject, IRawSQLParameterValue)
  strict private
    _Content: String;
  public
    function Syntax: String;
    function Content: String;
    constructor Create(const Content: String);
    class function New(const Content: String): IRawSQLParameterValue;
  end;

implementation

function TRawSQLParameterValue.Syntax: String;
begin
  Result := Content;
end;

function TRawSQLParameterValue.Content: String;
begin
  Result := _Content;
end;

constructor TRawSQLParameterValue.Create(const Content: String);
begin
  _Content := Content;
end;

class function TRawSQLParameterValue.New(const Content: String): IRawSQLParameterValue;
begin
  Result := TRawSQLParameterValue.Create(Content);
end;

end.
