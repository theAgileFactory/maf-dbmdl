UPDATE `kpi_definition` SET `object_type`='models.pmo.PortfolioEntry', `order`='10', `css_glyphicon`='glyphicons glyphicons-scale'  WHERE `uid`='KPI_RELEASE_BURNDOWN' LIMIT 1;


--//@UNDO

UPDATE `kpi_definition` SET `object_type`='models.delivery.Release', `order`='0', `css_glyphicon`='glyphicons glyphicons-scale-classic' WHERE `uid`='KPI_RELEASE_BURNDOWN' LIMIT 1;






