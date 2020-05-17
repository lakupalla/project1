use ${hivevar:db_name};
set hive.exec.dynamic.partition=true;
set hive.mapred.mode=nonstrict;
set hive.execution.engine=tez;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set mapreduce.map.memory.mb=8192;
set hive.auto.convert.join=false;
set mapreduce.map.java.opts=-Xmx6144m;
set hive.exec.max.dynamic.partitions=1000000;
set hive.exec.max.dynamic.partitions.pernode=1000000;
set hive.session.id=${hivevar:step_job_name};
set hive.optimize.sort.dynamic.partition=true;

-- Select Distinct Records from the Good Records Staging Table and Insert them into the NonDup Staging Table.
-- This eliminates duplicate records within the batch.

Insert into NSCVZ73_BAIDU_IVI_NONDUP_ST_HTE
select
v1.sha_key
,v1.event_date
,v1.uuid
,v1.vin
,v1.model
,v1.event_id
,v1.start_time
,v1.end_time
,v1.event_desc
,v1.type
,v1.net
,v1.operator
,v1.attach
,v1.raw_payload
,v1.partition_month_year
,v1.process_status
,v1.process_status_details
,v1.process_status_date_time_utc
from
(select
 stage.sha_key
,stage.event_date
,stage.uuid
,stage.vin
,stage.model
,stage.event_id
,stage.start_time
,stage.end_time
,stage.event_desc
,stage.type
,stage.net
,stage.operator
,stage.attach
,stage.raw_payload
,stage.partition_month_year
,stage.process_status
,stage.process_status_details
,stage.process_status_date_time_utc
,row_number() over (partition by sha_key) as r_num from NSCVS73_BAIDU_IVI_ST_HTE stage
left join NSCVP73_BAIDU_IVI_PII_HTE master ON stage.sha_key = master.scvp73_sha_k
where master.scvp73_sha_k is null) v1
where v1.r_num = 1;

-- Join the Master Table and the NonDup Staging Table and Insert the common SHA Keys into the Temp Dup Table.
-- This identifies records within the batch that are duplicates of records in the Master Table.

INSERT INTO TABLE NSCVE73_BAIDU_IVI_TEMP_DUP_ST_HTE
SELECT v1.sha_key
FROM (
SELECT
STG.sha_key
,NONDUP.sha_key as nondup_key
,row_number() over (partition by STG.sha_key) as r_num
FROM NSCVS73_BAIDU_IVI_ST_HTE STG
LEFT JOIN NSCVZ73_BAIDU_IVI_NONDUP_ST_HTE NONDUP
ON STG.sha_key = NONDUP.sha_key) v1
WHERE v1.r_num > 1
OR v1.nondup_key is null;
