--kpis

UPDATE `kpi_value_definition` SET `render_pattern`=':default_currency_code :d' where `name`='kpi.pe_actuals.main.name';
UPDATE `kpi_value_definition` SET `render_pattern`=':default_currency_code :d' where `name`='kpi.pe_actuals.additional1.name';
UPDATE `kpi_value_definition` SET `render_pattern`=':default_currency_code :d' where `name`='kpi.pe_actuals.additional2.name';

--//@UNDO


