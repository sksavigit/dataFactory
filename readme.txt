README INSTRUCTION 1: Copy dataFactory onto / folder in linux
README INSTRUCTION 2: OPEN /dataFactory/scripts folder
		    : Modify mail.config,mail.footer,mail.sender
		    : Modify VARIABLES if you have copied dataFactory onto folder different than "/"
		    : Check /dataFactory/scripts/run.sh -> line no 47 to set SQL login 

README INSTRUCTION 3: OPEN /dataFactory/scripts/SQLs
		    : Chek the sample SQLs
		    : Your SQL files have to follow the same pattern

			Example:
				spool on
				spool /dataFactory/data/m_data.csv
				Select 'Dual Column' from dual;
				Select * from dual;
				spool off;

README INSTRUCTION 4: Once you are done with above steps, go ahead execute data factory.
		    : Ex.
		    : /dataFactory/scripts/run.sh w # To run weekly extractions
		    : /dataFactory/scripts/run.sh m # To run monthly extractions
		    : /dataFactory/scripts/run.sh d # To run daily extractions

Should you have any questions or help on setting this up, please drop an email at sksavi@yahoo.com.
Thank you!
