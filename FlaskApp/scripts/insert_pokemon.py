import sqlite3
import csv

def db_connection():
    conn = sqlite3.connect('instance/pokedex.sqlite')
    return conn

def insert_pokemon_from_csv(csv_file_path):
    conn = db_connection()
    cursor = conn.cursor()

    with open(csv_file_path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            PokeID, PokeNum, RegionID, Pname, Image = row
            cursor.execute(
                "INSERT INTO Pokemon (PokeID, PokeNum, RegionID, Pname, Image) VALUES (?, ?, ?, ?, ?)",
                (PokeID, PokeNum, RegionID, Pname, Image)
            )

    conn.commit()
    conn.close()

if __name__ == '__main__':
    insert_pokemon_from_csv('csvdata/kanto_pokemon.csv')
