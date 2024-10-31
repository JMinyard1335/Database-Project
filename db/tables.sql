CREATE TABLE
    Pokemon (
        PokeID INT,
        PokeNum INT,
        Descr VARCHAR(100),
        RegionID INT,
        Primary Key (PokeID),
        Foreign Key (RegionID) References Region
    );

CREATE TABLE
    Typ (
        TypeID INT,
        TypeName VARCHAR(100),
        Primary Key (TypeID)
    );

CREATE TABLE
    PokemonType (
        PokeID INT,
        TypeID INT NOT NULL,
        Foreign Key (PokeID) References Pokemon,
        Foreign Key (TypeID) References Typ
    );

CREATE TABLE
    Region (
        RegionID INT,
        RegionName VARCHAR(100),
        Primary Key (RegionID)
    );

CREATE TABLE
    Gyms (
        GymID INT,
        RegionID INT NOT NULL,
        GymName VARCHAR(100),
        Lvl INT Primary Key (GymID),
        Foreign Key (RegionID) References Region
    );

CREATE TABLE
    Trainer (
        TrainerID INT,
        TrainerName VARCHAR(100),
        GymID INT NOT NULL,
        TrainerClass VARCHAR(100) Primary Key (TrainerID),
        Foreign Key (GymID) References Gyms
    );

CREATE TABLE
    TrainBy (
        TrainerID INT NOT NULL,
        PokeID INT NOT NULL,
        Foreign Key (TrainerID) References Trainer,
        Foreign Key (PokeID) References Pokemon
    );