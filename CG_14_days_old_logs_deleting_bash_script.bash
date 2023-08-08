//////////////////////////////////////////BLUE PRINT///////////////////////////////////////////////////////////////////////////////////////////////
01.check logs older than 14days (/logs)

	find /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/logs/ -mtime +14 -type f

02.check status of tomcat

	/usr/local/java/amazon-corretto-1/usr/local/java/amazon-corretto-11.0.7.10.1/bin/jps | grep Bootstrap | grep -v grep | awk '{print $1}'

03.down the tomcat 

	kill -9 PID

04.delete logs files

	find /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/logs/ -mtime +14 -type f -delete

05.start tomcat

	cd /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/bin 
	./sartup.sh

/////////////////////////////////////////SIMPLE STEPS//////////////////////////////////////////////////////////////////////////////////////////                

#!/bin/bash
						
APP_BASE_PATH=/usr/local/tbx/vhpurple/apache-tomcat-9.0.36
tomcatPID=$(/usr/local/java/amazon-corretto-11.0.7.10.1/bin/jps | grep Bootstrap | grep -v grep | awk '{print $1}')
old_log_count=$(find /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/logs/ -mtime +14 -type f | wc -l)

echo "There are $old_log_count logs available at $APP_BASE_PATH/logs dir"  
echo "Stopping purple tomcat ...!"
sh /home/vhpurple/Do_Not_Delete/AppStop.sh
echo "Deleting files older than 14 days on $APP_BASE_PATH/logs dir"
##find /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/logs/ -mtime +14 -type f -delete
sleep 3
echo "Starting purple tomcat ...!"
sh /home/vhpurple/Do_Not_Delete/AppStart.sh
sleep 5
exit 0
	
	
//////////////////////////////////////////IF ELSE ////////////////////////////////////////////////////////////////////////////////////////////

APP_BASE_PATH=/usr/local/tbx/vhpurple/apache-tomcat-9.0.36
tomcatPID=$(/usr/local/java/amazon-corretto-11.0.7.10.1/bin/jps | grep Bootstrap | grep -v grep | awk '{print $1}')



if [ "$tomcatPID" == "" ]
then
	echo "Tomcat is Stoped . . !"
	echo "Deleting logs Files  . . !"
	find /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/logs/ -mtime +14 -type f -delete
	echo "logs files deleted  . . !"
	echo "Starting Tomcat Service . . !"
    cd $APP_BASE_PATH/bin/
	pwd
	./startup.sh
	sleep 3
	echo "Tomcat Service Started . . !"

else
    echo "Tomcat is Running . . !"
	echo "Stopping Tomcat Service . . !"
	echo "Stopping Tomcat using process id of $tomcatPID . . !"
	kill -9 $tomcatPID
	echo "Waiting for process $tomcatPID to end . . !"
	sleep 3
	echo "Process $tomcatPID has Stopped . . !"
	echo "Deleting logs Files  . . !"
	find /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/logs/ -mtime +14 -type f -delete
	echo "logs files deleted  . . !"
	echo "Starting Tomcat Service . . !"
    cd $APP_BASE_PATH/bin/
	pwd
	./startup.sh
	sleep 3
	echo "Tomcat Service Started . . !"

fi
	
	
///////////////////////////////////////////////USING FUNCTIONS////////////////////////////////////////////////////////////////////////////


APP_BASE_PATH=/usr/local/tbx/vhpurple/apache-tomcat-9.0.36
tomcatPID=$(/usr/local/java/amazon-corretto-11.0.7.10.1/bin/jps | grep Bootstrap | grep -v grep | awk '{print $1}')

tomcat_stop () { 
    echo "Tomcat is Running . . !"
	echo "Stopping Tomcat Service . . !"
	echo "Stopping Tomcat using process id of $tomcatPID . . !"
	kill -9 $tomcatPID
	echo "Waiting for process $tomcatPID to end . . !"
	sleep 3
	echo "Process $tomcatPID has Stopped . . !"
}

tomcat_start () { 
    echo "Starting Tomcat Service . . !"
    cd $APP_BASE_PATH/bin/
	pwd
	./startup.sh
	sleep 3
	echo "Tomcat Service Started . . !"
}

delete_logs () { 
    echo "Deleting logs Files  . . !"
	find /usr/local/tbx/vhpurple/apache-tomcat-9.0.36/logs/ -mtime +14 -type f -delete
	echo "logs files deleted  . . !"
}


if [ "$tomcatPID" == "" ]
then
	echo "Tomcat is Stoped . . !"
	delete_logs 
	
else
	tomcat_stop 
	delete_logs 
	tomcat_start 
	
fi
	
