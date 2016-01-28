#http://stackoverflow.com/questions/3368969/find-string-between-two-substrings

s = "123123STRINGabcabc"

def find_between( s, first, last ):
    try:
        start = s.index( first ) + len( first )
        end = s.index( last, start )
        return s[start:end]
    except ValueError:
        return ""

def find_between_r( s, first, last ):
    try:
        start = s.rindex( first ) + len( first )
        end = s.rindex( last, start )
        return s[start:end]
    except ValueError:
        return ""


print find_between( s, "123", "abc" )
print find_between_r( s, "123", "abc" )