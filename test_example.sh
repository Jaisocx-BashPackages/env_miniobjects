#!/usr/bin/env bash

set -a
source "./.env.example"
source "./env_miniobjects_parser.sh"
source "./env_miniobjects_transformer.sh"






Miniobject="name=ConfFile; type=JaisocxConfSetting; value=conf/http-conf-tests.xml; description=The conf file for running tests on the Jaisocx.com Sites Server;"



## The minimobject on line 12, is referenced here with name,
##    so, the import of "env_miniobjects_base.sh" is required.
## The miniobject has entries delimitered with ; (semicolons), 
##    and key value with = (equality sign) 
## 
exampleGetFieldValue() {

  local loc_field_value="$(getByEnvMiniobject_Name "Miniobject" "description" ";" "=")"

  echo "Queried on Miniobject, fields delimitered like http response heders fields values"
  echo "${Miniobject}"
  echo -e "${loc_field_value}\n\n"
}


## the minimobject on line 3, is passed by value,
##    has entries delimitered with , (comma char), 
##    and key value with : (colon char) 
## 
exampleGetFieldValue2() {
  local Miniobject2="name: ConfFile, type: JaisocxConfSetting, value: conf/http-conf-tests.xml, description: The conf file for running tests on the Jaisocx.com Sites Server"

  local loc_field_value="$(getByEnvMiniobject_Text "${Miniobject2}" "description" "," ":")"

  echo "Queried on Miniobject2 json-like delimitered"
  echo "${Miniobject2}"
  echo -e "${loc_field_value}\n\n"
}





echo -e "\n"

### functions imported from "./env_miniobjects_parser.sh"
### env_variable_1_typeof_miniobject : miniobject variable imported from ".env.example", on line 5. 

echo -e "\n"
echo "example: exampleGetFieldValue"
exampleGetFieldValue
echo "--------------------"


echo -e "\n"
echo "example: exampleGetFieldValue2"
exampleGetFieldValue2
echo "--------------------"

echo -e "\n"
echo "example: getByEnvMiniobject_Text"
getByEnvMiniobject_Text "${env_variable_1_typeof_miniobject}" "type"
echo "--------------------"



### functions imported from "./env_miniobjects_transformer.sh"
### .env.example, line 3: all_variables_typeof_miniobject

echo -e "\n"
echo "examples: extractOneField_ByVariablesNames"
echo -e "\n"
extractOneField_ByVariablesNames "${all_variables_typeof_miniobject}" "value"
echo "--------------------"
echo -e "\n"

toJson "${all_variables_typeof_miniobject}" > all_variables_typeof_miniobject.json
echo -e "\n"
echo "example: toJson"
toJson "${all_variables_typeof_miniobject}"
echo "--------------------"



echo -e "\n\n"

set +a














