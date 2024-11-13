set schema FN7MI0700043;

-- View 1: List all characters and their roles
CREATE VIEW CharacterRoles AS
SELECT character_name, role
FROM Character;

SELECT * FROM CharacterRoles;

-- View 2: List episodes with their directors and writers
CREATE VIEW EpisodeDetails AS
SELECT series_name, season_number, episode_number, director, writer
FROM Episode;

SELECT * FROM EpisodeDetails;