-- Note: Please consult the directions for this assignment 
-- for the most explanatory version of each question.

-- 1. Select all columns for all brands in the Brands table.

sqlite> .mode columns
sqlite> .header on
# I can also use: (which will give me every data in Brands table)
# SELECT * FROM Brands; 

-- 2. Select all columns for all car models made by Pontiac in the Models table.
sqlite> SELECT * FROM Models WHERE brand_name = 'Pontiac';
id          year        brand_name  name      
----------  ----------  ----------  ----------
25          1961        Pontiac     Tempest   
27          1962        Pontiac     Grand Prix
36          1963        Pontiac     Grand Prix
42          1964        Pontiac     GTO       
43          1964        Pontiac     LeMans    
44          1964        Pontiac     Bonneville
45          1964        Pontiac     Grand Prix 


-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.
sqlite> SELECT brand_name, name FROM Models WHERE year = '1964';
brand_name  name      
----------  ----------
Chevrolet   Corvette  
Ford        Mustang   
Ford        Galaxie   
Pontiac     GTO       
Pontiac     LeMans    
Pontiac     Bonneville
Pontiac     Grand Prix
Plymouth    Fury      
Studebaker  Avanti    
Austin      Mini Coope


-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.

sqlite> SELECT Models.name, Models.brand_name, Brands.headquarters FROM Models JOIN Brands ON (Models.brand_name = Brands.name) WHERE Models.name = 'Mustang';
name        brand_name  headquarters
----------  ----------  ------------
Mustang     Ford        Dearborn, MI

-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).

sqlite> SELECT * FROM Brands WHERE founded < 2003 ORDER by founded LIMIT 3;
id          name        founded     headquarters         discontinued
----------  ----------  ----------  -------------------  ------------
10          Studebaker  1852        South Bend, Indiana  1967        
13          Rambler     1901        Kenosha, Washington  1969        
6           Cadillac    1902        New York City, NY 

-- 6. Count the Ford models in the database (output should be a number).

sqlite> SELECT COUNT(*) FROM Models WHERE brand_name = 'Ford';
COUNT(*)  
----------
6         

-- 7. Select the name of any and all car brands that are not discontinued.
sqlite> SELECT * FROM Brands WHERE discontinued IS NULL;
id          name        founded     headquarters  discontinued
----------  ----------  ----------  ------------  ------------
1           Ford        1903        Dearborn, MI              
2           Chrysler    1925        Auburn Hills              
3           Citroën    1919        Saint-Ouen,               
5           Chevrolet   1911        Detroit, Mic              
6           Cadillac    1902        New York Cit              
7           BMW         1916        Munich, Bava              
12          Buick       1903        Detroit, MI               
15          Tesla       2003        Palo Alto, C  

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.
sqlite> SELECT id, name FROM Models WHERE id > 14 AND id < 26 ORDER BY name;
id          name      
----------  ----------
18          600       
24          Avanti    
19          Corvair   
17          Corvette  
20          Corvette  
21          Fillmore  
16          Mini      
23          Mini Coope
22          Rockette  
25          Tempest   
15          Thunderbir

-- 9. Select the brand, name, and year the model's brand was 
--    founded for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be NULL if 
--    the brand is not in the Brands table.)

sqlite> SELECT Models.brand_name, Models.name, Models.year, Brands.founded FROM Models LEFT JOIN Brands ON Models.brand_name = Brands.name WHERE Models.year = 1960;
brand_name  name        year        founded   
----------  ----------  ----------  ----------
Chevrolet   Corvair     1960        1911      
Chevrolet   Corvette    1960        1911      
Fillmore    Fillmore    1960                  
Fairthorpe  Rockette    1960        1954
 
-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all brands that are not discontinued
-- regardless of whether they have any models in the models table.
-- before:

    -- SELECT b.name,
    --        b.founded,
    --        m.name
    -- FROM Model AS m, Brands as b
    --   LEFT JOIN brands AS b
    --     ON b.name = m.brand_name
    -- WHERE b.discontinued IS NULL;

sqlite> SELECT  m.name, b.name, b.founded FROM Brands AS b LEFT JOIN Models AS m ON(b.name = m.brand_name) WHERE b.discontinued IS NULL OR m.name IS NULL;
name        name        founded   
----------  ----------  ----------
E-Series    Ford        1903      
Galaxie     Ford        1903      
Model T     Ford        1903      
Mustang     Ford        1903      
Thunderbir  Ford        1903      
Thunderbir  Ford        1903      
Imperial    Chrysler    1925      
2CV         Citroën    1919      
Corvair     Chevrolet   1911      
Corvair 50  Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Fleetwood   Cadillac    1902      
600         BMW         1916      
600         BMW         1916      
600         BMW         1916      
Special     Buick       1903      
            Tesla       2003     

