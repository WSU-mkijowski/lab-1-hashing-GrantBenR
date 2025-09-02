NONCE_LENGTH=5
NONCE_STRING=""
IN_PATH="./data/quiz_data.csv"
OUT_PATH="./data/salted-data2.csv"
SOLUTION_PATH="./data/salted-data2-solution.csv"
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
COUNT=0
# Clear the output file
printf "" > "$OUT_PATH"
printf "" > "$SOLUTION_PATH"
# Print the column headers to out file
printf "FLastName, Attempt #,Attempt Start,Attempt End,Section #,Q #,Q Type,Q Title,Q Text,Bonus?,Difficulty,Answer,Answer Match,Score,Out Of\n" >> "$OUT_PATH"
printf "FLastName, Attempt #,Attempt Start,Attempt End,Section #,Q #,Q Type,Q Title,Q Text,Bonus?,Difficulty,Answer,Answer Match,Score,Out Of\n" >> "$SOLUTION_PATH"
while read FLastName Attempt_Num Attempt_Start Attempt_End Section_Num Q_Num Q_Type Q_Title Q_Text Bonus Difficulty Answer Answer_Match Score_Out_Of; do
  if [[ "$COUNT" != 0 ]]; then
    # Generate a Number Nonce of length NONCE_LENGTH
    NONCE_MAX=$(( 10**$NONCE_LENGTH ))
    NONCE=$(( RANDOM % $NONCE_MAX + 1 ))
    NONCE_STR=$(( "$NONCE" ))
    UNHASHED_TERM="${NONCE_STR}${FLastName}"
    HASHED_TERM=$( printf "%s" "$UNHASHED_TERM" | sha256sum | awk '{print $1}' )
    # Append to output file
    printf "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n" "$HASHED_TERM" "$Attempt_Num" "$Attempt_Start" "$Attempt_End" "$Section_Num" "$Q_Num" "$Q_Type" "$Q_Title" "$Q_Text" "$Bonus" "$Difficulty" "$Answer" "$Answer_Match" "$Score_Out_Of" >> "$OUT_PATH"
    printf "%s - %s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n" "$HASHED_TERM" "$UNHASHED_TERM" "$Attempt_Num" "$Attempt_Start" "$Attempt_End" "$Section_Num" "$Q_Num" "$Q_Type" "$Q_Title" "$Q_Text" "$Bonus" "$Difficulty" "$Answer" "$Answer_Match" "$Score_Out_Of" >> "$SOLUTION_PATH"
  fi
  COUNT=$(( $COUNT + 1 ))
done < "$IN_PATH"
