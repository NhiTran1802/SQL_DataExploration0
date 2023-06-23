/*
SQL Data Exploration
Operate on a view to analysis (not raw data in database)
*/

-------------------------------------------------
-- What are the top 10 most commented-upon videos? The top 10 most liked?
SELECT TOP 10 *
FROM dbo.videos
ORDER BY Comments DESC

SELECT TOP 10 *
FROM dbo.videos
ORDER BY Likes DESC

-------------------------------------------------
-- How many total views does each keyword category have? How many likes?
SELECT Keyword, SUM(Views) Total_Views, SUM(Likes) Total_likes
FROM dbo.videos
GROUP BY Keyword
ORDER BY Total_Views DESC

-- How many videos does each keyword category have?
SELECT Keyword, COUNT(*) Count_Video
FROM dbo.videos
GROUP BY Keyword
ORDER BY Count_Video DESC

-------------------------------------------------
-- What are top 20 the most-liked comments?
SELECT TOP 20 Comment, Likes
FROM dbo.comments
ORDER BY Likes DESC

-------------------------------------------------
-- How High is Engagement? (Comments to Views)
SELECT Video_ID
, Title
, (Comments/ Views)*100 AS Engagement
FROM dbo.videos
ORDER BY Engagement DESC

-- and How Popular is the Video? (Likes to Views)
SELECT Video_ID
, Title
, (Likes/ Views)*100 AS Popular
FROM dbo.videos
ORDER BY Popular DESC

-------------------------------------------------
-- Which video has the highest views in the "music" category?
SELECT TOP 1 *
FROM dbo.videos
WHERE Keyword = 'music'
ORDER BY Views DESC

-------------------------------------------------
-- What is the average sentiment score in each keyword category?
SELECT a.Keyword
, AVG(b.Sentiment) avg_sentiment
FROM dbo.videos a
JOIN dbo.comments b
ON a.Video_ID = b.Video_ID
GROUP BY a.Keyword
ORDER BY avg_sentiment DESC

-------------------------------------------------
-- How many times do company names (i.e., Apple) appear in each keyword category?
SELECT Keyword
, COUNT(*) 
FROM dbo.videos
WHERE LOWER(Title) LIKE '%apple%'
GROUP BY Keyword

-------------------------------------------------
-- Creating view to store for later visualizations
CREATE VIEW VideosView AS
SELECT a.Title, a.Video_ID, a.Published_At, a.Keyword, a.Likes, a.Comments, a.Views
, b.Comment, b.Likes LikeCom, b.Sentiment
FROM dbo.videos a
JOIN dbo.comments b
ON a.Video_ID = b.Video_ID

