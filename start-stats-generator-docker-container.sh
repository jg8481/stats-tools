#! /bin/bash

clear
TIMESTAMP=$(date)


if [ "$1" == "Build-Images-Teardown-Old-Docker-Containers" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  echo
  echo "------------------------------------[[[[ Build Images And Teardown Old Docker Containers ]]]]------------------------------------"
  echo
  echo "This will build the Docker images and teardown/remove running containers defined in the docker-compose.yml file. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker stop $(docker ps -a -q) 2> /dev/null &&
  docker rm $(docker ps -a -q) 2> /dev/null &&
  docker image prune --force
  TIMESTAMP2=$(date)
  echo "This build ended on $TIMESTAMP2."
fi

if [ "$1" == "Generate-All-Stats" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Generate-All-Stats ]]]]------------------------------------"
  echo
  echo "This Docker Container will safelty run the stats-tools binaries inside an ephemeral Docker container. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Generate-All-Stats
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  docker-compose -f docker-compose.yml down 2> /dev/null &&
  docker-compose -f docker-compose.yml rm -f 2> /dev/null &&
  docker image prune --force
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

if [ "$1" == "Generate-Using-Specific-Utiliy" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  echo
  echo "------------------------------------[[[[ Test Tool Docker Container - Generate-All-Stats ]]]]------------------------------------"
  echo
  echo "This Docker Container will safelty run the stats-tools binaries inside an ephemeral Docker container. This run started on $TIMESTAMP."
  echo
  docker-compose -f docker-compose.yml down
  docker-compose -f docker-compose.yml rm -f
  docker-compose -f docker-compose.yml build
  docker-compose run docker-test-runner commands-running-inside-a-docker-container.sh Generate-Using-Specific-Utiliy "$2"
  docker stop $(docker ps -a -q) &&
  docker rm $(docker ps -a -q)
  docker-compose -f docker-compose.yml down 2> /dev/null &&
  docker-compose -f docker-compose.yml rm -f 2> /dev/null &&
  docker image prune --force
  TIMESTAMP2=$(date)
  echo "This test run ended on $TIMESTAMP2."
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "Please read the following to get a full explanation about how this works."
  echo
  echo "https://github.com/jg8481/stats-tools#readme"
  echo
  echo
}

error_handler() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"
if [[ -z $argument ]] ; then
  usage_explanation
else
  case $argument in
    -h|--help)
      usage_explanation
      ;;
    *)
      usage_explanation
      ;;
  esac
fi