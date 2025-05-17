#!/usr/bin/env bash

getVariableValue() {
  local in_variable_name="$1"
  eval "printf '%s\n' \"\$$in_variable_name\""
}

replace() {
  local in_text_value="$1"
  local in_to_replace="$2"
  local in_replaced_with="$3"

  # Transform the text value by replacing the delimiter with a newline
  local transformed_value="$(echo "${in_text_value}" | tr "${in_to_replace}" "${in_replaced_with}")"

  echo "${transformed_value}"
}



