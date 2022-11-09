#NOTE: run it inside the build directory
import os

times = {}

print('parsing time:')

# for each analysis output file
for filepath in os.listdir("./"):
	if filepath.endswith(".txt"):
		project_name = filepath[0:-4]
		file = open(filepath)
		# skip lines
		file.readline()
		file.readline()
		file.readline()
		# read parse and codegen times (seconds)
		parse_line = file.readline()
		for s in parse_line.split():
			try:
				parse_time = float(s)
			except:
				pass
		codegen_line = file.readline()
		for s in codegen_line.split():
			try:
				codegen_time = float(s)
			except:
				pass
		times[project_name] = [parse_time, codegen_time]
		parse_fraction = parse_time / (parse_time + codegen_time)
		print(project_name + ': ' + '%.1f' % (parse_fraction * 100) + '%')

min_fraction = 101
max_fraction = -1
# average over all projects
total_parse_fraction = 0
for t in times.values():
	fraction = t[0] / (t[0] + t[1])
	total_parse_fraction += fraction
	if fraction < min_fraction:
		min_fraction = fraction
	if fraction > max_fraction:
		max_fraction = fraction
average_fraction = total_parse_fraction / len(times)
print('\nparsing time average: ' + '%.1f' % (average_fraction * 100) + '%')
print('minimum parsing time: ' + '%.1f' % (min_fraction * 100) + '%')
print('maximum parsing time: ' + '%.1f' % (max_fraction * 100) + '%')