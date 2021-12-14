#!/bin/bash

## tool to search for vulnerability CVE-2021-44228
## this tool scans all running JVMs and checks if log4j is a loaded class in
## the JVM.  If it is loaded, it means that whatever you're running that requires
## a patch, it needs to come from it's vendor.
## This script needs to be executed as root to ensure that all running JVMs are scanned.
## make sure the output is redirected to a file for better analysis
## in case there are many JVMs running in your box.
##
## DEPENDENCIES: This requires JDK 8 as a minimum for JAVA_HOME (jps/jmap/jcmd)
##
## USAGE ./check_log4j.sh > some_output_file.txt
## created by theonlyguz on 12-10-2012
## version: 1.0

## Important to set this up before running.
export JAVA_HOME=<location to java_home>
export PATH=$JAVA_HOME/bin:$PATH


## Let's search for all java processes running on the box that are currently running
## and run jmap on them to check if log4j is loaded 
for process in `$JAVA_HOME/bin/jps | grep -v Jps | awk '{print $1}'`; 
do 
    echo Checking process $process
    ## if you feel so inclined, change "log4j" below for "org.apache.log4j"
    $JAVA_HOME/bin/jmap -histo $process | grep org.apache.log4j; 
    retcode=$?
    if [ "$retcode" == "1" ]
    then
        echo Process $process has not loaded classes in log4j package
    else
        echo Process $process is in trouble...
    fi
done

echo Done.

