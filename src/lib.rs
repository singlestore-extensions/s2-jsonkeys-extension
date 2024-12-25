wit_bindgen_rust::export!("build/extension.wit");

struct Extension;

extern crate jsonpath_lib;
extern crate serde_json;

#[inline(never)]
#[no_mangle]
#[allow(non_snake_case)]
fn ERROR__MALFORMED_JSON() {
    panic!("ERROR__MALFORMED_JSON");
}

#[inline(never)]
#[no_mangle]
#[allow(non_snake_case)]
fn ERROR__MALFORMED_JSONPATH() {
    panic!("ERROR__MALFORMED_JSONPATH");
}

impl extension::Extension for Extension {
    fn jsonkeys_scalar(json: String, exprs: Vec<String>) -> String {
        serde_json::ser::to_string(&Self::jsonkeys_table(json, exprs)).unwrap()
    }

    fn jsonkeys_table(json: String, exprs: Vec<String>) -> Vec<String> {
        let mut es = exprs;
        if es.len() == 0 {
            es = vec![String::from("$")];
        }
        let mut res: Vec<String> = vec![];
        for e in es {
            let v = serde_json::from_str(json.as_str())
                .map_err(|_| ERROR__MALFORMED_JSON())
                .unwrap();
            let out = jsonpath_lib::select(&v, e.as_str())
                .map_err(|_| ERROR__MALFORMED_JSONPATH())
                .unwrap();
            for o in out.iter() {
                if let serde_json::Value::Object(m) = o {
                    for (k, _) in m {
                        res.push(k.clone());
                    }
                }
            }
        }
        res
    }
}