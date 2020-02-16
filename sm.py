#!/usr/bin/python3
import smtplib

### configs
gmail_user = 'xxxxx'
gmail_password = 'xxxxxxx'
sent_from = gmail_user
to = 'xxxxxx@gmail.com'
subject = 'Report'


def parseText():
  count = {}

  with open('/var/log/nginx/access.log','r') as file:
     line = file.readline()
     while line:
       ## ignore empty lines
       if line.strip() != '':       
         url=line.split(' ')[4]
         status=line.split(' ')[6]
         index = '{}  {}'.format(url, status)
         count[index]=count.get(index, 0) + 1 
       line = file.readline()

  return sorted(count.items(), key=lambda x: x[1],reverse=True)



def sendMail(body):
  email_text = """\
From: %s
To: %s
Subject: %s

%s
""" % (sent_from, to, subject, body)

  server = smtplib.SMTP('smtp.gmail.com',587)
  server.ehlo()
  server.starttls()
  server.ehlo()
  server.login(gmail_user, gmail_password)
  server.sendmail(sent_from, to, email_text)
  server.close()
  print('Email sent!')
 

def main():
  body=parseText()
  print(body)
  sendMail(body)



if __name__ == '__main__':
   main()
