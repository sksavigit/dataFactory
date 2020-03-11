#!/bin/bash
# Author : Susil Kumar Nagarajan, Hexaware Technologies
# Created: 2017 February 
# Purpose: Data Extraction Automation Process - 
#          dataFactory->run.sh should be able to process given SQLs
# JIRA Ref: SCM-19203




if [[ $# -eq 0 || $# -gt 1 ]]
then
	echo "To process weekly extractions:"
	echo "Usage: prompt> run.sh w"
	echo
	echo "To process monthly extractons:"
	echo "Usage: prompt> run.sh m"
	echo
	exit 1;
fi


flagV=$1_
SCRIPT_PATH=/interface/dataFactory/scripts/SQLs/
DATA_PATH=/interface/dataFactory/data/
ARCHIVE_PATH=/interface/dataFactory/data/backup/
MAIL_GROUP=`cat mail.group`
MAIL_SENDER=`cat mail.sender`
LOG_DIR=/interface/dataFactory/log/
LOG_FILE=/interface/dataFactory/log/`date +%Y%m%d%H%M%S`.log
SQL_FLUSH=sqlFlush.log
SEARCHSQL=`ls -1 $SCRIPT_PATH$flagV*.sql`
ERROR_LOG=/interface/dataFactory/log/err.log
echo "Data factory process started `date +%Y%m%d%H%M%S`" > $LOG_FILE

#Archive files created before
#Clear up files created 6 months before
echo "Backup started " >> $LOG_FILE
find $ARCHIVE_PATH -mtime +90 -exec rm {} +
mv $DATA_PATH$flagV*.csv $ARCHIVE_PATH
echo "Backup completed" >> $LOG_FILE
sleep 5 #Wait for 5 seconds before going to next step

echo ' '> $ERROR_LOG

for var in $SEARCHSQL
do
   echo 'Processing script '$var >> $LOG_FILE
   cat fileFormat.config > runScript.sql
   echo '@'$var >> runScript.sql
   echo 'exit'  >> runScript.sql
   sqlplus / @runScript.sql > $SQL_FLUSH
   errCount=`cat $SQL_FLUSH | grep "ORA"|wc -l`
   if [ $errCount -gt 0 ]
   then
	echo  'SQL '$var' gone into error' >>$ERROR_LOG
	echo  '' >>$ERROR_LOG
	#cat $SQL_FLUSH | egrep "ERROR">>$ERROR_LOG
   	cat $SQL_FLUSH | egrep "ORA">>$ERROR_LOG
 	echo ''>>$ERROR_LOG  
 fi
done

#echo
#echo "Preparing - Master Script" >> $LOG_FILE
#echo
#cat fileFormat.config > masterScript.sql
#ls -lrt $SCRIPT_PATH$flagV*.sql | awk '{print "PROMPT Script:"$9"-Started\n@"$9";\nPROMPT Script:"$9"-Completed\n"}'|grep -v "@;" >> masterScript.sql
#echo "exit;">>masterScript.sql
#echo "Master script created successfully!" >> $LOG_FILE
#sleep 5 #wait for 5 seconds before going to next step
#sqlplus / @masterScript.sql > $LOG_DIR$SQL_FLUSH
#cat $LOG_DIR$SQL_FLUSH | grep "ORA">>$LOG_FILE;
#rm $LOG_DIR$SQL_FLUSH;
#echo "Data factory process completed successfully `date +%Y%m%d%H%M%S` " >> $LOG_FILE;

#Send notification to SD_BOCH
cat mail.header > mail.content
ls -lrth $DATA_PATH$flagV*  | awk '{print $9 "     Size:" $5 "  "$8" "$7" "$6}'>>mail.content
errCount=`cat $ERROR_LOG|grep "ORA"|wc -l`
if [ $errCount -gt 0 ]
then
echo ''>>mail.content
echo ''>>mail.content
echo '**********************'>>mail.content
echo 'Errors during runtime:'>>mail.content
echo '**********************'>>mail.content
cat $ERROR_LOG >>mail.content
echo
fi
cat mail.footer >> mail.content
cat mail.disclaimer>>mail.content

mail -s 'Data Factory - Notification :'`date +%Y%m%d` -r $MAIL_SENDER $MAIL_GROUP < mail.content
echo "Email notification processed successfully" >> $LOG_FILE
exit 0;
