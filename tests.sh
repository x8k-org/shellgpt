#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export DIR
echo $DIR

PROMPT='testing'
export PROMPT
source ./chatgpt_lib.sh

std_chatgpt_error='{
    "error": {
        "message": "You exceeded your current quota, please check your plan and billing details.",
        "type": "insufficient_quota",
        "param": null,
        "code": null
    }
}'

test-check_chat_gpt_error_exceeded_quota() {
  got=$(check_chat_gpt_error "$std_chatgpt_error")
  expected='"You exceeded your current quota, please check your plan and billing details."'
  assertEquals "Error on chat gpr erro" "$expected" "$got"
}

test-ppchatgpt_simple_output(){
  got=$(ppchatgpt "$(cat "$DIR/mock/simple_output.json")")
  expected='What day of the week is it?'
  assertEquals "Error on ppchatgpt parsing with simple output" "$expected" "$got"
}

test-ppchatgpt_multiline_output(){
  got=$(ppchatgpt "$(cat "$DIR/mock/multiline_output.json")")

  read -r -d '' expected <<'EOF'
What day of the week is it?
Are you sure?
Let's try this!
EOF
  assertEquals "Error on ppchatgpt parsing with multiline output" "$expected" "$got"
}

# Load shUnit2.
# shellcheck disable=SC1091
# shellcheck source=/shunit2/shunit2
. "${DIR}"/shunit2/shunit2