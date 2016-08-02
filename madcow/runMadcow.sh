#!/bin/sh

set -e

if [ -z "$JAVA_HOME" ] ; then
    echo "environment variable JAVA_HOME must be set"
    exit 1
fi

function checkJavaVers {
    for token in $(java -version 2>&1)
    do
        if [[ $token =~ \"([[:digit:]])\.([[:digit:]])\.(.*)\" ]]
        then
            export JAVA_MAJOR=${BASH_REMATCH[1]}
            export JAVA_MINOR=${BASH_REMATCH[2]}
            export JAVA_BUILD=${BASH_REMATCH[3]}
            return 0
        fi
    done
    return 1
}

checkJavaVers || { echo "check failed" ; exit; }
if [ "$JAVA_MINOR" -lt "8" ]; then
  echo "Java needs to be v1.8 or greater!"
  exit 1
fi

export MADCOW_LIB_CLASSPATH=`find ./.madcow/lib -name "*.jar" | tr "\n" ":"`
export MADCOW_CONF_CLASSPATH=./conf
export PROJECT_LIB_CLASSPATH=`find ./lib -name "*.jar" | tr "\n" ":"`

export CLASSPATH=$MADCOW_LIB_CLASSPATH:$MADCOW_CONF_CLASSPATH:$PROJECT_LIB_CLASSPATH

$JAVA_HOME/bin/java $JAVA_OPTS -classpath $CLASSPATH au.com.ps4impact.madcow.execution.MadcowCLI $@
exitValue=$?

if [ $exitValue != 0 ]
then
  exit $exitValue
fi