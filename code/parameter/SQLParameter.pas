{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLParameter;

interface

uses
  Statement,
  SQLParameterValue,
  IterableList;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter syntax object)
  Object to resolve a SQL parameter syntax
  @member(
    Name Parameter name
    @return(Text with parameter name)
  )
  @member(
    IsNull Checks if the parameter value is assigned
    @return(@true if the value is assigned, @false if not)
  )
  @member(
    Value Parameter value object
    @return(@link(ISQLParameterValue Parameter value object))
  )
}
{$ENDREGION}
  ISQLParameter = interface(IStatement)
    ['{B688AFED-8F67-4FEA-96C4-A1B9926AADCC}']
    function Name: String;
    function IsNull: Boolean;
    function Value: ISQLParameterValue;
  end;

{$REGION 'documentation'}
{
  @abstract(SQL parameter list object)
  List of parameters
}
{$ENDREGION}

  ISQLParameterList = interface(IIterableList<ISQLParameter>)
    ['{9EC80759-A699-4AAA-9BF5-80F7ED186B94}']
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameterList))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TSQLParameterList = class sealed(TIterableList<ISQLParameter>, ISQLParameterList)
  public
    class function New: ISQLParameterList;
  end;

implementation

{ TSQLParameterList }

class function TSQLParameterList.New: ISQLParameterList;
begin
  Result := TSQLParameterList.Create;
end;

end.
