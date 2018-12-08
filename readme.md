[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Build Status](https://travis-ci.org/VencejoSoftware/ooSQL.svg?branch=master)](https://travis-ci.org/VencejoSoftware/ooSQL)

# ooSQL - Object pascal SQL parser library
Library to parse SQL parameter syntax

### Simple parse example
```pascal
var
  SQL: ISQL;
  Param1, Param2: ISQLParameter;
begin
  SQL := TSQL.New('UPDATE TEST T SET :FIELD_NAME_STR1 = :FIELD_STR1');
  Param1 := TDynamicSQLParameter.New('FIELD_NAME_STR1');
  Param1.ChangeValue(TRawSQLParameterValue.New('FIELD1'));
  Param2 := TDynamicSQLParameter.New('FIELD_STR1');
  Param2.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  ShowMessage(SQL.Parse([Param1, Param2]));
end;
```

### Parse with dynamic filter example
```pascal
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, DefaultSyntaxFormat);
  Param1 := TSQLParameter.NewWithOutName;
  Param1.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TTextKey.New('Field1'),
    Param1, DefaultSyntaxFormat), DefaultSyntaxFormat));
  SQL := TSQLFiltered.New('SELECT * FROM TEST', Filter);
  ShowMessage(SQL.Parse([]));
end;
```

### Documentation
If not exists folder "code-documentation" then run the batch "build_doc". The main entry is ./doc/index.html

### Demo
Before all, run the batch "build_demo" to build proyect. Then go to the folder "demo\build\release\" and run the executable.

## Dependencies
* [ooGeneric](https://github.com/VencejoSoftware/ooGeneric.git) - Generic object oriented list
* [ooText](https://github.com/VencejoSoftware/ooText.git) - Object pascal string library
* [ooEntity](https://github.com/VencejoSoftware/ooEntity.git) - Interfaces for entity work

## Built With
* [Delphi&reg;](https://www.embarcadero.com/products/rad-studio) - Embarcadero&trade; commercial IDE
* [Lazarus](https://www.lazarus-ide.org/) - The Lazarus project

## Contribute
This are an open-source project, and they need your help to go on growing and improving.
You can even fork the project on GitHub, maintain your own version and send us pull requests periodically to merge your work.

## Authors
* **Alejandro Polti** (Vencejo Software team lead) - *Initial work*