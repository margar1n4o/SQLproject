set schema FN7MI0700043;

-- Procedure 1: Handle exception if a character is not found
CREATE PROCEDURE InsertCharacter(
    IN actor_name_param VARCHAR(255),
    IN character_name_param VARCHAR(255),
    IN role_param VARCHAR(255)
)
BEGIN
    DECLARE character_id_param INT;

    SELECT character_id INTO character_id_param
    FROM Character
    WHERE character_name = character_name_param;

    IF character_id_param IS NULL THEN
        INSERT INTO Character (actor_name, character_name, role)
        VALUES (actor_name_param, character_name_param, role_param);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Character already exists';
    END IF;
END;

-- Procedure 2: Handle exception if a TVSeries is not found
CREATE PROCEDURE InsertOrUpdateTVSeries(
    IN name_param VARCHAR(255),
    IN structure_param VARCHAR(255),
    IN start_date_param DATE,
    IN end_date_param DATE,
    IN num_seasons_param INT,
    IN broadcast_method_param VARCHAR(255),
    IN creator_param VARCHAR(255),
    IN production_name_param VARCHAR(255)
)
BEGIN
    DECLARE series_exists INT;
    SELECT COUNT(*) INTO series_exists
    FROM TVSeries
    WHERE name = name_param;
    IF series_exists = 0 THEN
        INSERT INTO TVSeries (name, structure, start_date, end_date, num_seasons, broadcast_method, creator, production_name)
        VALUES (name_param, structure_param, start_date_param, end_date_param, num_seasons_param, broadcast_method_param, creator_param, production_name_param);
    ELSE
        UPDATE TVSeries
        SET
            structure = structure_param,
            start_date = start_date_param,
            end_date = end_date_param,
            num_seasons = num_seasons_param,
            broadcast_method = broadcast_method_param,
            creator = creator_param,
            production_name = production_name_param
        WHERE name = name_param;
    END IF;
END;

-- Procedure 3

CREATE PROCEDURE CalculateTotalDuration(IN series_name VARCHAR(255), IN season_number INT, OUT total_duration INT)
BEGIN
    DECLARE at_end INT DEFAULT 0;
    DECLARE episode_duration INT;

    DECLARE episode_cursor CURSOR FOR
        SELECT duration
        FROM Episode
        WHERE series_name = series_name AND season_number = season_number;

    OPEN episode_cursor;

    SET total_duration = 0;

    FETCH episode_cursor INTO episode_duration;

    WHILE(at_end = 0) DO
        SET total_duration = total_duration + episode_duration;
        FETCH episode_cursor INTO episode_duration;
    END WHILE;

    CLOSE episode_cursor;
END;
