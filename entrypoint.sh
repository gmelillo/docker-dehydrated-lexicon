#!/bin/bash

# Check if the provider was selected
if [[ "$PROVIDER" == "unset" ]]; then
  echo "- Missing provider for lexicon."
  exit 1
fi

# If accounts not exists initialize
if [[ -z "$(ls -A /dehydrated/accounts)" ]]; then
  ./dehydrated --register --accept-terms
fi

exec ./dehydrated -c -t dns-01 -k $DEHYDRATED_HANDLER $@
