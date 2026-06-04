\i '/ruta/al/proyecto/ddl.sql'

\copy Player FROM '/ruta/al/proyecto/TablePlayer.csv' CSV HEADER

\copy Episode FROM '/ruta/al/proyecto/TableEpisode.csv' CSV HEADER

\copy Game FROM '/ruta/al/proyecto/TableGame.csv' CSV HEADER

\copy GameParticipant FROM '/ruta/al/proyecto/TableGameParticipant.csv' CSV HEADER

\copy Sector FROM '/ruta/al/proyecto/TableSector.csv' CSV HEADER

\copy TelemetryEvent FROM '/ruta/al/proyecto/TableTelemetryevent.csv' CSV HEADER

\copy UXInstrument FROM '/ruta/al/proyecto/TableUxinstrument.csv' CSV HEADER

\copy UXResponse FROM '/ruta/al/proyecto/TableUxresponse.csv' CSV HEADER

\i '/ruta/al/proyecto/indices.sql'

\i '/ruta/al/proyecto/vistas.sql'

\i '/ruta/al/proyecto/materialized_view.sql'
