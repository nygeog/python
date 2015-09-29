import pandas.io.sql as psql

import psycopg2
import psycopg2.extensions
import logging

class LoggingCursor(psycopg2.extensions.cursor):
    def execute(self, sql, args=None):
        logger = logging.getLogger('sql_debug')
        logger.info(self.mogrify(sql, args))

        try:
            psycopg2.extensions.cursor.execute(self, sql, args)
        except Exception, exc:
            logger.error("%s: %s" % (exc.__class__.__name__, exc))
            raise

conn = psycopg2.connect("dbname='nyc' user='nygeog' host='mypostgisdb.cwfqm08bs17b.us-west-2.rds.amazonaws.com' password='2s4f0l9k!'")

cur = conn.cursor(cursor_factory=LoggingCursor)
# #cur.execute("INSERT INTO mytable VALUES (%s, %s, %s);",
#              (10, 20, 30))
#print df.head(100)

cur.execute("CREATE TABLE testone(col1 int);")