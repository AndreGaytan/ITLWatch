FROM mysql

ENV MYSQL_ROOT_PASSWORD 1234

COPY 1-DBCreation.sql /docker-entrypoint-initdb.d
COPY 2-DBFunctions.sql /docker-entrypoint-initdb.d
COPY 3-DBViews.sql /docker-entrypoint-initdb.d
COPY 4-BDStoredProcedures.sql /docker-entrypoint-initdb.d
COPY 5-DBPoblation.sql /docker-entrypoint-initdb.d
