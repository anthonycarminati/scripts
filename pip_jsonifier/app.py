import pandas as pd
import os, json

dir = os.path.dirname(__file__)
filefolder = os.path.join(dir, './inputs/')

req_files = list()

for subdir, dirs, files in os.walk(filefolder):
	if files:
		for i in files:
			req_files.append(i)

file = os.path.join(filefolder, req_files[0])

data = pd.read_csv(file, header=None)
pkgs = data.values

output = dict()
output['pip_python_packages'] = {}
output['pip_python_packages_unversioned'] = {}

for i in pkgs:
	p_name = i[0].split('==')[0]
	p_version = i[0].split('==')[1]
	if p_name in ['configparser']:
		# Move to unversioned
		output['pip_python_packages_unversioned'][p_name] = p_version
	output['pip_python_packages'][p_name] = p_version

filefolder = os.path.join(dir, './outputs/requirements.json')

with open(filefolder, 'w') as outfile:
	json.dump(output, outfile)