def stripwhitespace(infile, outfile=None):
    inputTextFile = open(infile, "r")

    # read the file contents into a list (one input line per list item)
    inputText = inputTextFile.readlines()
    # drop the first 20 lines
    inputText = inputText[20:]

    # strip all spaces and tabs
    outputText = ["".join(line.split()) for line in inputText]

    # write the output
    if outfile: outputTextFile = open(outfile, "w")
    else: outputTextFile = open(infile.replace(".txt", "_nospace.txt"), "w")
    outputTextFile.writelines(["%s\n" % line for line in outputText])
    outputTextFile.close()

# As is, 4 ways to execute:

# Run from the command line specifying only the input file, e.g.,
# D:\work\stripwhitespace.py D:\data\textfiletoprocess.txt
# output will be D:\data\textfiletoprocess_nospace.txt

# Run from the command line specifying both the input and output file names, e.g.,
# D:\work\stripwhitespace.py D:\data\in\textfile1.txt D:\data\out\textfile2.txt

# Same as the previous two options (using one or two file specs), but instead of
# executing from the command line, put each entry directly in the "else" block
# below.

import sys
if len(sys.argv) == 2: stripwhitespace(sys.argv[1])
if len(sys.argv) == 3: stripwhitespace(sys.argv[1], sys.argv[2])
else:
    stripwhitespace(r"E:\temp\test.txt", r"E:\temp\test_nospace.txt")
