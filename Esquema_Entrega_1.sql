CREATE TABLE Player (
    player_id SERIAL PRIMARY KEY,
    nickname VARCHAR(50) UNIQUE NOT NULL,
    age INT,
    gender VARCHAR(15),
    experience_level VARCHAR(30)
);

CREATE TABLE Episode (
    episode_id SERIAL PRIMARY KEY,
    episode_number INT NOT NULL,
    title VARCHAR(50)
);

CREATE TABLE Game (
    game_id SERIAL PRIMARY KEY,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    episode_id INT NOT NULL,
    map_code VARCHAR(10) UNIQUE NOT NULL,

    CONSTRAINT fk_game_episode
        FOREIGN KEY (episode_id)
        REFERENCES Episode(episode_id)
);

CREATE TABLE GameParticipant (
    game_id INT NOT NULL,
    player_id INT NOT NULL,

    PRIMARY KEY (game_id, player_id),

    CONSTRAINT fk_gp_game
        FOREIGN KEY (game_id)
        REFERENCES Game(game_id),

    CONSTRAINT fk_gp_player
        FOREIGN KEY (player_id)
        REFERENCES Player(player_id)
);

CREATE TABLE Sector (
    sector_id SERIAL PRIMARY KEY,
    sector_name VARCHAR(50),
    map_code VARCHAR(10) NOT NULL,

    CONSTRAINT fk_sector_map
        FOREIGN KEY (map_code)
        REFERENCES Game(map_code)
);

CREATE TABLE TelemetryEvent (
    event_id SERIAL PRIMARY KEY,

    tic INT NOT NULL,

    posi_x FLOAT,
    posi_y FLOAT,
    posi_z FLOAT,

    health INT,
    armor INT,
    ammo INT,

    sector_id INT NOT NULL,
    player_id INT NOT NULL,
    game_id INT NOT NULL,

    CONSTRAINT fk_te_sector
        FOREIGN KEY (sector_id)
        REFERENCES Sector(sector_id),

    CONSTRAINT fk_te_player
        FOREIGN KEY (player_id)
        REFERENCES Player(player_id),

    CONSTRAINT fk_te_game
        FOREIGN KEY (game_id)
        REFERENCES Game(game_id)
);

CREATE TABLE UXInstrument (
    instrument_id SERIAL PRIMARY KEY,
    instrument_name VARCHAR(30) NOT NULL
);

CREATE TABLE UXResponse (
    response_id SERIAL PRIMARY KEY,

    player_id INT NOT NULL,
    instrument_id INT NOT NULL,

    score FLOAT,
    responded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ux_player
        FOREIGN KEY (player_id)
        REFERENCES Player(player_id),

    CONSTRAINT fk_ux_instrument
        FOREIGN KEY (instrument_id)
        REFERENCES UXInstrument(instrument_id)
);
