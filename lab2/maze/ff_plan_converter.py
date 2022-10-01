import sys
ff_output = open('ff_plan', 'r')
ff_plan = []
inside_plan_section = 0
for line in ff_output:
    if 'ff: goal can be simplified to FALSE. No plan will solve it' in line:
        print(line)
        sys.exit(1)
    if 'ff: found legal plan as follows' in line:
        inside_plan_section = 2
    elif inside_plan_section:
        if line.strip() == '':
            inside_plan_section -= 1
            if inside_plan_section <= 0:
                continue
        else:
            ff_plan.append(line.strip())

out = open('sas_plan', 'w')
for line in ff_plan:
    if line.startswith('step'):
        line = line.replace('step','')
    line = line.strip()
    if not ':' in line: continue
    index, _, action = line.partition(':')
    action = action.strip().lower()
    print('(', action, ')', sep='', file=out)
out.close()
print('Wrote sas_plan', file=sys.stderr)