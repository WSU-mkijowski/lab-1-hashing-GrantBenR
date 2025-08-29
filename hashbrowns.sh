NONCE_LENGTH=5
IN_PATH="./data/quiz_data.csv"
OUT_PATH="./data/salted-data2.csv"

# Get a valid nonce length
while [[ $IS_VALID eq 0 ]]; do
  read -p "How long should the nonce be?: " NONCE_LENGTH
  if [[ ! "$NONCE_LENGTH" =~ ^-?[0-9]+$ ]]; then
    echo "Invalid input: Please enter an integer."
    IS_VALID=0
  else
    IS_VALID=1
  fi
done

while read FLastName Attempt_Num Attempt_Start Attempt_End Section_Num Q_Num Q_Type Q_Title Q_Text Bonus Difficulty Answer Answer_Match Score_Out_Of; do
  # Generate a Number Nonce of length NONCE_LENGTH
  NONCE_MAX=$(( 10**$NONCE_LENGTH ))
  NONCE=$(( RANDOM % $NONCE_MAX + 1 ))
  NONCE_STR=$(( printf $NONCE ))
  UNHASHED_TERM="${NONCE_STR}${FLastName}"
  HASHED_TERM=$(( printf $UNHASHED_TERM | sha256sum ))
  # printf "${HASHED_TERM} - ${UNHASHED_TERM}" >> $OUT_PATH
  printf "${HASHED_TERM},${Attempt_Num},${Attempt_Start},${Attempt_End},${Section_Num},${Q_Num},${Q_Type},${Q_Title},${Q_Text},${Bonus},${Difficulty},${Answer},${Answer_Match},${Score_Out_Of}" >> $OUT_PATH
done < $IN_PATH

  