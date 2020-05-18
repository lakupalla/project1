#!/bin/sh
##########################################################################
#    deployCampaign - Runs One-time Scripts
#    Input Parmaters:
#     - env - Environment
##########################################################################
ENV=$1

if [ "$ENV" = "DEV" ]; then
    DB_NAME="cvdp"
elif [ "$ENV" = "QA" ]; then
    DB_NAME="cvdp_qa"
elif [ "$ENV" = "PRD" ]; then
    DB_NAME="cvdp"
fi

beeline -f  "alterMetricTable.ql"  --hivevar db_name=$DB_NAME --hivevar env=$ENV

beeline -f  "alterInvalidTable.ql"  --hivevar db_name=$DB_NAME --hivevar env=$ENV

# Place each script of command to be ran into the script[] array

script[0]="hdfs_dir_setup.txt";
env=$1;

for i in ${script[@]}; do
    eval "$(<${i})" | sed -e "s/\${env}/$env/g";
done
