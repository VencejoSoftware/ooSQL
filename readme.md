[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Build Status](https://travis-ci.org/VencejoSoftware/ooSQL.svg?branch=master)](https://travis-ci.org/VencejoSoftware/ooSQL)

# ooSQL - Object pascal SQL parser library
Library to parse and build SQLs sintax, defining dynamic/static/mutable/callbackable parameters and joins filtering

### Example of parsing a simple select syntax
```pascal
uses
  SQLParameterValue,
  StringSQLParameterValue,
  MutableSQLParameter,
  SQL;
...
var
  SQL: ISQL;
  Param1, Param2: IMutableSQLParameter;
begin
  SQL := TSQL.New('UPDATE TEST T SET :FIELD_NAME_STR1 = :FIELD_STR1;');
  Param1 := TMutableSQLParameter.New('FIELD_NAME_STR1');
  Param1.ChangeValue(TSQLParameterValue.New('FIELD1'));
  Param2 := TMutableSQLParameter.New('FIELD_STR1');
  Param2.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  ShowMessage(SQL.Parse([Param1, Param2]).Syntax);
end;
```

### Example of parsing with an SQLFiltered object
```pascal
uses
  StringSQLParameterValue, IntegerSQLParameterValue,
  StaticSQLParameter,
  NoneSQLJoin, AndSQLJoin,
  EqualSQLCondition, NotEqualSQLCondition,
  SQLFilter,
  SQLFiltered, SQL;
...
var
  Filter: ISQLFilter;
  Param1, Param2: ISQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Param1 := TStaticSQLParameter.NewWithOutName(TStringSQLParameterValue.New('SOME TEXT'));
  Param2 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(666));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TSQLField.New('FieldText'), Param1)));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TAndSQLJoin.New, TNotEqualSQLCondition.New(TSQLField.New('FieldInt'), Param2)));
  SQL := TSQLFiltered.New('SELECT * FROM TEST', Filter);
  ShowMessage(SQL.Parse([]).Syntax);
end;
```

### Example of stored sql in file and parameter value callback
Create a text file called select.sql with this content:
> SELECT 1 FROM TABLE WHERE FIELD_DATE > :ParamDate AND FIELD_DOUBLE = :ParamDouble
```pascal
uses
  SQLParameter, DynamicSQLParameter,
  SQLParameterValue, ExtendedSQLParameterValue, DateSQLParameterValue,
  FileStoredText,
  SQL, StoredSQL;
...
var
  SQL: ISQL;
  ParameterList: ISQLParameterList;
begin
  SQL := TStoredSQL.New(TFileStoredText.New('.\select.sql'));
  ParameterList := TSQLParameterList.New;
  ParameterList.Add(TDynamicSQLParameter.New('ParamDate',
    function(const Parameter: ISQLParameter): ISQLParameterValue
    begin
      Result := TDateSQLParameterValue.New(Now);
    end));
  ParameterList.Add(TDynamicSQLParameter.New('ParamDouble',
    function(const Parameter: ISQLParameter): ISQLParameterValue
    begin
      Result := TExtendedSQLParameterValue.NewDefault(12.123);
    end));
  ShowMessage(SQL.Parse(ParameterList).Syntax);
end;
```

### Documentation
If not exists folder "code-documentation" then run the batch "build_doc". The main entry is ./doc/index.html

### Demo
Before all, run the batch "build_demo" to build proyect. Then go to the folder "demo\build\release\" and run the executable.

## Dependencies
* [ooGeneric](https://github.com/VencejoSoftware/ooGeneric.git) - Generic object oriented list
* [ooText](https://github.com/VencejoSoftware/ooText.git) - Object pascal string library

## Built With
* [Delphi&reg;](https://www.embarcadero.com/products/rad-studio) - Embarcadero&trade; commercial IDE
* [Lazarus](https://www.lazarus-ide.org/) - The Lazarus project

## Contribute
This are an open-source project, and they need your help to go on growing and improving.
You can even fork the project on GitHub, maintain your own version and send us pull requests periodically to merge your work.

## Authors
* **Alejandro Polti** (Vencejo Software team lead) - *Initial work*