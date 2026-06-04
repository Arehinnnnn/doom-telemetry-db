CREATE TABLE "Player" (
  "player_id" SERIAL PRIMARY KEY,
  "nickname" varchar(50) UNIQUE NOT NULL,
  "age" int,
  "gender" varchar(15),
  "experience_level" varchar(30)
);

CREATE TABLE "Episode" (
  "episode_id" SERIAL PRIMARY KEY,
  "episode_number" int UNIQUE NOT NULL,
  "title" varchar(50)
);

CREATE TABLE "Game" (
  "game_id" SERIAL PRIMARY KEY,
  "episode_id" int NOT NULL,
  "map_number" int NOT NULL,
  "started_at" timestamp,
  "ended_at" timestamp
);

CREATE TABLE "GameParticipant" (
  "game_id" int NOT NULL,
  "player_id" int NOT NULL,
  PRIMARY KEY ("game_id", "player_id")
);

CREATE TABLE "Sector" (
  "sector_id" SERIAL PRIMARY KEY,
  "episode_id" int NOT NULL,
  "map_number" int NOT NULL,
  "sector_x" int NOT NULL,
  "sector_y" int NOT NULL
);

CREATE TABLE "TelemetryEvent" (
  "event_id" SERIAL PRIMARY KEY,
  "event_timestamp" timestamp NOT NULL,
  "tic" int NOT NULL,
  "pos_x" int NOT NULL,
  "pos_y" int NOT NULL,
  "pos_z" int NOT NULL,
  "angle" float,
  "momx" float,
  "momy" float,
  "shield" int,
  "health" int,
  "ammo" int,
  "sector_id" int NOT NULL,
  "player_id" int NOT NULL,
  "game_id" int NOT NULL
);

CREATE TABLE "UXInstrument" (
  "instrument_id" SERIAL PRIMARY KEY,
  "instrument_name" varchar(30) NOT NULL
);

CREATE TABLE "UXResponse" (
  "response_id" SERIAL PRIMARY KEY,
  "player_id" int NOT NULL,
  "instrument_id" int NOT NULL,
  "game_id" int,
  "score" float,
  "responded_at" timestamp DEFAULT (CURRENT_TIMESTAMP)
);

CREATE UNIQUE INDEX ON "Sector" ("episode_id", "map_number", "sector_x", "sector_y");

COMMENT ON COLUMN "Player"."age" IS 'CHECK (age > 0)';

COMMENT ON COLUMN "TelemetryEvent"."tic" IS 'CHECK (tic >= 0)';

COMMENT ON COLUMN "TelemetryEvent"."angle" IS 'CHECK (angle >= 0 AND angle <= 360)';

COMMENT ON COLUMN "TelemetryEvent"."shield" IS 'CHECK (shield >= 0)';

COMMENT ON COLUMN "TelemetryEvent"."health" IS 'CHECK (health >= 0)';

COMMENT ON COLUMN "TelemetryEvent"."ammo" IS 'CHECK (ammo >= 0)';

ALTER TABLE "Game" ADD FOREIGN KEY ("episode_id") REFERENCES "Episode" ("episode_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "GameParticipant" ADD FOREIGN KEY ("game_id") REFERENCES "Game" ("game_id") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "GameParticipant" ADD FOREIGN KEY ("player_id") REFERENCES "Player" ("player_id") ON DELETE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "Sector" ADD FOREIGN KEY ("episode_id") REFERENCES "Episode" ("episode_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "TelemetryEvent" ADD FOREIGN KEY ("sector_id") REFERENCES "Sector" ("sector_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "TelemetryEvent" ADD FOREIGN KEY ("player_id") REFERENCES "Player" ("player_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "TelemetryEvent" ADD FOREIGN KEY ("game_id") REFERENCES "Game" ("game_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "UXResponse" ADD FOREIGN KEY ("player_id") REFERENCES "Player" ("player_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "UXResponse" ADD FOREIGN KEY ("instrument_id") REFERENCES "UXInstrument" ("instrument_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "UXResponse" ADD FOREIGN KEY ("game_id") REFERENCES "Game" ("game_id") DEFERRABLE INITIALLY IMMEDIATE;
