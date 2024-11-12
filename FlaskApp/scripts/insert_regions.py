import sqlite3
import csv

def db_connection():
    conn = sqlite3.connect('instance/pokedex.sqlite')
    return conn

def insert_region_from_csv(csv_file_path):
    conn = db_connection()
    cursor = conn.cursor()

    with open(csv_file_path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            RegionID, RegionName = row
            cursor.execute(
                "INSERT INTO Region (RegionID, RegionName) VALUES (?, ?)",
                (RegionID, RegionName)
            )

    conn.commit()
    conn.close()

if __name__ == '__main__':
    insert_region_from_csv('csvdata/regions.csv')
