CPPFLAGS = -c -std=c++11 -Wall -Wextra -Wvla -pedantic -g3 -O3
encrypt: Main.cpp GetParams.h Debug.h
	python encrypt.py < key
	python decrypt.py < key
#commit:
#	git commit -m "unhelpful message..."
#	git push origin master < credentials
logman: Main.o
	g++ Main.o -o logman
Main.o: Main.cpp GetParams.h Debug.h
	g++ $(CPPFLAGS) Main.cpp -o Main.o

clean:
	rm -rf RZG.o Main.o logman
