CREATE FUNCTION jsonkeys_table(json longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL, expr array(text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL)) 
RETURNS TABLE(table_col text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL)
AS WASM FROM LOCAL INFILE "extension.wasm"
WITH WIT FROM LOCAL INFILE "extension.wit"
USING EXPORT 'jsonkeys-table';

CREATE FUNCTION jsonkeys_scalar(json longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL, expr array(text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL)) 
RETURNS text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL 
AS WASM FROM LOCAL INFILE "extension.wasm"
WITH WIT FROM LOCAL INFILE "extension.wit"
USING EXPORT 'jsonkeys-scalar';