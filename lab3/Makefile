all: run

calc.so: calc.cpp calc.h
	g++ -fPIC -shared -o calc.so calc.cpp

run: calc.so
	python3 main.py

clean: 
	rm -f calc.so *.png