set schema FN7MI0700043;

CREATE TABLE TVSeries (
    name VARCHAR(255) not null PRIMARY KEY,
    structure VARCHAR(255),
    start_date DATE NOT NULL,
    end_date DATE,
    num_seasons INT NOT NULL CHECK (num_seasons >= 0),
    broadcast_method VARCHAR(255),
    creator VARCHAR(255),
    production_name VARCHAR(255)
);



CREATE TABLE Season (
    season_number INT NOT NULL CHECK (season_number > 0),
    series_name VARCHAR(255) not null,
    num_episodes INT NOT NULL CHECK (num_episodes >= 0),
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (season_number, series_name),
    FOREIGN KEY (series_name) REFERENCES TVSeries (name)
);

CREATE TABLE Episode (
    episode_number INT NOT NULL CHECK (episode_number > 0),
    season_number INT NOT NULL,
    series_name VARCHAR(255) NOT NULL,
    director VARCHAR(255),
    writer VARCHAR(255),
    duration INT NOT NULL CHECK (duration >= 0),
    air_date DATE,
    PRIMARY KEY (episode_number, season_number, series_name),
    FOREIGN KEY (season_number, series_name) REFERENCES Season (season_number, series_name)
);

CREATE TABLE Character (
    character_id  INT not  null PRIMARY KEY,
    actor_name VARCHAR(255),
    character_name VARCHAR(255),
    role VARCHAR(255)
);

INSERT INTO TVSeries (name, structure, start_date, end_date, num_seasons, broadcast_method, creator, production_name)
VALUES
('Dark', 'Serialized', '2017-12-01', '2020-06-27', 3, 'Online Streaming', 'Baran bo Odar, Jantje Friese', 'Wiedemann & Berg Television'),
('Bojack Horseman', 'Serialized', '2014-08-22', '2020-01-31', 6, 'Online Streaming', 'Raphael Bob-Waksberg', 'Tornante Company'),
('Lost', 'Serialized', '2004-09-22', '2010-05-23', 6, 'Broadcast TV', 'J. J. Abrams, Damon Lindelof', 'Bad Robot Productions'),
('Black Mirror', 'Anthology', '2011-12-04', '2019-06-05', 5, 'Online Streaming', 'Charlie Brooker', 'Zeppotron'),
('Game of Thrones', 'Serialized', '2011-04-17', '2019-05-19', 8, 'Broadcast TV', 'David Benioff, D. B. Weiss', 'HBO'),
('The Office', 'Serialized', '2005-03-24', '2013-05-16', 9, 'Broadcast TV', 'Greg Daniels', 'Reveille Productions, Deedle-Dee Productions, Universal Television'),
('Community', 'Serialized', '2009-09-17', '2014-04-17', 5, 'Broadcast TV', 'Dan Harmon', 'Krasnoff Foster Productions, Harmonious Claptrap, Russo Brothers Studio, Universal Media Studios');

INSERT INTO Season (season_number, series_name, num_episodes, start_date, end_date)
VALUES
(1, 'Dark', 10, '2017-12-01', '2017-12-31'),
(1, 'Bojack Horseman', 12, '2014-08-22', '2014-12-12'),
(1, 'Lost', 25, '2004-09-22', '2005-05-25'),
(1, 'Black Mirror', 3, '2011-12-04', '2011-12-18'),
(1, 'Game of Thrones', 10, '2011-04-17', '2011-06-19'),
(1, 'The Office', 6, '2005-03-24', '2005-04-28'),
(1, 'Community', 25, '2009-09-17', '2010-05-20');

INSERT INTO Episode (episode_number, season_number, series_name, director, writer, duration, air_date)
VALUES
    (1, 1, 'Dark', 'Baran bo Odar', 'Jantje Friese', 60, '2017-12-01'),
    (12, 1, 'Bojack Horseman', 'Mike Hollingsworth', 'Kate Purdy', 25, '2020-01-31'),
    (4, 1, 'Lost', 'J.J. Abrams', 'J.J. Abrams & Damon Lindelof', 43, '2004-10-13'),
    (1, 1, 'Black Mirror', 'Otto Bathurst', 'Charlie Brooker', 62, '2011-12-04'),
    (1, 1, 'Game of Thrones', 'Tim Van Patten', 'David Benioff & D. B. Weiss', 62, '2011-04-17'),
    (1, 1, 'The Office', 'Ken Kwapis', 'Ricky Gervais & Stephen Merchant', 22, '2005-03-24'),
    (1, 1, 'Community', 'Joe Russo', 'Dan Harmon', 25, '2009-09-17');

INSERT INTO Character (character_id, actor_name, character_name, role)
VALUES
(1, 'Louis Hofmann', 'Jonas Kahnwald', 'Protagonist'),
(2, 'Will Arnett', 'BoJack Horseman', 'Protagonist'),
(3, 'Matthew Fox', 'Jack Shephard', 'Protagonist'),
(4, 'Bryce Dallas Howard', 'Lacie Pound', 'Protagonist'),
(5, 'Kit Harington', 'Jon Snow', 'Protagonist'),
(6, 'Steve Carell', 'Michael Scott', 'Protagonist'),
(7, 'Joel McHale', 'Jeff Winger', 'Protagonist');

-- Function 1: Get the total number of episodes for a series
CREATE FUNCTION GetTotalEpisodes(series_name VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE total_episodes INT;
    SELECT SUM(num_episodes) INTO total_episodes
    FROM Season
    WHERE series_name = series_name;
    RETURN total_episodes;
END;

-- Function 2: Get the average duration of episodes for a series
CREATE FUNCTION GetAverageDuration(series_name VARCHAR(255)) RETURNS DECIMAL(5,2)
BEGIN
    DECLARE avg_duration DECIMAL(5,2);
    SELECT AVG(duration) INTO avg_duration
    FROM Episode
    WHERE series_name = series_name;
    RETURN avg_duration;
END;

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

-- Procedure 1: Update character participation for a new episode
CREATE PROCEDURE UpdateCharacterParticipation(
    IN series_name_param VARCHAR(255),
    IN season_number_param INT,
    IN episode_number_param INT
)
BEGIN
    INSERT INTO Participation (character_id, episode_number, season_number, series_name)
    SELECT character_id, episode_number_param, season_number_param, series_name_param
    FROM Character;
END;

-- Procedure 2: Handle exception if a character is not found
CREATE PROCEDURE InsertCharacter(
    IN actor_name_param VARCHAR(255),
    IN character_name_param VARCHAR(255),
    IN role_param VARCHAR(255)
)
BEGIN
    DECLARE character_id_param INT;

    -- Check if the character already exists
    SELECT character_id INTO character_id_param
    FROM Character
    WHERE character_name = character_name_param;

    -- If character doesn't exist, insert it
    IF character_id_param IS NULL THEN
        INSERT INTO Character (actor_name, character_name, role)
        VALUES (actor_name_param, character_name_param, role_param);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Character already exists';
    END IF;
END;
