import encryptlib

key = raw_input("key? ")
with open("encrypt_names") as myfile:
   filenames = myfile.read().split()

for fn in filenames:
   with open('encryption_files/'+fn+'.enc', "rb") as myfile:
      text = myfile.read()
   with open('encryption_files/'+fn+'.dec', "wb") as myfile:
      myfile.write(''.join(encryptlib.decrypt(text, key)))
