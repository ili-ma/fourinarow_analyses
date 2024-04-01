import os

def remove_first_moves(in_filename, out_filename):
	print(f"generating {out_filename}", end=':\t ')
	total = 0
	removed = 0
	with open(in_filename, "r") as in_file, open(out_filename, "w") as out_file:
		for line in in_file:
			total += 1
			cells = line.split('\t')
			if len(cells) > 2 and (cells[0] == "0" or cells[1] == "0"):
				removed += 1
			else:
				out_file.write(line)
	print(f"Read {total}, Removed {removed}")

input_root = "splits"
output_root = "splits_no_first_move"
for root, dirs, files in os.walk(input_root):
	for file in files:
		if file.endswith(".csv"):
			in_filename = os.path.join(root, file)
			relative_path = os.path.relpath(in_filename, start=input_root)
			out_file = os.path.join(output_root, relative_path)
			os.makedirs(os.path.dirname(out_file), exist_ok=True)
			remove_first_moves(in_filename, out_file)
