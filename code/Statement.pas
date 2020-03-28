{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object statement
  @created(29/05/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit Statement;

interface

uses
  IterableList;

type
{$REGION 'documentation'}
{
  @abstract(Statement interface)
  @member(
    Syntax Resolve as text
    @return(String with syntax)
  )
}
{$ENDREGION}
  IStatement = interface
    ['{5293668F-F38E-4170-AC79-EB9AE7A7F663}']
    function Syntax: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Statement list interface)
}
{$ENDREGION}

  IStatementList = interface(IIterableList<IStatement>)
    ['{A7AF1832-AAC9-41AC-BB3B-E93B5F738E82}']
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IStatementList))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TStatementList = class sealed(TIterableList<IStatement>, IStatementList)
  public
    class function New: IStatementList;
  end;

implementation

class function TStatementList.New: IStatementList;
begin
  Result := TStatementList.Create;
end;

end.
