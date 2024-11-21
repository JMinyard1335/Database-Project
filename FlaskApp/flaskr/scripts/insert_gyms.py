import sqlite3
import csv

def db_connection():
    conn = sqlite3.connect('instance/pokedex.sqlite')
    return conn

def insert_gyms_from_csv(csv_file_path):
    conn = db_connection()
    cursor = conn.cursor()

    with open(csv_file_path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            GymID, RegionID, GymName, Lvl  = row
            cursor.execute(
                "INSERT or Ignore INTO Gyms (GymID, RegionID, GymName, Lvl) VALUES (?, ?, ?, ?)",
                (GymID, RegionID, GymName, Lvl)
            )

    conn.commit()
    conn.close()

if __name__ == '__main__':
    insert_gyms_from_csv('csvdata/gyms.csv')
