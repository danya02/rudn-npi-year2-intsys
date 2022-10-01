all: domain.pddl portal-trans-test

domain.pddl: domain-template.pddl make-pddl.py
	python make-pddl.py domain-template.pddl simple_maze.json > domain.pddl

simple-maze: maze-template.pddl make-pddl.py simple_maze.json
	python make-pddl.py maze-template.pddl simple_maze.json > current-map.pddl
	cp simple_maze.json current_map.json

simple-move: maze-template.pddl make-pddl.py simple_move.json
	python make-pddl.py maze-template.pddl simple_move.json > current-map.pddl
	cp simple_move.json current_map.json

portal-move-test: maze-template.pddl make-pddl.py portal_move_test.json
	python make-pddl.py maze-template.pddl portal_move_test.json > current-map.pddl
	cp portal_move_test.json current_map.json


color-remove-test: maze-template.pddl make-pddl.py color_remove_test.json
	python make-pddl.py maze-template.pddl color_remove_test.json > current-map.pddl
	cp color_remove_test.json current_map.json

color-trans-test: maze-template.pddl make-pddl.py color_trans_test.json
	python make-pddl.py maze-template.pddl color_trans_test.json > current-map.pddl
	cp color_trans_test.json current_map.json

portal-trans-test: maze-template.pddl make-pddl.py portal_trans_test.json
	python make-pddl.py maze-template.pddl portal_trans_test.json > current-map.pddl
	cp portal_trans_test.json current_map.json


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