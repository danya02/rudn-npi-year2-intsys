from tempfile import tempdir
import jinja2
from tetris_config import *
template = open("domain-tetris.pddl.jinja2").read()
template = jinja2.Template(template)
print(template.render(**globals()))
