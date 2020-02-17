#!/usr/bin/python3

def parseText():
  count = {}

  with open('/var/log/nginx/access.log','r') as file:
     line = file.readline()
     while line:
       ## ignore empty lines
       if line.strip() != '' and len(line.split(' ')) == 7:
         url=line.split(' ')[4]
         status=line.split(' ')[6]
         index = '{} {}'.format(url, status)
         count[index]=count.get(index, 0) + 1
       line = file.readline()

  return sorted(count.items(), key=lambda x: x[1],reverse=True)


def createFile(body):
  with open('out.out', 'w') as file:
     for item in body:
       file.write(' {} {} {}'.format(item[1], item[0].split(' ')[0], item[0].split(' ')[1]))
     file.close()


def main():
  body=parseText()
  print(body)
  createFile(body)


if __name__ == '__main__':
   main()

