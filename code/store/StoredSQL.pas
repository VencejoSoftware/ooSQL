{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Stored SQL object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit StoredSQL;

interface

uses
  Statement,
  SQL,
  SQLParameter,
  StoredText;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQL))
  Use stored SQL text from the @link(IStoredText Stored text object)
  @member(Syntax @seealso(IStatement.Syntax))
  @member(Parse @seealso(ISQL.Parse))
  @member(Parse @seealso(ISQL.Parse))
  @member(
    Create Object constructor
    @param(StoredText @link(IStoredText Stored text object))
  )
  @member(
    New Create a new @classname as interface
    @param(StoredText @link(IStoredText Stored text object))
  )
}
{$ENDREGION}
  TStoredSQL = class sealed(TInterfacedObject, ISQL)
  strict private
    _SQL: ISQL;
  public
    function Syntax: String;
    function Parse(const Parameters: array of ISQLParameter): IStatement; overload;
    function Parse(const Parameters: ISQLParameterList): IStatement; overload;
    constructor Create(const StoredText: IStoredText);
    class function New(const StoredText: IStoredText): ISQL;
  end;

implementation

function TStoredSQL.Syntax: String;
begin
  Result := _SQL.Syntax;
end;

function TStoredSQL.Parse(const Parameters: ISQLParameterList): IStatement;
begin
  Result := _SQL.Parse(Parameters);
end;

function TStoredSQL.Parse(const Parameters: array of ISQLParameter): IStatement;
begin
  Result := _SQL.Parse(Parameters);
end;

constructor TStoredSQL.Create(const StoredText: IStoredText);
begin
  _SQL := TSQL.New(StoredText.Content);
end;

class function TStoredSQL.New(const StoredText: IStoredText): ISQL;
begin
  Result := TStoredSQL.Create(StoredText);
end;

end.
