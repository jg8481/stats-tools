#!/bin/bash

clean_up() {
  rm -rf ./LICENSE
  rm -rf ./README.md
  rm -rf ./bin
  rm -rf ./stats-tools-linux-amd64-0.0.1*
  rm -rf ./stats-tools-linux-amd64-0.0.1.zip*
}

get_tools() {
  wget https://github.com/jweslley/stats-tools/releases/download/v0.0.1/stats-tools-linux-amd64-0.0.1.zip
  unzip stats-tools-linux-amd64-0.0.1.zip 
}

run_stats_generators() {
  chmod +x -R ./bin/
  ./bin/$1 $2
}

if [ "$1" == "Generate-All-Stats" ]; then
  echo
  echo
  ls -la 
  cd /test
  clean_up
  get_tools
  echo "Output for the >> stats << utility is shown below..."
  run_stats_generators "stats" "-c 2 -s , /test/example2.dat"
  clean_up
  echo
  echo
  ls -la 
  echo
  echo
fi

if [ "$1" == "Generate-Using-Specific-Utiliy" ]; then
  echo
  echo
  ls -la 
  cd /test
  clean_up
  get_tools
  echo
  echo
  echo "Output for the >> $2 << utility is shown below..."
  run_stats_generators "$2" "-c 2 -s , /test/example2.dat"
  clean_up
  echo
  echo
  ls -la 
  echo
fi