-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    -- SELECT m.name,
    --        m.brand_name,
    --        b.founded
    -- FROM Models AS m
    --   LEFT JOIN Brands AS b
    --     ON b.name = m.brand_name;

sqlite> SELECT m.name, m.brand_name, b.founded FROM Models AS m LEFT JOIN Brands AS b ON(b.name=m.brand_name) WHERE b.name IS NOT NULL;
name        brand_name  founded   
----------  ----------  ----------
Model T     Ford        1903      
Imperial    Chrysler    1925      
2CV         Citroën    1919      
Minx Magni  Hillman     1907      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Fleetwood   Cadillac    1902      
Corvette    Chevrolet   1911      
Thunderbir  Ford        1903      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
600         BMW         1916      
Corvette    Chevrolet   1911      
600         BMW         1916      
Thunderbir  Ford        1903      
Mini        Austin      1905      
Corvette    Chevrolet   1911      
600         BMW         1916      
Corvair     Chevrolet   1911      
Corvette    Chevrolet   1911      
Rockette    Fairthorpe  1954      
Mini Coope  Austin      1905      
Avanti      Studebaker  1852      
Tempest     Pontiac     1926      
Corvette    Chevrolet   1911      
Grand Prix  Pontiac     1926      
Corvette    Chevrolet   1911      
Avanti      Studebaker  1852      
Special     Buick       1903      
Mini        Austin      1905      
Mini Coope  Austin      1905      
Classic     Rambler     1901      
E-Series    Ford        1903      
Avanti      Studebaker  1852      
Grand Prix  Pontiac     1926      
Corvair 50  Chevrolet   1911      
Corvette    Chevrolet   1911      
Corvette    Chevrolet   1911      
Mustang     Ford        1903      
Galaxie     Ford        1903      
GTO         Pontiac     1926      
LeMans      Pontiac     1926      
Bonneville  Pontiac     1926      
Grand Prix  Pontiac     1926      
Fury        Plymouth    1928      
Avanti      Studebaker  1852      
Mini Coope  Austin      1905  




-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.
Left joins get all rows on one table and any matching row(s) from the other table. 
If there is no match, it returns NULL.


Inner joins only provides records with matching information.

-- 3. Modify the query so that it only selects brands that don't have any models in the models table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    -- SELECT name,
    --        founded
    -- FROM Brands
    --   LEFT JOIN Models
    --     ON brands.name = Models.brand_name
    -- WHERE Models.year > 1940;

sqlite> SELECT Brands.name, Brands.founded FROM Brands LEFT JOIN Models ON (Brands.name = Models.brand_name) WHERE Models.id IS NULL;
name        founded   
----------  ----------
Tesla       2003

-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model until the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    -- SELECT b.name,
    --        m.name,
    --        m.year,
    --        b.discontinued
    -- FROM Models AS m
    --   LEFT JOIN brands AS b
    --     ON m.brand_name = b.name
    -- WHERE b.discontinued NOT NULL;

sqlite> SELECT b.name, m.name, m.year, b.discontinued, b.discontinued - m.year AS years_until_brand_discountinued FROM Models AS m LEFT JOIN Brands AS b ON(m.brand_name = b.name) WHERE b.discontinued NOT NULL;
name        name              year        discontinued  years_until_brand_discountinued
----------  ----------------  ----------  ------------  -------------------------------
Hillman     Minx Magnificent  1950        1981          31                             
Austin      Mini              1959        1987          28                             
Fairthorpe  Rockette          1960        1976          16                             
Austin      Mini Cooper       1961        1987          26                             
Studebaker  Avanti            1961        1967          6                              
Pontiac     Tempest           1961        2010          49                             
Pontiac     Grand Prix        1962        2010          48                             
Studebaker  Avanti            1962        1967          5                              
Austin      Mini              1963        1987          24                             
Austin      Mini Cooper S     1963        1987          24                             
Rambler     Classic           1963        1969          6                              
Studebaker  Avanti            1963        1967          4                              
Pontiac     Grand Prix        1963        2010          47                             
Pontiac     GTO               1964        2010          46                             
Pontiac     LeMans            1964        2010          46                             
Pontiac     Bonneville        1964        2010          46                             
Pontiac     Grand Prix        1964        2010          46                             
Plymouth    Fury              1964        2001          37                             
Studebaker  Avanti            1964        1967          3                              
Austin      Mini Cooper       1964        1987          23   


-- Part 3: Further Study

-- 1. Select the name of any brand with more than 5 models in the database.

-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

-- 3. Write a SQL statement to crate a table called `Awards`
--    with columns `name`, `year`, and `winner`. Choose
--    an appropriate datatype and nullability for each column
--   (no need to do subqueries here).

-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      the id for the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      the id for the 2015 Subaru Outback

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.





