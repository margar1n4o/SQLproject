set schema FN7MI0700043;

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
