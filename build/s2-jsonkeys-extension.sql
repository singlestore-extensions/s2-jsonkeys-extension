CREATE FUNCTION jsonkeys_table(json LONGTEXT, expr array(TEXT)) 
RETURNS TABLE(table_col TEXT)
AS WASM FROM LOCAL INFILE "extension.wasm"
WITH WIT FROM LOCAL INFILE "extension.wit"
USING EXPORT 'jsonkeys-table';

CREATE FUNCTION jsonkeys_scalar(json LONGTEXT, expr array(TEXT)) 
RETURNS TEXT
AS WASM FROM LOCAL INFILE "extension.wasm"
WITH WIT FROM LOCAL INFILE "extension.wit"
USING EXPORT 'jsonkeys-scalar';