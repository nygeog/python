infile = r"D:\gis\projects\chicago\dhl\data\Detail.txt"
outfile = r"D:\gis\projects\chicago\dhl\data\Detail_tab.txt"

input = open(infile, "r")
output = open(outfile, "wb")

for row in input:
    # hexadecimal number FE = decimal 254
    # hexadecimal number 14 = decimal 20 (Device Control 4)
    # replace hex FE (used as the field boundaries) with a double quote
    # replace hex 14 (used as the field delimiter) with a tab
    outRow = row.replace("\xfe", "\"").replace("\x14", "\t")
    output.write(outRow)

output.close()
