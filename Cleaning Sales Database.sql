
create database Sales

Use Sales

select * from Customers
select * from Product
select * from Orders



/* remove irrelevent data
   remove duplicate data
   fix structural errors
   do type conversion
   handle missing data
   deal with outliers
   standardize/normalize data
   validate data
*/

 select * from Customers

--remove irrelevent columns using delete function

 alter table customers
 drop column  year , month, full_name 

 alter table customers
 drop column place_name, SSN, Name_Prefix


-- Now check distict records

 select distinct * from Customers -- it will not remove duplicate from source table


-- check out how many duplicate values we have for each customer using row_number


 With CTE as
 (Select *,
 Row_Number() OVER(Partition BY cust_ID ORDER BY cust_ID) Row_num
 from Customers
 )
 Select *
 from CTE
 where row_num>1
 Order by cust_id


-- Let delete the duplicate records so that eficiency will increase

 With CTE as (
 Select *,
 Row_Number() OVER(Partition BY cust_ID ORDER BY cust_ID) Row_num
 from Customers
)
 delete from cte 
 where row_num>1;

 select * from Customers
/*deleted more than more than 2 lakh duplicated rows, remaining unique values are ~65k */


-- concat 3 column related to name

 select *, concat(first_name, ' ', middle_initial, '. ', last_name)as full_name from Customers

 

--- Now lets make a single column for name using concat method and
--- replace with old column so that changes saved in original table


update Customers
set First_Name = REPLACE(first_name,first_name,concat(first_name, ' ', Middle_Initial, '. ', last_name))

select * from Customers

-- Now change the name column name first_name with Full_name and drop middle & last name column

sp_rename 'customers.first_name', 'Full_name'

alter table customers
drop column middle_initial, last_name


-- now we will replace gender 'M' to Male and 'F' to Female using case statement

select gender, count(gender) from Customers
group by gender

update Customers
set Gender = (case when gender = 'F' then 'Female'
when gender= 'M' then 'Male' end)


-- checking whole table for null values

select sum(case when cust_id is null then 1 else 0 end) as cust_id_null_count,
sum(case when ref_num is null then 1 else 0 end) as cust_id_null_count,
sum(case when full_name is null then 1 else 0 end) as cust_id_null_count,
sum(case when gender is null then 1 else 0 end) as cust_id_null_count,
sum(case when age is null then 1 else 0  end) as cust_id_null_count,
sum(case when e_mail is null then 1  else 0 end) as cust_id_null_count,
sum(case when customer_since is null then 1 else 0 end) as cust_id_null_count,
sum(case when phone_no is null then 1 else 0 end) as cust_id_null_count,
sum(case when county is null then 1 else 0  end) as cust_id_null_count,
sum(case when city is null then 1 else 0 end) as cust_id_null_count,
sum(case when state is null then 1 else 0 end) as cust_id_null_count,
sum(case when zip is null then 1 else 0  end) as cust_id_null_count,
sum(case when region is null then 1 else 0 end) as cust_id_null_count,
sum(case when user_name is null then 1 else 0 end) as cust_id_null_count
from Customers



-- now use relevent data for analysis, 
-- example - This data contain info from 1978 to 2017 customers, 
-- we want to know how many customer start purchasing products from last 1 year


 select * from Customers
 where Customer_Since >= '2016'





