{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQL;

interface

uses
  Text,
  ReplaceText, InsensitiveWordMatch,
  Statement,
  SQLParameter;

type
{$REGION 'documentation'}
{
  @abstract(SQL object)
  SQL syntax object oriented
  @member(
    Parse Parse syntax replacing template with parameter array
    @param(Parameters Array of @link(ISQLParameter parameters))
    @return(String parsed)
  )
  @member(
    Parse Parse syntax replacing template with parameter list
    @param(Parameters @link(ISQLParameterList List of parameters))
    @return(String parsed)
  )
}
{$ENDREGION}
  ISQL = interface(IStatement)
    ['{5D70AAB2-79BD-4B39-BFE5-42AE9749970F}']
    function Parse(const Parameters: array of ISQLParameter): String; overload;
    function Parse(const Parameters: ISQLParameterList): String; overload;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQL))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(Parse @seealso(ISQL.Parse))
  @member(Parse @seealso(ISQL.Parse))
  @member(
    ReplaceParameter Replace parameter in SQL raw text
    @param(SQL Raw SQL text)
    @param(Parameter @link(ISQLParameter Parameter object))
    @return(SQL string with parameter parsed)
  )
  @member(
    Create Object constructor
    @param(SQL SQL raw text)
  )
  @member(
    New Create a new @classname as interface
    @param(SQL SQL raw text)
  )
}
{$ENDREGION}

  TSQL = class sealed(TInterfacedObject, ISQL)
  strict private
    _SQL: String;
  private
    function ReplaceParameter(const SQL: String; const Parameter: ISQLParameter): String;
  public
    function Syntax: String;
    function Parse(const Parameters: array of ISQLParameter): String; overload;
    function Parse(const Parameters: ISQLParameterList): String; overload;
    constructor Create(const SQL: String);
    class function New(const SQL: String): ISQL;
  end;

implementation

function TSQL.Syntax: String;
begin
  Result := _SQL;
end;

function TSQL.ReplaceParameter(const SQL: String; const Parameter: ISQLParameter): String;
var
  ReplaceText: IReplaceText;
begin
  ReplaceText := TReplaceText.New(TInsensitiveWordMatch.NewDefault);
  Result := ReplaceText.AllMatches(TText.New(SQL), TText.New(Parameter.Syntax),
    TText.New(Parameter.Value.Syntax), 1).Value;
end;

function TSQL.Parse(const Parameters: array of ISQLParameter): String;
var
  Parameter: ISQLParameter;
begin
  Result := _SQL;
  for Parameter in Parameters do
    Result := ReplaceParameter(Result, Parameter);
end;

function TSQL.Parse(const Parameters: ISQLParameterList): String;
var
  Parameter: ISQLParameter;
begin
  Result := _SQL;
  for Parameter in Parameters do
    Result := ReplaceParameter(Result, Parameter);
end;

constructor TSQL.Create(const SQL: String);
begin
  _SQL := SQL;
end;

class function TSQL.New(const SQL: String): ISQL;
begin
  Result := TSQL.Create(SQL);
end;

end.
