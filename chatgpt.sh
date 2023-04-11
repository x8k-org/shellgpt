#!/usr/bin/env bash

source "${HOME}/.chatgpt/chatgpt"
source ./chatgpt_lib.sh

#MODEL="text-davinci-003"
#TEMPERATURE="0"
#MAX_TOKEN=4000
#BEARER=""

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -m|--model)
      MODEL="$2"
      shift
      shift
      ;;
    -t|--temperature)
      TEMPERATURE="$2"
      shift
      shift
      ;;
    -k|--max-tokens)
      MAX_TOKEN="$2"
      shift
      shift
      ;;
    -b|--bearer)
      BEARER="$2"
      shift
      shift
      ;;
    -p|--prompt)
      PROMPT="$2"
      shift
      shift
      ;;
  esac
done

check_config

echo "$CURLSTRING"
result=$(eval curl "$CURLSTRING")
exit_code=$?

check_chat_gpt_error "$result"

if [ $exit_code -ne 0 ]; then
    cat /tmp/curl_err
    exit $exit_code
else
    ppchatgpt "$result"
fi
exit 0
