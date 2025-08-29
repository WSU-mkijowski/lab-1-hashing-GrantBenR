#!/bin/bash

COLLECTED_HASHES_COUNT=0
HASHES_TO_GET=0
ZEROES=0
NONCE_LENGTH=0
DICT_PATH="../data/words_alpha.csv"
OUT_PATH="./bash_hashes.csv"
# Get a valid input for the number of valid hashes to look for
while [[ "$IS_VALID" -eq 0 ]]; do
  read -p "How many valid hashes to get?: " HASHES_TO_GET
  if [[ ! "$HASHES_TO_GET" =~ ^-?[0-9]+$ ]]; then
    echo "Invalid input: Please enter an integer."
    IS_VALID=0
  else
    IS_VALID=1
  fi
done

# Get a valid number of zeroes to look for
while [[ "$IS_VALID" -eq 0 ]]; do
  read -p "How many leading zeroes?: " ZEROES
  if [[ ! "$ZEROES" =~ ^-?[0-9]+$ ]]; then
    echo "Invalid input: Please enter an integer."
    IS_VALID=0
  else
    IS_VALID=1
  fi
done

# Get a valid nonce length
while [[ "$IS_VALID" -eq 0 ]]; do
  read -p "How long should the nonce be?: " NONCE_LENGTH
  if [[ ! "$NONCE_LENGTH" =~ ^-?[0-9]+$ ]]; then
    echo "Invalid input: Please enter an integer."
    IS_VALID=0
  else
    IS_VALID=1
  fi
done

while [[ "$COLLECTED_HASHES_COUNT" -lt "$HASHES_TO_GET" ]]; do
  # Iterate over dictionary terms
  for DICT_TERM in $(cat $DICT_PATH); do
    printf $DICT_TERM
    # Generate a Number Nonce of length NONCE_LENGTH
    NONCE_MAX=$(( 10**$NONCE_LENGTH ))
    NONCE=$(( RANDOM % $NONCE_MAX + 1 ))
    NONCE_STR=$(( printf $NONCE ))
    UNHASHED_TERM="${NONCE_STR}${DICT_TERM}"
    HASHED_TERM=$(( printf $UNHASHED_TERM | sha256sum ))
    DIGIT_INDEX=0
    IS_VALID=1
    # Check digits until you hit the target number of digits ZEROES
    while [[ "$DIGIT_INDEX" -lt "$ZEROES" ]]: do
      NEXT_DIGIT_INDEX=$(( $DIGIT_INDEX + 1 ))

      if [[ "{$HASHED_TERM:$DIGIT_INDEX:$NEXT_DIGIT_INDEX}" -eq "0" ]]; then
        IS_VALID=1
      else
        IS_VALID=0
      if [[ "$IS_VALID" ]]; then
        # Update the count and list of valid hashes
        COLLECTED_HASHES_COUNT=$(($COLLECTED_HASHES_COUNT + 1))
        printf "${HASHED_TERM} - ${UNHASHED_TERM}" >> $OUT_PATH
      fi
    done
  done
done




