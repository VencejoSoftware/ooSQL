{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL syntax join object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLJoin;

interface

uses
  Statement;

type
{$REGION 'documentation'}
{
  @abstract(SQL syntax join object)
  Object to resolve a SQL join syntax
}
{$ENDREGION}
  ISQLJoin = interface(IStatement)
    ['{649F75F9-E28B-47AC-8679-77D3EF643F33}']
  end;

implementation

end.
