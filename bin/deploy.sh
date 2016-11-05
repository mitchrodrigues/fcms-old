#!/bin/bash

# EEEEEEEEEEEEWWWWWWWWW Lets use capistrano
function timestamp() {
  date +"%T"
}


set -x


rm -rf public/*

pushd ../fcms-ui/
  brunch build #--production
popd 

rm -rf fcms.war
# warble runnable executable war
bundle exec warble runnable executable war


ssh fcms@fcms.sjc.taazoo.cc -- "set -x; mv fcms.war packs/fcms.$(date +"%Y-%m-%d_%H-%M-%S").war"
scp fcms.war fcms@fcms.sjc.taazoo.cc:

ssh fcms@fcms.sjc.taazoo.cc -- "pkill -9 -f java"
ssh fcms@fcms.sjc.taazoo.cc -- <<-HEREDOC 
	set -x; 
	source ~/app_env;
	setsid java -Dwarbler.port=8080 -Dlogback.configurationFile=logback.xml=logback.xml -jar fcms.war >log/fcms.log  2>&1 &
HEREDOC


