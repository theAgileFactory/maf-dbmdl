--Unable CSV for data quality report

UPDATE reporting SET formats='PDF,EXCEL' WHERE template='data_quality' LIMIT 1;

--//@UNDO

UPDATE reporting SET formats='PDF,EXCEL,CSV' WHERE template='data_quality' LIMIT 1;




