DROP DATABASE IF EXISTS hw_prog_1;
CREATE DATABASE hw_prog_1;
USE hw_prog_1;

CREATE TABLE Venue (
    venue_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),          
    impact_factor INT
);

CREATE TABLE Publication (
    pub_id INT PRIMARY KEY,
    title VARCHAR(200),
    year INT,
    venue_id INT,
    author VARCHAR(100),
    citations INT,            
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
);

INSERT INTO Venue VALUES
(1, 'Nature', 'Journal', 43),
(2, 'IEEE CVPR', 'Conference', 9),
(3, 'Science', 'Journal', 42),
(4, 'NeurIPS', 'Conference', 14);

INSERT INTO Publication VALUES
(1, 'Deep Learning', 2018, 2, 'Alice Smith', 120),
(2, 'Quantum Computing', 2020, 1, 'Bob Johnson', 250),
(3, 'Brain Interfaces', 2019, 4, 'Alice Smith', 95),
(4, 'Climate Models', 2017, 3, 'Charlie Lee', 180),
(5, 'AI Healthcare', 2021, 2, 'Dana White', 60),
(6, 'Graph Networks', 2021, 4, 'Eve Miller', 110);


-- Task 2.1: Total citations per venue, ordered by venue_name in ascending order.

SELECT 
    Venue.name AS "venue_name",
    SUM(Publication.Citations) AS "total_citations"
FROM Publication
    LEFT JOIN Venue 
        ON Venue.venue_id = Publication.venue_id
GROUP BY Venue.venue_id
ORDER BY Venue.name ASC;


-- Task 2.2: Average citations per author, ordered by author in ascending order.

SELECT
    author,
    AVG(citations) AS "avg_citations"
FROM Publication
GROUP BY author
ORDER BY author ASC;


-- Task 2.3: Total citations for all conference publications

SELECT
    SUM(Publication.citations) as "conference_citations"
FROM Publication
    LEFT JOIN Venue 
        ON Venue.venue_id = Publication.venue_id
WHERE Venue.type = "Conference";

-- Task 2.4 Average citations per venue type (Journal vs Conference), ordered by venue type in ascending order.

SELECT
    Venue.type as 'type',
    AVG(Publication.citations) as "avg_citations"
FROM Publication
    LEFT JOIN Venue 
        ON Venue.venue_id = Publication.venue_id
GROUP BY Venue.type
ORDER BY Venue.type ASC;


-- Task 2.5 Authors with total citations above 150, ordered by author in ascending order.

SELECT
    Publication.author as "author",
    SUM(Publication.citations) as "total_citations"
FROM Publication
    LEFT JOIN Venue 
        ON Venue.venue_id = Publication.venue_id
GROUP BY Publication.author
HAVING SUM(Publication.citations) > 150;
