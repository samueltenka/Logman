from random import choice
num_lines = 20
len_line = 2000
len_word = 2
len_timestamps = 5
alphabet = 'abcdefghijklmnopqrstuvwxyz'
alphabet += 'ABCDEFGHIKLMNOPQRSTUV'
digits = '0'*30 + '0123456789' #to bias numbers to 0, encouraging ties
def gen_word():
   return ''.join(choice(alphabet) for i in range(len_word))
def gen_timestamp():
   return ':'.join(choice(digits)+choice(digits) for i in range(len_timestamps))
def gen_line():
   return gen_timestamp()+'|'+gen_word()+'|'+\
          choice(' ,./<>?;\':"[]\\{}`-=~!@#$%^&*()_+').join(gen_word() for i in range(len_line))
def gen_log():
   return '\n'.join(gen_line() for i in range(num_lines))

coms = 'rrrslgpadddecccckkkkkktttt' # no q; extra r,d, c,k,t
#coms = 'kt'
def gen_com():
   letter = choice(coms)
   if letter in 'rslgpq':
      return letter
   elif letter in 'ade':
      return letter+' '+str(choice(range(int(num_lines*1.5))))
   elif letter in 'ck':
      len_com = {'c':1,'k':2}[letter]
      return letter+' '+' '.join(gen_word() for i in range(len_com))
   elif letter in 't':
      s = gen_timestamp()
      t = s[:8] + ':99:99' #later time
      return 't '+s+'|'+t
   print('ERROR!')
def gen_cmnds():
   return '\n'.join(gen_com() for i in range(num_lines-2)) + '\ng\nq'

for i in range(1,16):
   filenamel = 'test-'+str(i)+'-log.txt'
   with open(filenamel, "w") as myfile:
      myfile.write(gen_log())
   filenamec = 'test-'+str(i)+'-cmds.txt'
   with open(filenamec, "w") as myfile:
      myfile.write(gen_cmnds())
