import os
import subprocess

def make_single_plan(problem_json_name):
    # run `python3 make-pddl.py maze-template.pddl problems/{problem_json_name} > current-map.pddl`
    proc = subprocess.run(['python3', 'make-pddl.py', 'maze-template.pddl', 'problems/'+problem_json_name], stdout=subprocess.PIPE)
    with open('current-map.pddl', 'w') as f:
        f.write(proc.stdout.decode('utf-8'))
    
    try:
        os.remove('ff_plan')
    except FileNotFoundError:
        pass

    try:
        os.remove('sas_plan')
    except FileNotFoundError:
        pass


    print('Current problem: ', problem_json_name)
    print('Written to `current-map.pddl`')
    print('Domain file: `domain.pddl`')
    print()
    print('Please place plan for this in `sas_plan` or `ff_plan`')
    input('Press enter to continue...')
    print()

    # Move plan to plans/{problem_json_name}.plan
    if os.path.exists('sas_plan'):
        os.rename('sas_plan', os.path.join('plans', problem_json_name + '.plan'))
    elif os.path.exists('ff_plan'):
        # run `python3 ff_plan_converter.py ff_plan` then copy `sas_plan`
        proc = subprocess.run(['python3', 'ff_plan_converter.py', 'ff_plan'])
        os.rename('sas_plan', os.path.join('plans', problem_json_name + '.plan'))
    else:
        print('No plan found! Please try again')
        make_single_plan(problem_json_name)

def all_plans():
    for problem in os.listdir('problems'):
        if problem + '.plan' not in os.listdir('plans'):
            make_single_plan(problem)

if __name__ == '__main__':
    all_plans()