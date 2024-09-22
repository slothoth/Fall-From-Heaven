with open('../Core/short_loc.sql', encoding='cp1252',  errors='replace') as file:
    lines = file.readlines()

short_lines = [i for i in lines if len(i) <= 200]
medium_lines = [i for i in lines if 600>= len(i) > 200]
long_lines = [i for i in lines if len(i) > 600]

long = "".join(long_lines)
medium = "".join(medium_lines)
short = "".join(short_lines)

print(long)
