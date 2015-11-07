import encryptlib

key = raw_input("key? ")
with open("encrypt_names") as myfile:
   filenames = myfile.read().split()

for fn in filenames:
   with open(fn, "rb") as myfile:
      text = myfile.read()
   with open(fn+'.enc', "wb") as myfile:
      myfile.write(''.join(encryptlib.encrypt(text, key)))
