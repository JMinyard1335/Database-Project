CREATE TABLE if not exists
    Pokemon (
        PokeID INT,
        PokeNum INT,
	RegionID INT,
        Pname VARCHAR(100),
	Image VARCHAR(250),
        Primary Key (PokeID),
        Foreign Key (RegionID) References Region
    );

CREATE TABLE if not exists
    Typ (
        TypeID INT,
        TypeName VARCHAR(100),
        Primary Key (TypeID)
    );


CREATE TABLE if not exists
    Region (
        RegionID INT,
        RegionName VARCHAR(100),
        Primary Key (RegionID)
    );

CREATE TABLE if not exists
    PokemonType (
        PokeID INT,
        TypeID INT NOT NULL,
        Foreign Key (PokeID) References Pokemon,
        Foreign Key (TypeID) References Typ
    );

CREATE TABLE if not exists
    Gyms (
        GymID INT,
        RegionID INT NOT NULL,
        GymName VARCHAR(100),
        Lvl INT Primary Key (GymID),
        Foreign Key (RegionID) References Region
    );

CREATE TABLE if not exists
    Trainer (
        TrainerID INT,
        TrainerName VARCHAR(100),
        GymID INT NOT NULL,
        TrainerClass VARCHAR(100) Primary Key (TrainerID),
        Foreign Key (GymID) References Gyms
    );

CREATE TABLE if not exists
    TrainBy (
        TrainerID INT NOT NULL,
        PokeID INT NOT NULL,
        Foreign Key (TrainerID) References Trainer,
        Foreign Key (PokeID) References Pokemon
    );
