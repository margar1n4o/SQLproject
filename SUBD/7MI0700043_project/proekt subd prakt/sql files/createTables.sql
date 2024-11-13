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