CREATE TABLE IF NOT EXISTS Pokemon
(
    PokeID INT,
    PokeNum INT,
    RegionID INT,
    Pname VARCHAR(100),
    Image VARCHAR(250),
    PRIMARY KEY (PokeID),
    FOREIGN KEY (RegionID) REFERENCES Region
);

CREATE TABLE IF NOT EXISTS Typ
(
    TypeID INT,
    TypeName VARCHAR(100),
    PRIMARY KEY (TypeID)
);

CREATE TABLE IF NOT EXISTS Region
(
    RegionID INT,
    RegionName VARCHAR(100),
    PRIMARY KEY (RegionID)
);

CREATE TABLE IF NOT EXISTS PokemonType 
(
    PokeID INT,
    TypeID INT NOT NULL,
    FOREIGN KEY (PokeID) REFERENCES Pokemon,
    FOREIGN KEY (TypeID) REFERENCES Typ
);

CREATE TABLE IF NOT EXISTS Gyms
(
    GymID INT,
    RegionID INT NOT NULL,
    GymName VARCHAR(100),
    Lvl INT,
    PRIMARY KEY (GymID),
    FOREIGN KEY (RegionID) REFERENCES Region
);

CREATE TABLE IF NOT EXISTS Trainer
(
    TrainerID INT,
    TrainerName VARCHAR(100),
    GymID INT NOT NULL,
    TrainerClass VARCHAR(100),
    PRIMARY KEY (TrainerID),
    FOREIGN KEY (GymID) REFERENCES Gyms
);

CREATE TABLE IF NOT EXISTS TrainBy
(
    TrainerID INT NOT NULL,
    PokeID INT NOT NULL,
    FOREIGN KEY (TrainerID) REFERENCES Trainer,
    FOREIGN KEY (PokeID) REFERENCES Pokemon
);
