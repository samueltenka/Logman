CPPFLAGS = -c -std=c++11 -Wall -Wextra -Wvla -pedantic -g3 -O3
encrypt: Main.cpp GetParams.h Debug.h
	python encrypt.py < key
	python decrypt.py < key
	git add *.enc
#commit:
#	git commit -m "unhelpful message..."
#	git push origin master < credentials
logman: Main.o LogReader.o LogPrinter.o IndexSearch.o Index.o CommandReader.o TimeToNum.o
	g++ Main.o LogReader.o LogPrinter.o IndexSearch.o Index.o CommandReader.o TimeToNum.o -o logman
Main.o: Main.cpp GetParams.h Log.h Debug.h ExcerptList.h
	g++ $(CPPFLAGS) Main.cpp -o Main.o
LogReader.o: LogReader.cpp Log.h Debug.h
	g++ $(CPPFLAGS) LogReader.cpp -o LogReader.o
LogPrinter.o: LogPrinter.cpp Log.h Debug.h
	g++ $(CPPFLAGS) LogPrinter.cpp -o LogPrinter.o
Index.o: Index.cpp Index.h Log.h Debug.h Lexer.h
	g++ $(CPPFLAGS) Index.cpp -o Index.o
IndexSearch.o: IndexSearch.cpp Index.h Debug.h
	g++ $(CPPFLAGS) IndexSearch.cpp -o IndexSearch.o
CommandReader.o: CommandReader.cpp Command.h Debug.h
	g++ $(CPPFLAGS) CommandReader.cpp -o CommandReader.o
TimeToNum.o: TimeToNum.cpp Log.h Debug.h
	g++ $(CPPFLAGS) TimeToNum.cpp -o TimeToNum.o


clean:
	rm -rf Main.o LogReader.o LogPrinter.o IndexSearch.o Index.o CommandReader.o TimeToNum.o logman
