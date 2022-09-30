all: tetris

tetris: problem-tetris.pddl domain-tetris.pddl

problem-tetris.pddl: problem-tetris-gen.py tetris_config.py
	python problem-tetris-gen.py > problem-tetris.pddl

domain-tetris.pddl: domain-tetris-instantiate.py domain-tetris.pddl.jinja2 tetris_config.py
	python domain-tetris-instantiate.py > domain-tetris.pddl