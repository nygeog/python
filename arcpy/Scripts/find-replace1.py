import os, fnmatch, time, datetime, csv
def findReplace(directory, find, replace, filePattern):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(find, replace)
            with open(filepath, "w") as f:
                f.write(s)
#loop example
#findlist = ["hul","hhu","n_h","hnh","net","hnt","r_h","hrh","rad","hrl"]
#repllist = ["hh1","hh1","hk1","hk1","hn1","hn1","hp1","hp1","hr1","hr1"]

#for find, repl in zip(findlist, repllist):

	#findReplace("D:\\...\\", find, repl, "*.py")

findReplace("D:\\...\\", "findtext1", "replacetext1", "*.py")
findReplace("D:\\...\\", "findtext2", "replacetext2", "*.py")

print 'Script ended at this time: ' + time.strftime('%c') 
raw_input("Congrats! Processing has been completed effectively. Press any key to exit") 