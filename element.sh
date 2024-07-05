#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_MENU() {
  if [ $# -eq 0 ];
  then 
echo "Please provide an element as an argument."

 else

 # Variable for checking the input
 if [[ $1 =~ ^[-+]?[0-9]+$ ]]; then
ITSANATOMICNUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
 else
ITSASYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
ITSANAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
fi

# Check if$1 exist in a symbol column
 if [[ $ITSASYMBOL = $1 ]]
  then 
  echo "It's a symbol"
 
# Else check if $1 exist in a names column 
  elif [[ $ITSANAME = $1 ]]
  then
   echo "It's a name"

# Check if$1 exist in an atomic numbers column
   elif [[ $ITSANATOMICNUMBER = $1 ]]
    then 
    echo "It's an atomic number"
# It doesn't exist in our database
  else 
  echo "I could not find that element in the database."
  fi


  fi
}

MAIN_MENU "$@"
