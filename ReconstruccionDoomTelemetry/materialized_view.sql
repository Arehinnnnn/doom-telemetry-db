CREATE MATERIALIZED VIEW mv_hotspots AS
SELECT
    s.sector_id,
    e.title AS episodio,
    s.map_number,
    s.sector_x,
    s.sector_y,
    COUNT(t.event_id) AS total_eventos,
    ROUND(AVG(t.health)::numeric, 2) AS salud_promedio,
    ROUND(AVG(t.shield)::numeric, 2) AS escudo_promedio
FROM TelemetryEvent t
JOIN Sector s ON t.sector_id = s.sector_id
JOIN Episode e ON s.episode_id = e.episode_id
GROUP BY
    s.sector_id,
    e.title,
    s.map_number,
    s.sector_x,
    s.sector_y;