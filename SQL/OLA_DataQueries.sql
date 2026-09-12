create database OLA_DataAnalysis

use OLA_DataAnalysis

---
select * from OLA_Rides_data
---
select * into Benguluru_data from OLA_Rides_data
---
select * from Benguluru_data
---
alter table Benguluru_data add Payment_Method varchar(30)
---
select max(Booking_Value) from Benguluru_data
---
update Benguluru_data set Payment_Method=
case 
when Booking_Value between 1000 and 1800 then 'CreditCard'
when Booking_Value between 500 and 1000 then 'UPI'
else 'Cash'
end

------------------Table With Data Created Successfully----------

--1> Retrieve all successful bookings:
create view SuccessfulBooking as
select * from Benguluru_data where Booking_Status='Successful'

select * from SuccessfulBooking  --simplyfied Query

--2> Find the average ride distance for each vehicle type
create or alter view Ride_Distance_For_Each_Vehicle as
select Vehicle_Type, round(avg(Ride_distance),2) as Average_Ride_Distance from Benguluru_data group by Vehicle_Type

select * from Ride_Distance_For_Each_Vehicle

--3> Get the total number of cancelled rides by customers
alter table Benguluru_data alter column cancelled_Rides_by_Customer bigint

create or alter view Cancelled_rides_by_Customer as
select count(*) as Total_Cancelled_Rides_by_Customer from Benguluru_data where Cancelled_Rides_by_Customer=1 

select * from Cancelled_rides_by_Customer

--4> List the top 5 customers who booked the highest number of rides
create or alter view Top5_highest_booked_rides as 
select Top 5 Customer_ID,count(Booking_ID) as Total_Rides from Benguluru_data group by Customer_ID order by count(Booking_ID) desc

select * from Top5_highest_booked_rides

--5> Get the number of rides cancelled by drivers due to personal and car-related issues
create or alter view Cancelled_by_Driver as
select count(Cancelled_Rides_by_Driver) as Total_Cancelled_Rides from Benguluru_data where Reason_for_cancelling_by_Driver='Personal & Car related issues'

select * from Cancelled_by_Driver

--6> Find the maximum and minimum driver ratings for Prime Sedan bookings
create view MinMax_Driver_Ratings as
select max(Driver_Ratings) as maximum_Driver_Ratings,min(Driver_Ratings) as minimum_Driver_Ratings from Benguluru_data where Vehicle_Type='Prime Sedan'

select * from MinMax_Driver_Ratings

--7> Retrieve all rides where payment was made using UPI
create view UPI_Rides as
select * from Benguluru_data where Payment_Method='UPI'

select * from UPI_Rides

--8> Find the average customer rating per vehicle type
create view C_average_rating as
select Vehicle_Type,avg(Customer_Rating) as avg_CRating from Benguluru_data group by Vehicle_Type

select * from C_average_rating

--9> Calculate the total booking value of rides completed successfully
create view TotalBookingValue as
select sum(Booking_Value) as TotalBookingValue from Benguluru_data where Booking_Status='Successful'

select * from TotalBookingValue

--10> List all incomplete rides along with the reason
create view IncompleteRidesWithReasons as
select Incomplete_Rides_Reason,Booking_ID from Benguluru_data where Booking_Status='Incomplete'

select * from IncompleteRidesWithReasons

--------------------------ShortAnswers----------------
-->1. Retrieve all successful bookings:
select * from SuccessfulBooking

-->2. Find the average ride distance for each vehicle type:
select * from Ride_Distance_For_Each_Vehicle

-->3. Get the total number of cancelled rides by customers:
select * from Cancelled_rides_by_Customer

-->4. List the top 5 customers who booked the highest number of rides:
select * from Top5_highest_booked_rides

-->5. Get the number of rides cancelled by drivers due to personal and car-related issues:
select * from Cancelled_by_Driver

-->6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
select * from MinMax_Driver_Ratings

-->7. Retrieve all rides where payment was made using UPI:
select * from UPI_Rides

-->8. Find the average customer rating per vehicle type:
select * from C_average_rating

-->9. Calculate the total booking value of rides completed successfully:
select * from TotalBookingValue

-->10. List all incomplete rides along with the reason:
select * from IncompleteRidesWithReasons

