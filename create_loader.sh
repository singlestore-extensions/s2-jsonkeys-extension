WASM_PATH=target/wasm32-wasi/release/jsonkeys.wasm
WIT_PATH=jsonkeys.wit
WASM_B64=$(base64 -w 0 "${WASM_PATH}")
WIT_B64=$(base64 -w 0 "${WIT_PATH}")

OUTFILE=load_extension.sql

rm -f $OUTFILE

cat <<EOF >> $OUTFILE
CREATE OR REPLACE FUNCTION jsonkeys_table RETURNS TABLE
AS WASM FROM BASE64 '$WASM_B64'
WITH WIT FROM BASE64 '$WIT_B64';
EOF

cat <<EOF >> $OUTFILE
CREATE OR REPLACE FUNCTION jsonkeys_scalar
AS WASM FROM BASE64 '$WASM_B64'
WITH WIT FROM BASE64 '$WIT_B64';
EOF

echo "Loader created successfully."
