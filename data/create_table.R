library(readr)
library(dplyr)
library(RPostgreSQL)
library(pool)

# Database Connection
db <- 'hhtl'
host <- 'hhtl.ctysajtozyfu.us-west-2.rds.amazonaws.com' 
port <- 5432
username <- 'hhtl'
password <- .rs.askForPassword("Enter password:")

db_pool <- dbPool(
  drv = dbDriver("PostgreSQL"),
  dbname = db,
  host = host,
  port = port,
  user = username,
  password = password
)

# dbExecute(db_pool, "DROP TABLE events;")

qry = "
CREATE TABLE events (
    id          int CONSTRAINT firstkey PRIMARY KEY,
    title       varchar(1000),
    start_date       date,
    end_date         date,
    img         varchar(1000),
    description varchar(1000),
    entry_added timestamp
);"

dbExecute(db_pool, qry)

# Check
sql = "SELECT * FROM events"
dbGetQuery(db_pool, sql)


# Insert
sql = "
INSERT INTO events VALUES
    (1, 'Test', '1971-07-13','1971-07-13', 'Test', 'Test', current_timestamp);
"
dbExecute(db_pool, sql)

# Check
sql = "SELECT * FROM events"
dbGetQuery(db_pool, sql)