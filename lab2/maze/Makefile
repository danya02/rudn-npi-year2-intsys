all: domain.pddl plans

domain.pddl: domain-template.pddl make-pddl.py
	python make-pddl.py domain-template.pddl problems/simple_maze.json > domain.pddl

plans: problems/*
	python3 make-many-plans.py

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

env-solve:
	echo "Solving inside environment with FF"
	~/.planutils/packages/ff/bin/ff -o domain.pddl -f current-map.pddl | tee ff_plan

env-solve-sas:
	echo "Solving inside environment with Downward"
	~/.planutils/packages/downward/downward.sif domain.pddl current-map.pddl --search "astar(lmcut())"