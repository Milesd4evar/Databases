-- query one
CREATE TABLE MusicVideo (
    TrackId INTEGER NOT NULL,
    VideoDirector NVARCHAR(200) NOT NULL,
    PRIMARY KEY (TrackId),
    FOREIGN KEY (TrackId) REFERENCES tracks (TrackId)
);





-- query two
INSERT INTO MusicVideo (TrackId, VideoDirector) VALUES
    (10, 'al'),
    (20, 'bo'),
    (30, 'cy'),
    (40, 'dan'),
    (50, 'ed'),
    (60, 'fay'),
    (70, 'gus'),
    (80, 'hal'),
    (90, 'ira'),
    (100, 'joe');

-- query 3
INSERT INTO MusicVideo (TrackId, VideoDirector)
    SELECT TrackId, 'miles'
    FROM tracks
    WHERE Name = 'Voodoo';

-- query 4
SELECT TrackId, Name
FROM tracks
WHERE Name LIKE '%á%'
   OR Name LIKE '%é%'
   OR Name LIKE '%í%'
   OR Name LIKE '%ó%'
   OR Name LIKE '%ú%';

-- query 5
SELECT tracks.Name, tracks.Milliseconds
FROM tracks
JOIN genres ON tracks.GenreId = genres.GenreId
WHERE genres.Name = 'Jazz'
ORDER BY tracks.Milliseconds DESC
LIMIT 10;





-- query 6
SELECT artists.Name, COUNT(DISTINCT albums.AlbumId) AS AlbumCount
FROM artists
JOIN albums ON artists.ArtistId = albums.ArtistId
JOIN tracks ON albums.AlbumId = tracks.AlbumId
JOIN genres ON tracks.GenreId = genres.GenreId
WHERE genres.Name = 'Jazz'
GROUP BY artists.Name
ORDER BY AlbumCount DESC;





-- query 7 
SELECT DISTINCT
    customers.CustomerId,
    customers.FirstName,
    customers.LastName,
    customers.Email
FROM customers
JOIN invoices ON customers.CustomerId = invoices.CustomerId
JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
JOIN tracks ON invoice_items.TrackId = tracks.TrackId
WHERE tracks.Milliseconds > (
        SELECT AVG(Milliseconds)
        FROM tracks
        WHERE Milliseconds <= 900000
    )
    AND tracks.Milliseconds <= 900000
ORDER BY customers.LastName, customers.FirstName;

-- query 8 
SELECT
    tracks.TrackId,
    tracks.Name AS TrackName,
    genres.Name AS GenreName
FROM tracks
JOIN genres ON tracks.GenreId = genres.GenreId
WHERE tracks.GenreId NOT IN (
    SELECT GenreId
    FROM tracks
    GROUP BY GenreId
    ORDER BY SUM(Milliseconds) DESC
    LIMIT 5
)
ORDER BY tracks.Name;
