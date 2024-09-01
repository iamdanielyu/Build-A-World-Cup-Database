#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != "winner" ]]
  then
  WINNER_TEAMS=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    echo "$WINNER_TEAMS"
    OPPONENT_TEAMS=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    echo "$OPPONENT_TEAMS"
    WINNER_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    $GAMES=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNER_TEAM_ID', '$OPPONENT_TEAM_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')")
    echo "$GAMES"
  fi
done
