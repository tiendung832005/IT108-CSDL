create view View_Album_Artist as
select album.AlbumId as AlbumID,album.Title as Album_Title,artist.Name as Artist_Name
from album
join artist on album.ArtistId = artist.ArtistId;
drop view if exists View_Album_Artist;

create view View_Customer_Spending as
select customer.CustomerId as Customer_ID,customer.FirstName as First_Name,customer.LastName as Last_Name,SUM(invoice.Total) as Total_Spending
from customer
join invoice on customer.CustomerId = invoice.CustomerId
group by customer.CustomerId, customer.FirstName, customer.LastName;
drop view if exists View_Customer_Spending;

create index idx_Employee_LastName on employee (LastName);
select * from employee where LastName = 'King';
explain select * from employee where LastName = 'King';
drop index idx_Employee_LastName on employee;

DELIMITER &&
create procedure GetTracksByGenre(in GenreIdParam int)
begin
    select 
        track.TrackId as TrackID,
        track.Name as Track_Name,
        album.Title as Album_Title,
        artist.Name as Artist_Name
    from track
    join album on track.AlbumId = album.AlbumId
    join artist on album.ArtistId = artist.ArtistId
    where track.GenreId = GenreIdParam;
end &&
DELIMITER &&;
call GetTracksByGenre(1);
drop procedure if exists GetTracksByGenre;

DELIMITER &&
create procedure GetTrackCountByAlbum(in p_AlbumId int)
begin
    select count(track.TrackId) as Total_Tracks from track
    where track.AlbumId = p_AlbumId;
end &&
DELIMITER &&;
call GetTrackCountByAlbum(1);
drop procedure if exists GetTrackCountByAlbum;




