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

# CHECK IF $1 EXIST IN A SYMBOL COLUMN
 if [[ $ITSASYMBOL = $1 ]]
  then 
 # Get atomic number
 ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1' ")
 # Get name
 NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
 # Get atomic mass
 ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
 # Get melting point
 MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER ")
 # Get boiling point
 BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER ")
 # Get type_id
 TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER ")
# Get the type
case $TYPE_ID in
    1) TYPE='metal' ;;
    2) TYPE='nonmetal' ;;
    3) TYPE='metalloid' ;;
  esac  

  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($1). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

# ELSE CHECK IF $1 EXIST IN A NAME COLUMN
  elif [[ $ITSANAME = $1 ]]
  then
   echo "It's a name"

# ELSE CHECK IF $1 EXIST IN ATOMIC NUMBER COLUMN
   elif [[ $ITSANATOMICNUMBER = $1 ]]
    then 
    echo "It's an atomic number"

# IT DOESN'T EXIST IN OUT DATABASE
  else 
  echo "I could not find that element in the database."
  fi


  fi
}

MAIN_MENU "$@"