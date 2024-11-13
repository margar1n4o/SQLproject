set schema FN7MI0700043;

-- Trigger 1
CREATE TRIGGER After_Episode_Insert
AFTER INSERT ON Episode
REFERENCING NEW AS N
FOR EACH ROW
BEGIN
    UPDATE Season
    SET end_date = (
        SELECT MAX(air_date)
        FROM Episode
        WHERE season_number = Season.season_number
          AND series_name = Season.series_name
    )
    WHERE season_number = N.season_number
      AND series_name = N.series_name;
END;


INSERT INTO Season (series_name, season_number,NUM_EPISODES, start_date, end_date)
VALUES ('Dark', 14,12, '2024-01-01', '2024-01-15');

INSERT INTO Episode (series_name, season_number, episode_number, air_date, DURATION)
VALUES ('Dark', 14 , 12, '2024-01-10', 56);

-- Verification query
SELECT end_date
FROM Season
WHERE series_name = 'Dark' AND season_number = 14;