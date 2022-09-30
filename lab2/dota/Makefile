all: domain.pddl problem-hurt-self.pddl

problem-hurt-self.pddl: problem-hurt-self-template.pddl make-pddl.py includes/*
	python make-pddl.py problem-hurt-self-template.pddl > problem-hurt-self.pddl

domain.pddl: domain-template.pddl make-pddl.py includes/*
	python make-pddl.py domain-template.pddl > domain.pddl

clean:
	rm -f domain.pddl problem-hurt-self.pddl

env:
	echo "Run 'planutils activate' now:"
	docker run --mount type=bind,source="/home/danya/Documents/university/rudn-npi-year2-intsys/lab2/dota",target="/root/data" -it --privileged planutils bash