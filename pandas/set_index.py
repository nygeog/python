In : col = ['a','b','c']

In : data = DataFrame([[1,2,3],[10,11,12],[20,21,22]],columns=col)

In : data
Out:
    a   b   c
0   1   2   3
1  10  11  12
2  20  21  22

In : data2 = data.set_index('a')

In : data2
Out:
     b   c
a
1    2   3
10  11  12
20  21  22