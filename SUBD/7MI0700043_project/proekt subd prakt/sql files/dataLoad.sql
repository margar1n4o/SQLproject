set schema FN7MI0700043;

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

INSERT INTO Episode (episode_number, season_number, series_name, director, writer, duration, air_date)
VALUES
    (2, 1, 'Dark', 'Baran bo Odar', 'Jantje Friese', 55, '2017-12-08'),
    (3, 1, 'Dark', 'Baran bo Odar', 'Jantje Friese', 58, '2017-12-15'),
    (4, 1, 'Dark', 'Baran bo Odar', 'Jantje Friese', 60, '2017-12-22');

INSERT INTO Character (character_id, actor_name, character_name, role)
VALUES
(1, 'Louis Hofmann', 'Jonas Kahnwald', 'Protagonist'),
(2, 'Will Arnett', 'BoJack Horseman', 'Protagonist'),
(3, 'Matthew Fox', 'Jack Shephard', 'Protagonist'),
(4, 'Bryce Dallas Howard', 'Lacie Pound', 'Protagonist'),
(5, 'Kit Harington', 'Jon Snow', 'Protagonist'),
(6, 'Steve Carell', 'Michael Scott', 'Protagonist'),
(7, 'Joel McHale', 'Jeff Winger', 'Protagonist');

