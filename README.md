# env miniobjects

## The Aim Of The Setup

The easy format to store one level objects In .env files.

Just comma delimitered key value pairs joined with equal symbol.

*ENV_SETTING="name=port, value=8443, secure=true"*


```env
# .env.example

all_variables_typeof_miniobject="env_variable_1_typeof_miniobject, env_variable_2_typeof_miniobject"

env_variable_1_typeof_miniobject="name=ConfFile, type=JaisocxConfSetting, value=conf/http-conf-tests.xml, description=The conf file for running tests on the Jaisocx.com Sites Server"
env_variable_2_typeof_miniobject="name=ConfFile, type=JaisocxConfSetting, value=conf/http-conf-dev.xml, description=The conf file to publish sites in development"

```



### Obtained a field value, by variable passed by reference and field name.

```bash
#!/usr/bin/env bash

### code snippet from: ./test_example.sh

set -a
source "./.env.example"
source ./env_miniobjects_transformer.sh


### Usage
### Obtained a field value, by variable passed by reference and field name.
field_value="$(getByEnvMiniobject_Text "${env_variable_1_typeof_miniobject}" "type")"

echo "${field_value}"



set +a
```




### transformer has method toJson

```bash
#!/usr/bin/env bash

### code snippet from: ./test_example.sh

set -a
source "./.env.example"
source ./env_miniobjects_transformer.sh

all_variables_typeof_miniobject="env_variable_1_typeof_miniobject, env_variable_2_typeof_miniobject"
toJson "${all_variables_typeof_miniobject}" > all_variables_typeof_miniobject.json

set +a
```



```json
// all_variables_typeof_miniobject.json
[
    {
        "name": "ConfFile",
        "type": "JaisocxConfSetting",
        "value": "conf/http-conf-tests.xml",
        "description": "The conf file for running tests on the Jaisocx.com Sites Server"
    },
    {
        "name": "ConfFile",
        "type": "JaisocxConfSetting",
        "value": "conf/http-conf-dev.xml",
        "description": "The conf file to publish sites in development"
    }
]
```

