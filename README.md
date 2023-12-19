# JSON Keys functions

## Using the functions

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
