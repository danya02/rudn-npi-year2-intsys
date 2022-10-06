all: domain.pddl gate-test

domain.pddl: domain-template.pddl make-pddl.py
	python make-pddl.py domain-template.pddl simple_maze.json > domain.pddl

gate-test: maze-template.pddl make-pddl.py gate-test.json
	python make-pddl.py maze-template.pddl gate-test.json > current-map.pddl
	cp gate-test.json current_map.json



clean:
	rm -f domain.pddl simple-maze.pddl simple-move.pddl current_map.json current-map.pddl current-map.pddl.plan ff_plan sas_plan
	rm -f output/*

plan-convert:
	python ff_plan_converter.py

visonly:
	python visualizer.py

vis: all plan-convert visonly

gif: all
	convert -delay 15 output/*.png output/animation.gif

env:
	echo "Run 'planutils activate' now:"
	docker run --mount type=bind,source="/home/danya/Documents/university/rudn-npi-year2-intsys/lab2/maze",target="/root/data" -it --privileged planutils bash