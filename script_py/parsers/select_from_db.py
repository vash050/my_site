import sqlite3


conn = sqlite3.connect("name_birds_from_kadastr.sqlite3")
cursor = conn.cursor()
sql = "SELECT * FROM birds"
cursor.execute(sql)
print(cursor.fetchall()) # or use fetchone()