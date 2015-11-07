CPPFLAGS = -c -std=c++11 -Wall -Wextra -Wvla -pedantic -g3 -O3
encrypt: Main.cpp GetParams.h Debug.h
	python encrypt.py < key
	python decrypt.py < key
	git add *.enc
#commit:
#	git commit -m "unhelpful message..."
#	git push origin master < credentials
logman: Main.o LogReader.o
	g++ Main.o LogReader.o -o logman
Main.o: Main.cpp GetParams.h Debug.h Log.h
	g++ $(CPPFLAGS) Main.cpp -o Main.o
LogReader.o: LogReader.cpp Log.h Debug.h
	g++ $(CPPFLAGS) LogReader.cpp -o LogReader.o

clean:
	rm -rf RZG.o Main.o logman
