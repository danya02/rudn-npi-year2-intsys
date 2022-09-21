CC = g++

CFLAGS = -Wall -O3

GRAPH_XML=maps/instance6.xml
# Set GRAPH_XML from the Make command line
GRAPH_DB=$(GRAPH_XML:.xml=.db)
GRAPH_TXT=$(GRAPH_XML:.xml=.txt)

all: search.o graph_accessor.o neighbor_struct.o lab1.o debug.h
	$(CC) $(CFLAGS) *.o -o program.out

search.o: search.cpp search.h debug.h
	$(CC) $(CFLAGS) -c search.cpp

graph_accessor.o: graph_accessor.cpp graph_accessor.h debug.h
	$(CC) $(CFLAGS) -c graph_accessor.cpp

neighbor_struct.o: neighbor_struct.cpp debug.h
	$(CC) $(CFLAGS) -c neighbor_struct.cpp

lab1.o: lab1.cpp debug.h
	$(CC) $(CFLAGS) -c lab1.cpp

run: $(GRAPH_TXT) all
	./program.out $(GRAPH_TXT)

runn: clean run

$(GRAPH_TXT): $(GRAPH_XML) graph_from_xml.py graph_into_simple_text.py
	python3 graph_from_xml.py $(GRAPH_XML) $(GRAPH_DB)
	python3 graph_into_simple_text.py $(GRAPH_DB) $(GRAPH_TXT)


clean:
	rm -f *.out *.o
	rm -f maps/*.db maps/*.txt