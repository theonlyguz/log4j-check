# log4j-check

Tool to search for vulnerability CVE-2021-44228
this tool scans all running JVMs and checks if log4j is a loaded class in
the JVM.  If it is loaded, it means that whatever you're running that requires
a patch, it needs to come from it's vendor.
This script needs to be executed as root to ensure that all running JVMs are scanned.
make sure the output is redirected to a file for better analysis
in case there are many JVMs running in your box.

##DEPENDENCIES: 
This requires JDK 8 as a minimum for JAVA_HOME (jps/jmap/jcmd)

##USAGE 
./check_log4j.sh > some_output_file.txt

##Additional info:
version: 1.0 - Created by theonlyguz


Important note: READ WHAT YOU HAVE TO DO IN LINE 17 of the .sh file.

