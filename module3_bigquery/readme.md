## Question 1 : 
SELECT count(*) FROM `classe-zoomcamp.module3_homeworks.homeworks3_native`


## Question 2 

SELECT count(distinct(PULocationID)) FROM `classe-zoomcamp.module3_homeworks.homeworks3_native` 
anwer : 6.41MB for native

SELECT count(distinct(PULocationID)) FROM `classe-zoomcamp.module3_homeworks.homeworks3_external` 
answer :  0 for the external data table


## Question 3 

SELECT count(fare_amount) FROM `classe-zoomcamp.module3_homeworks.homeworks3_native` WHERE fare_amount=0

##  Question 4 
solution :  Partition by lpep_pickup_datetime Cluster on PUlocationID


## Question 5 

CREATE OR REPLACE TABLE `classe-zoomcamp.module3_homeworks.homeworks3_native_partitioned`
PARTITION BY
DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM `classe-zoomcamp.module3_homeworks.homeworks3_native`;

## Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)

SELECT count(distinct(PULocationID)) FROM `classe-zoomcamp.module3_homeworks.homeworks3_native_partitioned`
where lpep_pickup_datetime between '2022-06-01' and '2022-06-30'
solution : 1.12MB

SELECT count(distinct(PULocationID)) FROM `classe-zoomcamp.module3_homeworks.homeworks3_native`
where lpep_pickup_datetime between '2022-06-01' and '2022-06-30'
solution : 12.82MB

## Question 7 
It is not a best practice to always cluster you data in BQ
