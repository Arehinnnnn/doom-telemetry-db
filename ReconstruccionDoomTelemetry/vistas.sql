CREATE VIEW v_actividad_jugador AS
SELECT
    p.player_id,
    p.nickname,
    p.experience_level,
    COUNT(DISTINCT gp.game_id) AS total_partidas,
    ROUND(AVG(ux.score)::numeric, 2) AS score_ux_promedio
FROM Player p
JOIN GameParticipant gp ON p.player_id = gp.player_id
LEFT JOIN UXResponse ux ON p.player_id = ux.player_id
GROUP BY p.player_id, p.nickname, p.experience_level;

CREATE VIEW v_sector_activity AS
SELECT
    s.sector_id,
    e.title AS episodio,
    s.map_number,
    s.sector_x,
    s.sector_y,
    COUNT(t.event_id) AS total_eventos,
    ROUND(AVG(t.health)::numeric,2) AS salud_promedio,
    ROUND(AVG(t.shield)::numeric,2) AS escudo_promedio
FROM TelemetryEvent t
JOIN Sector s
    ON t.sector_id = s.sector_id
JOIN Episode e
    ON s.episode_id = e.episode_id
GROUP BY
    s.sector_id,
    e.title,
    s.map_number,
    s.sector_x,
    s.sector_y;