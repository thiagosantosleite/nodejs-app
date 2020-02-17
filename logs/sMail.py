#!/usr/bin/python3
import smtplib

### configs
gmail_user = 'xxxxx'
gmail_password = 'xxxxxxx'
sent_from = gmail_user
to = 'xxxxxx@gmail.com'
subject = 'Report'

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
  with open('out.out', 'r') as file:
    body=file.read()
  print(body)
  sendMail(body)


if __name__ == '__main__':
   main()
