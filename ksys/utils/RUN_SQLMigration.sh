#!/bin/sh
#
# $Id: RUN_SQLMigration.sh,v 0.9 2012/04/03 21:37:18 longnan $

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server
echo Import Adempiere - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

SUFFIX=""
SYSUSER=system
if [ $ADEMPIERE_DB_PATH = "postgresql" ]
then
    SUFFIX="_pg"
    SYSUSER=postgres
fi

echo Last SQL Migration folder for seed database $IDEMPIERE_HOME/data/seed/migration/i2.0/$ADEMPIERE_DB_PATH
echo == Start... ==
ls -lsa $IDEMPIERE_HOME/data/seed/migration/i2.0/$ADEMPIERE_DB_PATH
echo Press enter to continue ...
read in

# Parameter: <systemAccount> <AdempiereID> <AdempierePwd> <PostgresPwd>
#$ADEMPIERE_DB_PATH/SQLMigration.sh $SYSUSER/$ADEMPIERE_DB_SYSTEM $ADEMPIERE_DB_USER $ADEMPIERE_DB_PASSWORD $ADEMPIERE_DB_SYSTEM

echo -------------------------------------
echo Apply migration SQL to database
echo -------------------------------------

PGPASSWORD=$ADEMPIERE_DB_PASSWORD
export PGPASSWORD

cd $IDEMPIERE_HOME/data/seed/migration/i2.0/$ADEMPIERE_DB_PATH
for sqlfile in *.sql; do
    echo $sqlfile
    psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -U $ADEMPIERE_DB_USER -d $ADEMPIERE_DB_NAME -f $sqlfile
done

echo == End. ==
