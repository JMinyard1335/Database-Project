import sqlite3
import csv

def db_connection():
    conn = sqlite3.connect('instance/pokedex.sqlite')
    return conn

def insert_trainers_from_csv(csv_file_path):
    """
    Inserts data into the Trainer table from a CSV file.
    Assumes CSV columns follow the Trainer table schema:
    TrainerID, TrainerName, GymID, TrainerClass
    """
    conn = db_connection()
    cursor = conn.cursor()

    with open(csv_file_path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            TrainerID, TrainerName, GymID, TrainerClass = row
            cursor.execute(
                "INSERT OR IGNORE INTO Trainer (TrainerID, TrainerName, GymID, TrainerClass) VALUES (?, ?, ?, ?)",
                (TrainerID, TrainerName, GymID, TrainerClass)
            )

    conn.commit()
    conn.close()

def insert_trainedby_from_csv(csv_file_path):
    """
    Inserts data into the TrainBy table from a CSV file.
    Assumes CSV columns follow the TrainBy table schema:
    TrainerID, PokeID
    """
    conn = db_connection()
    cursor = conn.cursor()

    with open(csv_file_path, newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            TrainerID, PokeID = row
            cursor.execute(
                "INSERT OR IGNORE INTO TrainBy (TrainerID, PokeID) VALUES (?, ?)",
                (TrainerID, PokeID)
            )

    conn.commit()
    conn.close()

if __name__ == '__main__':
    # Load trainers into the Trainer table
    insert_trainers_from_csv('csvdata/gymleader.csv')
    # Load trained Pokémon into the TrainBy table
    insert_trainedby_from_csv('csvdata/trainedby.csv')
