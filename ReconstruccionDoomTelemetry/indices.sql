CREATE INDEX idx_telemetry_game_player ON TelemetryEvent (game_id, player_id);

CREATE INDEX idx_telemetry_timestamp ON TelemetryEvent (event_timestamp);

CREATE INDEX idx_sector_lookup ON Sector (episode_id, map_number);