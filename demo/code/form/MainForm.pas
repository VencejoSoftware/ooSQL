{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  Key,
  SQLFilter,
  AndSQLJoin,
  IntegerSQLParameterValue, StringSQLParameterValue, DateSQLParameterValue,
  NotEqualSQLCondition,
  SQLParameter, DynamicSQLParameter,
  SQL, SQLFiltered;

type
  TMainForm = class(TForm)
    btnParse: TButton;
    edSQLRaw: TMemo;
    edSQLParsed: TMemo;
    DynamicParam: TLabel;
    edParamName: TEdit;
    edParamValue: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnParseClick(Sender: TObject);
  end;

var
  NewMainForm: TMainForm;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TMainForm.btnParseClick(Sender: TObject);
var
  SQL: ISQLFiltered;
  Param: ISQLParameter;
  Filter: ISQLFilter;
  ParamList: ISQLParameterList;
  SyntaxFormat: ISyntaxFormat;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  Filter := TSQLFilter.New(TAndSQLJoin.New, SyntaxFormat);
  if Length(edParamValue.Text) > 0 then
  begin
    Param := TSQLParameter.NewWithOutName;
    Param.ChangeValue(TStringSQLParameterValue.New(edParamValue.Text));
    Filter.ConditionList.Add(TNotEqualSQLCondition.New(TTextKey.New(edParamName.Text), Param, SyntaxFormat));
  end;
  SQL := TSQLFiltered.New(edSQLRaw.Text, Filter);
  ParamList := TSQLParameterList.New;
  ParamList.Add(TDynamicSQLParameter.New('PARAM1'));
  ParamList.Last.ChangeValue(TIntegerSQLParameterValue.New(100));
  ParamList.Add(TDynamicSQLParameter.New('PARAM2'));
  ParamList.Last.ChangeValue(TStringSQLParameterValue.New('Text value%'));
  ParamList.Add(TDynamicSQLParameter.New('PARAM3'));
  ParamList.Last.ChangeValue(TDateSQLParameterValue.NewDefault(Now));
  ParamList.Add(TDynamicSQLParameter.New('PARAM4'));
  ParamList.Last.ChangeValue(TDateSQLParameterValue.NewDefault(Now + 1));
  edSQLParsed.Text := SQL.Parse(ParamList);
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  SQL = //
    'SELECT' + sLineBreak + //
    '  A.FIELD1, A.FIELD2, A.FIELD3, B.FIELD1' + sLineBreak + //
    'FROM TABLE1 A' + sLineBreak + //
    '  JOIN TABLE2 B ON A.FIELD1 = B.FIELD1' + sLineBreak + //
    'WHERE' + sLineBreak + //
    '  A.FIELD1 = :PARAM1' + sLineBreak + //
    '  AND A.FIELD2 LIKE :PARAM2' + sLineBreak + //
    '  OR A.FIELD3 BETWEEN :PARAM3 AND :PARAM4' + sLineBreak + //
    'ORDER BY' + sLineBreak + //
    '  A.FIELD2;';
begin
  edSQLRaw.Lines.Text := SQL;
end;

end.
