CPPFLAGS = -c -std=c++11 -Wall -Wextra -Wvla -pedantic -g3 -O3
#CPPFLAGS = -pg -c -std=c++11 -Wall -Wextra -Wvla -pedantic
#to do profiling, add -pg flag to g++ below:
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

encrypt: Main.cpp GetParams.h Debug.h
	python encrypt.py < key
	python decrypt.py < key
	git add *.enc
#commit:
#	git commit -m "unhelpful message..."
#	git push origin master < credentials

testcorrect: logman
	./logman correct_samples/sample-log.txt < correct_samples/sample-c-cmds.txt > correct_samples/out-c.txt
	./logman correct_samples/sample-log.txt < correct_samples/sample-k-cmds.txt > correct_samples/out-k.txt
	./logman correct_samples/sample-log.txt < correct_samples/sample-t-cmds.txt > correct_samples/out-t.txt
	./logman correct_samples/sample-log.txt < correct_samples/sample-b-cmds.txt > correct_samples/out-b.txt
	./logman correct_samples/sample-log.txt < correct_samples/sample-e-cmds.txt > correct_samples/out-e.txt
	./logman correct_samples/sample-log.txt < correct_samples/sample-q-cmds.txt > correct_samples/out-q.txt
	./logman correct_samples/sample-log.txt < correct_samples/sample-d-cmds.txt > correct_samples/out-d.txt
	./logman correct_samples/spec-test-log.txt < correct_samples/spec-test-cmds.txt > correct_samples/out-spec.txt
checkcorrect:
	diff correct_samples/sample-q-out.txt correct_samples/out-q.txt > correct_samples/diff-q.txt
	diff correct_samples/sample-b-out.txt correct_samples/out-b.txt > correct_samples/diff-b.txt
	diff correct_samples/sample-e-out.txt correct_samples/out-e.txt > correct_samples/diff-e.txt
	diff correct_samples/sample-c-out.txt correct_samples/out-c.txt > correct_samples/diff-c.txt
	diff correct_samples/sample-k-out.txt correct_samples/out-k.txt > correct_samples/diff-k.txt
	diff correct_samples/sample-t-out.txt correct_samples/out-t.txt > correct_samples/diff-t.txt
	diff correct_samples/sample-d-out.txt correct_samples/out-d.txt > correct_samples/diff-d.txt
	diff correct_samples/spec-test-out-correct.txt correct_samples/out-spec.txt > correct_samples/diff-spec.txt
