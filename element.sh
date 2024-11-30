#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN() {
  if [[ ! $1 ]] 
  then
    echo "Please provide an element as an argument."
  else
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      RESULT=$($PSQL "SELECT atomic_number,symbol,type,atomic_mass,name,melting_point_celsius,boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1")
    elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
    then
      RESULT=$($PSQL "SELECT atomic_number,symbol,type,atomic_mass,name,melting_point_celsius,boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    else
      RESULT=$($PSQL "SELECT atomic_number,symbol,type,atomic_mass,name,melting_point_celsius,boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1'")
    fi
    OUTPUT_DATA $RESULT
  fi
}
OUTPUT_DATA() {
  if [[ -z $1 ]] 
  then
    echo "I could not find that element in the database."
  else
    echo "$1" | while IFS="|" read ATOMIC_NUMBER SYMBOL TYPE ATOMIC_MASS NAME MELTING_POINT BOILING_POINT
    do
      echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed -E 's/^ *| *$//g') is $(echo $NAME | sed -E 's/^ *| *$//g') ($(echo $SYMBOL | sed -E 's/^ *| *$//g')). It's a $(echo $TYPE | sed -E 's/^ *| *$//g'), with a mass of $(echo $ATOMIC_MASS | sed -E 's/^ *| *$//g') amu. $(echo $NAME | sed -E 's/^ *| *$//g') has a melting point of $(echo $MELTING_POINT | sed -E 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING_POINT | sed -E 's/^ *| *$//g') celsius."
    done
  fi
}
MAIN $1

