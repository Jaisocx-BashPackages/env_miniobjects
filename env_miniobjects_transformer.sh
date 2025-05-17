#!/usr/bin/env bash

### env_miniobjects_transformer




## IMPORTS
source "./env_miniobjects_parser.sh"


extractOneField_ByVariablesNames() {
    in_variables_names="$1"
    in_field_name="$2"
    in_delimiter__miniobjects_names="$3"
    in_delimiter__fields="$4"
    in_delimiter__field_key_value="$5"

    ## default delimiter in miniobjects names list like this in .env.example:
    ##   all_variables_typeof_miniobject="env_variable_1_typeof_miniobject, env_variable_2_typeof_miniobject"
    ## comma char
    loc_const_delimiter__miniobjects_names=","
    if [[ -n "${in_delimiter__miniobjects_names}" ]]; then
      loc_const_delimiter__miniobjects_names="${in_delimiter__miniobjects_names}"
    fi

    local cycle_variable_name=""
    local loc_miniobject_name=""
    local loc_field_value=""

    local r_values=""

    local tmp_elems_in_array_delimiter=""
    local is_first_miniobject="true"
    
    IFS="${loc_const_delimiter__miniobjects_names}"; 
    for cycle_variable_name in ${in_variables_names}; do
      loc_miniobject_name="$(echo "${cycle_variable_name}" | xargs)"
      loc_field_value="$(getByEnvMiniobject_Name "${loc_miniobject_name}" "${in_field_name}" "${in_delimiter__fields}" "${in_delimiter__field_key_value}")"
      r_values="${r_values}${tmp_elems_in_array_delimiter}${loc_field_value}"

      if [[ "${is_first_miniobject}" == "true" ]]; then
        tmp_elems_in_array_delimiter=","
        is_first_miniobject="no"
      fi

    done;

    echo "${r_values}"
}


toJson() {
    in_variables_names="$1"
    in_delimiter__miniobjects_names="$2"
    in_delimiter__fields="$3"
    in_delimiter__field_key_value="$4"

    ## default delimiter in miniobjects names list like this in .env.example:
    ##   all_variables_typeof_miniobject="env_variable_1_typeof_miniobject, env_variable_2_typeof_miniobject"
    ## comma char
    loc_const_delimiter__miniobjects_names=","
    if [[ -n "${in_delimiter__miniobjects_names}" ]]; then
      loc_const_delimiter__miniobjects_names="${in_delimiter__miniobjects_names}"
    fi

    local loc_const_delimiter__fields=","
    if [[ -n "${in_delimiter__fields}" ]]; then
      loc_const_delimiter__fields="${in_delimiter__fields}";
    fi

    local loc_const_delimiter__field_key_value="="
    if [[ -n "${in_delimiter__field_key_value}" ]]; then
      loc_const_delimiter__field_key_value="${in_delimiter__field_key_value}";
    fi


    local cycle_variable_name=""
    local loc_miniobject_name=""
    local loc_miniobject_value=""
    local loc_field_value=""

    local loc_const_4_whitespaces="    "
    local loc_const_8_whitespaces="${loc_const_4_whitespaces}${loc_const_4_whitespaces}"
    local loc_const_new_line="\n"
    local pad_obj="${loc_const_new_line}${loc_const_4_whitespaces}"
    local pad_field="${loc_const_new_line}${loc_const_8_whitespaces}"


    local tmp_elems_in_array_delimiter=""
    local is_first_miniobject="true"

    local tmp_json_fields_delimiter=""
    local is_first_field="true"
    
    local loc_json=""


    ### json array opening square brace
    local loc_tmp="["
    loc_json="${loc_json}${loc_tmp}"


    IFS="${loc_const_delimiter__miniobjects_names}"; 
    for cycle_variable_name in ${in_variables_names}; do
      loc_miniobject_name="$(echo "${cycle_variable_name}" | xargs)"
      # echo -e "${loc_miniobject_name}"
      # break;

      loc_miniobject_value="$(getVariableValue "${loc_miniobject_name}")"
      # echo -e "${loc_miniobject_value}"
      # break;
      
      is_first_field="true"
      tmp_json_fields_delimiter=""

      ### json field opening figure brace
      loc_tmp="${tmp_elems_in_array_delimiter}${pad_obj}{"
      loc_json="${loc_json}${loc_tmp}"


      IFS="${loc_const_delimiter__fields}";
      for key_value_pair in ${loc_miniobject_value}; do
        # echo -e "${key_value_pair}"
        # break;

        loc_field_name="$(echo "${key_value_pair}" | cut -d"${loc_const_delimiter__field_key_value}" -f1 | xargs)"
        loc_field_value="$(echo "${key_value_pair}" | cut -d"${loc_const_delimiter__field_key_value}" -f2- | xargs)"



        ### json field serialized
        ### '\n        "key": "value"'
        ### ',\n        "key": "value"'
        loc_tmp="${tmp_json_fields_delimiter}${pad_field}\"${loc_field_name}\": \"${loc_field_value}\""
        loc_json="${loc_json}${loc_tmp}"

        # echo -e "${loc_json}"
        # break;


        if [[ "${is_first_field}" == "true" ]]; then
          tmp_json_fields_delimiter=","
          is_first_field="no"
        fi
      done;
      IFS="${loc_const_delimiter__miniobjects_names}"; 


      ### json field enclosing figure brace
      loc_tmp="${pad_obj}}"
      loc_json="${loc_json}${loc_tmp}"


      if [[ "${is_first_miniobject}" == "true" ]]; then
        tmp_elems_in_array_delimiter=","
        is_first_miniobject="no"
      fi

    done;

    ### json array enclosing square brace
    loc_tmp="${loc_const_new_line}]${loc_const_new_line}"
    loc_json="${loc_json}${loc_tmp}"

    echo -e "${loc_json}"
}







