# JSON Keys functions

**Attention**: The code in this repository is intended for experimental use only and is not fully tested, documented, or supported by SingleStore. Visit the [SingleStore Forums](https://www.singlestore.com/forum/) to ask questions about this repository.

## Deployment to SingleStoreDB
To install these functions using the MySQL client, use the following commands.  They assume you have built the Wasm module and your current directory is the root of this Git repo.  Replace '$DBUSER`, `$DBHOST`, `$DBPORT`, and `$DBNAME` with, respectively, your database username, hostname, port, and the name of the database where you want to deploy the functions.
```bash
mysql -u $DBUSER -h $DBHOST -P $DBPORT -D $DBNAME -p < load_extension.sql
```

## Using the Functions

For the case of the examples below, the `bookjson` column has entries of the
following form:
```
{
    "category": "web",
    "language": "en",
    "title": "XQuery Kick Start",
    "authors": {
        "first": "James McGovern",
        "second": "Per Bothner",
        "third": "Kurt Cagle",
        "fourth": "James Linn",
        "fifth": "Vaidyanathon Nagarajan"
    },
    "year": 2003,
    "price": 49.99
}
```

An example of using the UDF to retrieve top-level keys:
```
select jsonkeys_scalar(bookjson, []) as x from booktable;
```

An example of using the UDF to retrieve keys from two levels:
```
select jsonkeys_scalar(bookjson, ['$', '$.authors']) as x from booktable;
```

An example of using the TVF to retrieve top-level keys:
```
select j.* from booktable b, jsonkeys_table(b.bookjson, []) as j;
```
