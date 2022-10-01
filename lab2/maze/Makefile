all: domain.pddl simple-maze.pddl

domain.pddl: domain-template.pddl make-pddl.py
	python make-pddl.py domain-template.pddl > domain.pddl

simple-maze.pddl: simple-maze-template.pddl make-pddl.py
	python make-pddl.py simple-maze-template.pddl > simple-maze.pddl

env:
	echo "Run 'planutils activate' now:"
	docker run --mount type=bind,source="/home/danya/Documents/university/rudn-npi-year2-intsys/lab2/maze",target="/root/data" -it --privileged planutils bash