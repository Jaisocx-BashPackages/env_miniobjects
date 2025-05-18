#!/usr/bin/env bash

### env_miniobjects_parser




## IMPORTS
this_script_folder_path="$(dirname "${BASH_SOURCE[0]:-$0}")"
source "${this_script_folder_path}/env_miniobjects_base.sh"


getByEnvMiniobject_Name() {
  local in_variable_name="$1"
  local in_field_name="$2"

  local loc_platform_variable_value="$(getVariableValue "${in_variable_name}")"

  getByEnvMiniobject_Text "${loc_platform_variable_value}" "${in_field_name}" "$3" "$4"
}


# model="$(getValueFromMap Apple_Silicon model)"
# echo -e "${model}"
getByEnvMiniobject_Text() {
    local in_variable_value="$1"
    local in_key="$2"

    local in_delimiter__fields="$3"
    local in_delimiter__field_key_value="$4"


    local loc_const_delimiter__fields=","
    local loc_const_delimiter__field_key_value="="

    if [[ -n "${in_delimiter__fields}" ]]; then
      loc_const_delimiter__fields="${in_delimiter__fields}";
    fi

    if [[ -n "${in_delimiter__field_key_value}" ]]; then
      loc_const_delimiter__field_key_value="${in_delimiter__field_key_value}";
    fi


    local loc_field_value="$(getKeyValuePair_Value "${in_variable_value}" "${in_key}" "${loc_const_delimiter__fields}" "${loc_const_delimiter__field_key_value}")"

    echo "${loc_field_value}"
}


getKeyValuePair_Value() {
  local in_array__text="$1"
  local in_key="$2"
  local in_array__delimiter="$3"
  local in_key_value__delimiter="$4"

  # Extract the key-value pair using grep and cut
  local loc_value="$(echo "${in_array__text}" | tr "${in_array__delimiter}" '\n' | grep "${in_key}${in_key_value__delimiter}" | cut -d"${in_key_value__delimiter}" -f2- | xargs)"

  echo "${loc_value}"
}





