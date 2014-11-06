##*****************************************************************************
## Brooke Reams
## www.geospatialanalyst.com
## Feb. 21, 2010
## This is a sample script for auto-generating an email upon the completion of
##    a script.
##*****************************************************************************

# Import proper modules
import arcgisscripting, smtplib, sys, os, logging, traceback, time
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import COMMASPACE, formatdate
from email import Encoders
from time import strftime

# Create geoprocessor object
gp = arcgisscripting.create()

def mail(status):

    # Initialize message
    message = MIMEMultipart()

    if status == 1: # If script completed successfully
        # Set up subject
        subject  = "Script Completed Successfully!"
    else: # If script failed
        # Set up subject and body
        subject = "Script Failed"
        mailtext = "See log file attached."
        message.attach( MIMEText(mailtext) )
        # Add logFile as mail attachment
        logFile = "C:/TEMP/logfile.log" ## <-- CHANGE
        attachment = MIMEBase('application', "octet-stream")
        attachment.set_payload( open(logFile,"rb").read() )
        Encoders.encode_base64(attachment)
        attachment.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(logFile))
        message.attach(attachment)

    # Set SMTP Authentifiction
    AUTHREQUIRED = 0 # if you need to use SMTP Authentification set to 1
    #smtpuser = 'smtp.user@domain.com'
    #smtppass = 'smtppassword'

    recipients = ["receiver@geospatialanalyst.com",] ## <-- CHANGE
    for recipient in recipients:    
        # Set up from/to
        sender = "Sender's Name <sender@geospatialanalyst.com>" ##<-- CHANGE
        to = recipient

        # Set up email
        message["From"]    = sender
        message["To"]      = to
        message['Date']    = formatdate(localtime=True)
        message["Subject"] = subject

        # IP or name of mail server
        mailServer = smtplib.SMTP('<mailserver_name>') ## <-- CHANGE
        if AUTHREQUIRED:
            mailServer.login(smtpuser, smtppass)
        # Send e-mail
        mailServer.sendmail(sender, to, message.as_string())
        mailServer.quit()

def main():
    logFile = "C:/TEMP/logfile.log" ## <-- CHANGE
    flag = 0 # Flag changes to 1 in last line of try block

    try:
        # Open log file in 'append' mode
        logFile = open(logFile, "a")
        logFile.write("\n")
        logFile.write("*************************************************" + "\n")
        
        # Write start time to log
        logFile.write("\n")
        logFile.write(time.strftime("%m-%d-%Y %H:%M:%S") + "\n")

        #*********************************************************************
        # Main script here.
        #*********************************************************************

        logFile.write("Script completed successfully" + "\n")
        # Last line of try block should change the value of the flag
        # to determine if success or failure email should be generated.
        flag = 1
        
    except arcgisscripting.ExecuteError:
        # Get the geoprocessing error messages
        msgs = gp.GetMessage(0)
        msgs += gp.GetMessages(2)

        # Write gp error messages to log
        logFile.write(msgs + "\n")


    except:
        # Get the traceback object
        tb = sys.exc_info()[2]
        tbinfo = traceback.format_tb(tb)[0]

        # Concatenate information together concerning the error into a message string
        pymsg = tbinfo + "\n" + str(sys.exc_type)+ ": " + str(sys.exc_value)

        # Write Python error messages to log
        logFile.write(pymsg + "\n")


    # Write new line and close log
    logFile.write("*************************************************" + "\n")
    logFile.close()

    # Email log file
    mail(flag)

if __name__ == "__main__":
    main()

