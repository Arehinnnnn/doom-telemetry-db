CREATE TABLE Player (
    player_id SERIAL PRIMARY KEY,
    nickname VARCHAR(50) UNIQUE NOT NULL,
    age INT CHECK (age > 0),
    gender VARCHAR(15),
    experience_level VARCHAR(30)
);

CREATE TABLE Episode (
    episode_id SERIAL PRIMARY KEY,
    episode_number INT UNIQUE NOT NULL,
    title VARCHAR(50)
);

CREATE TABLE Game (
    game_id SERIAL PRIMARY KEY,
    episode_id INT NOT NULL,
    map_number INT NOT NULL,
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    CONSTRAINT fk_game_episode FOREIGN KEY (episode_id) REFERENCES Episode(episode_id)
);

CREATE TABLE GameParticipant (
    game_id INT NOT NULL,
    player_id INT NOT NULL,
    PRIMARY KEY (game_id, player_id),
    CONSTRAINT fk_gp_game FOREIGN KEY (game_id) REFERENCES Game(game_id) ON DELETE CASCADE,
    CONSTRAINT fk_gp_player FOREIGN KEY (player_id) REFERENCES Player(player_id) ON DELETE CASCADE
);

CREATE TABLE Sector (
    sector_id SERIAL PRIMARY KEY,
    episode_id INT NOT NULL,
    map_number INT NOT NULL,
    sector_x INT NOT NULL,
    sector_y INT NOT NULL,
    UNIQUE (episode_id, map_number, sector_x, sector_y),
    CONSTRAINT fk_sector_episode FOREIGN KEY (episode_id) REFERENCES Episode(episode_id)
);

CREATE TABLE TelemetryEvent (
    event_id SERIAL PRIMARY KEY,
    event_timestamp TIMESTAMP NOT NULL,
    tic INT NOT NULL CHECK (tic >= 0),
    pos_x INT NOT NULL,
    pos_y INT NOT NULL,
    pos_z INT NOT NULL,
    angle FLOAT CHECK (angle >= 0 AND angle <= 360),
    momx FLOAT,
    momy FLOAT,
    shield INT CHECK (shield >= 0),
    health INT CHECK (health >= 0),
    ammo INT CHECK (ammo >= 0),
    sector_id INT NOT NULL,
    player_id INT NOT NULL,
    game_id INT NOT NULL,
    CONSTRAINT fk_te_sector FOREIGN KEY (sector_id) REFERENCES Sector(sector_id),
    CONSTRAINT fk_te_player FOREIGN KEY (player_id) REFERENCES Player(player_id),
    CONSTRAINT fk_te_game FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

CREATE TABLE UXInstrument (
    instrument_id SERIAL PRIMARY KEY,
    instrument_name VARCHAR(30) NOT NULL
);

CREATE TABLE UXResponse (
    response_id SERIAL PRIMARY KEY,
    player_id INT NOT NULL,
    instrument_id INT NOT NULL,
    game_id INT,
    score FLOAT,
    responded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ux_player FOREIGN KEY (player_id) REFERENCES Player(player_id),
    CONSTRAINT fk_ux_instrument FOREIGN KEY (instrument_id) REFERENCES UXInstrument(instrument_id),
    CONSTRAINT fk_ux_game FOREIGN KEY (game_id) REFERENCES Game(game_id)
);