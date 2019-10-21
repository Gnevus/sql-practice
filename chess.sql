//таблички
CREATE TABLE tournaments (
    tournament_id           int,
    tournaments_name        text,
    datetime                  date,
);
CREATE TABLE users (
    user_id                 int,
    user_name        text,
);
CREATE TABLE tournament_participant (
    user_id                int,
    tournament_id          int,
    victory                int //1 or 0
);


//сам запрос
SELECT users.user_name AS `Имя участника`, 
     		(SELECT SUM(victory)
     		FROM tour)
AS `Количество побед`,
     		(SELECT COUNT(tournament_id)
     		FROM tour)
AS `Количество посещеных турниров`
FROM tournament_participant as tour
JOIN users ON tour.user_id = users.user_id
WHERE tour.tournament_id IN
 (SELECT tournament_id
  FROM tournaments
  WHERE YEAR(`tournaments.datetime`) = YEAR(NOW()))
AND tour.user_id IN 
(SELECT user_id
  FROM tournament_participant
  WHERE SUM(victory) =  2 
  GROUP BY user_id)
