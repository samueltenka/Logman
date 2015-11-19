CPPFLAGS = -c -std=c++11 -Wall -Wextra -Wvla -pedantic -O3
#CPPFLAGS = -pg -c -std=c++11 -Wall -Wextra -Wvla -pedantic -g3 -O3 -fno-elide-constructors
#to do profiling, add -pg flag to g++ below:
logman: Main.o LogReader.o LogPrinter.o Index.o CommandReader.o TimeToNum.o
	g++ Main.o LogReader.o LogPrinter.o Index.o CommandReader.o TimeToNum.o -o logman
Main.o: Main.cpp GetParams.h Log.h Debug.h ExcerptList.h SearchResults.h VectorIntersect.h CountComp.h
	g++ $(CPPFLAGS) Main.cpp -o Main.o
LogReader.o: LogReader.cpp Log.h Debug.h
	g++ $(CPPFLAGS) LogReader.cpp -o LogReader.o
LogPrinter.o: LogPrinter.cpp Log.h Debug.h
	g++ $(CPPFLAGS) LogPrinter.cpp -o LogPrinter.o
Index.o: Index.cpp Index.h Log.h Debug.h Lexer.h TimeComparator.h ExcerptListComparator.h
	g++ $(CPPFLAGS) Index.cpp -o Index.o
CommandReader.o: CommandReader.cpp Command.h Debug.h Lexer.h
	g++ $(CPPFLAGS) CommandReader.cpp -o CommandReader.o
TimeToNum.o: TimeToNum.cpp Log.h Debug.h
	g++ $(CPPFLAGS) TimeToNum.cpp -o TimeToNum.o


clean:
	rm -rf Main.o LogReader.o LogPrinter.o Index.o CommandReader.o TimeToNum.o logman

encrypt: Main.cpp GetParams.h Debug.h
	python encrypt.py < key
	python decrypt.py < key
	git add *.enc
#commit:
#	git commit -m "unhelpful message..."
#	git push origin master < credentials

timeall: logman
	echo all; time ./logman correct_samples/sample-log.txt < correct_samples/sample-all-cmds.txt > correct_samples/out-all.txt
	gprof logman > wisdom_
testcorrect: logman
	echo k; time ./logman correct_samples/sample-log.txt < correct_samples/sample-k-cmds.txt > correct_samples/out-k.txt
	echo c; time ./logman correct_samples/sample-log.txt < correct_samples/sample-c-cmds.txt > correct_samples/out-c.txt
	echo t; time ./logman correct_samples/sample-log.txt < correct_samples/sample-t-cmds.txt > correct_samples/out-t.txt
	echo d; time ./logman correct_samples/sample-log.txt < correct_samples/sample-d-cmds.txt > correct_samples/out-d.txt
	echo e; time ./logman correct_samples/sample-log.txt < correct_samples/sample-e-cmds.txt > correct_samples/out-e.txt
	echo b; time ./logman correct_samples/sample-log.txt < correct_samples/sample-b-cmds.txt > correct_samples/out-b.txt
	echo q; time ./logman correct_samples/sample-log.txt < correct_samples/sample-q-cmds.txt > correct_samples/out-q.txt
	echo spec; time ./logman correct_samples/spec-test-log.txt < correct_samples/spec-test-cmds.txt > correct_samples/out-spec.txt
	echo all; time ./logman correct_samples/sample-log.txt < correct_samples/sample-all-cmds.txt > correct_samples/out-all.txt
checkcorrect:
	#python trim.py
	diff correct_samples/sample-q-out.txt correct_samples/out-q.txt > correct_samples/diff-q.txt
	diff correct_samples/sample-b-out.txt correct_samples/out-b.txt > correct_samples/diff-b.txt
	diff correct_samples/sample-e-out.txt correct_samples/out-e.txt > correct_samples/diff-e.txt
	diff correct_samples/sample-d-out.txt correct_samples/out-d.txt > correct_samples/diff-d.txt
	diff correct_samples/sample-t-out.txt correct_samples/out-t.txt > correct_samples/diff-t.txt
	diff correct_samples/sample-c-out.txt correct_samples/out-c.txt > correct_samples/diff-c.txt
	diff correct_samples/sample-all-out.txt correct_samples/out-all.txt > correct_samples/diff-all.txt
	diff correct_samples/sample-k-out.txt correct_samples/out-k.txt || exit 0 # > correct_samples/diff-k.txt
	diff correct_samples/spec-test-out-correct.txt correct_samples/out-spec.txt|| exit 0 # > correct_samples/diff-spec.txt
