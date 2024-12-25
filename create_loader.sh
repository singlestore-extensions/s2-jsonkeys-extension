WASM_PATH=target/wasm32-wasip1/release/extension.wasm
WIT_PATH=build/extension.wit
WASM_B64=$(base64 -w 0 "${WASM_PATH}")
WIT_B64=$(base64 -w 0 "${WIT_PATH}")

OUTFILE=build/load_extension.sql

rm -f $OUTFILE

cat <<EOF >> $OUTFILE
CREATE OR REPLACE FUNCTION jsonkeys_table(json longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL, expr array(text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL)) RETURNS TABLE(table_col text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL)
AS WASM FROM BASE64 '$WASM_B64';
EOF

cat <<EOF >> $OUTFILE
CREATE OR REPLACE FUNCTION jsonkeys_scalar(json longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL, expr array(text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL)) RETURNS text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL 
AS WASM FROM BASE64 '$WASM_B64';
EOF

echo "Loader created successfully."
