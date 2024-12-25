# SingleStore JSON Keys Extension (Rust)

**Attention**: The code in this repository is not fully tested, documented, or supported by SingleStore. Visit the [SingleStore Forums](https://www.singlestore.com/forum/) to ask questions about this repository.

## Introduction

This extension provides two functions, jsonkeys_scalar and jsonkeys_table, which use the jsonpath_lib crate to extract keys from JSON data based on specified expressions. The module handles errors by panicking with custom error messages if the input JSON or JSONPath expressions are malformed.

## Contents
Currently, this extension provides the following UDFs:

### `jsonkeys_scalar`
Retrieves top-level keys from a JSON object. More details can be found in [Create WASM UDFs](https://docs.singlestore.com/cloud/reference/code-engine-powered-by-wasm/create-wasm-udfs/).

### `jsonkeys_table`
Retrieves keys from a specified level in a JSON object. More details can be found in [Create WASM UDFs](https://docs.singlestore.com/cloud/reference/code-engine-powered-by-wasm/create-wasm-udfs/).

## Deployment to SingleStoreDB

### Using HTTP Link (recommended)
* The SingleStore Cluster has to be able to connect to this repository.
There should already be a pre-built `.tar` file in the root directory of this repository called `s2-jsonkeys-extension.tar`. If there is not, or you need to re-package it, please consult the [packaging](#packaging) steps below.

```sql
CREATE EXTENSION `s2-jsonkeys-extension` FROM HTTP 'https://github.com/singlestore-extensions/s2-jsonkeys-extension/-/raw/main/build/s2-jsonkeys-extension.tar';
```
* Verify the Extension `SHOW EXTENSIONS;`
* Verify the Functions `SHOW FUNCTIONS;`

### Using a Client
There should already be a pre-built Wasm file in the root directory of this repository, called `extension.wasm`. If there is not, or you need to rebuild it, please consult the [build](#building) steps below.

To install these functions using the SingleStore/MySQL client, use the following commands. They assume you have built the Wasm module and your current directory is the root of this repository. Please be sure to replace `$DBUSER`, `$DBHOST`, `$DBPORT`, and `$DBNAME` with, respectively, your database username, hostname, port, and the name of the database where you want to deploy the functions. The `-p` option will prompt you for a password.

```bash
singlestore -u $DBUSER -h $DBHOST -P $DBPORT -D $DBNAME -p < load_extension.sql
```

```bash
mysql -u $DBUSER -h $DBHOST -P $DBPORT -D $DBNAME -p < load_extension.sql
```

## Usage Example

### Retrieving Top-Level Keys
```sql
select jsonkeys_scalar(bookjson, []) as x from booktable;
```

### Retrieving Keys from Two Levels
```sql
select jsonkeys_scalar(bookjson, ['$', '$.authors']) as x from booktable;
```

## Building

### Compilation

To build this project, you will need to ensure that you have the
[WASI SDK](https://github.com/WebAssembly/wasi-sdk/releases) installed. Please
set the environment variable `WASI_SDK_PATH` to its top-level directory.

If you change the `extension.wit` file, you will need to regenerate the ABI
wrappers. To do this, make sure you have the wit-bindgen program installed.
Currently, SingleStoreDB only supports code generated using
[wit-bindgen v0.2.0](https://github.com/bytecodealliance/wit-bindgen/releases/tag/v0.2.0).

To compile:
```
make release
```

### Cleaning

To remove just the Wasm file:
```
make clean
```

To remove all generated files:
```
make distclean
```

## Packaging