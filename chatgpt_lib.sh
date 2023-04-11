#!/usr/bin/env bash

check_config() {
  EXIT_VALUE=128
  [ -z "$PROMPT" ] && echo "prompt cannot be null" && exit $EXIT_VALUE
  [ -z "$TEMPERATURE" ] && echo "temperature cannot be null" && exit $EXIT_VALUE
  [ -z "$MAX_TOKEN" ] && echo "max-token cannot be null" && exit $EXIT_VALUE
  [ -z "$MODEL" ] && echo "model cannot be null" && exit $EXIT_VALUE
   [ -z "$BEARER" ] && echo "bearer cannot be null" && exit $EXIT_VALUE
}

check_chat_gpt_error(){
  error_message=$(echo "$1"| jq '.error'.message)
  [ -n "$error_message" ] && echo "$error_message" && exit 1
}

ppchatgpt(){
  echo "$1"| jq --raw-output '.choices[]'.text
}

read -r -d '' CURLSTRING <<EOFCS
  -k \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $BEARER" \
  -d '{
  "model": "$MODEL",
  "prompt": "$PROMPT",
  "max_tokens": $MAX_TOKEN,
  "temperature": $TEMPERATURE
}' \
  https://api.openai.com/v1/completions 2>/tmp/curl_err
EOFCS
export CURLSTRING