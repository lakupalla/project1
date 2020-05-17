use ${hivevar:db_name};
set hive.exec.dynamic.partition=true;
set hive.mapred.mode=nonstrict;
set hive.exec.dynamic.partition=true;
set hive.execution.engine=tez;
set hive.exec.dynamic.partition.mode=nonstrict;
set mapreduce.map.memory.mb=8192;
set mapreduce.map.java.opts=-Xmx6144m;
set hive.exec.max.dynamic.partitions=1000000;
set hive.exec.max.dynamic.partitions.pernode=1000000;
set hive.session.id=${hivevar:step_job_name};
set hive.vectorized.execution.enabled=false;
set hive.optimize.sort.dynamic.partition=true;
set tez.grouping.min-size=544874240;
set tez.grouping.max-size=644874240;
set mapreduce.input.fileinputformat.split.minsize=544874240;
set mapreduce.input.fileinputformat.split.maxsize=644874240;

INSERT INTO TABLE NSCVP73_BAIDU_IVI_PII_HTE PARTITION(scvp73_partition_month_year_x)
select
sha_key                                        as  scvp73_sha_k,
event_date                               	   as  scvp73_event_y,
uuid         	 							   as  scvp73_uu_d,
vin								               as  scvp73_vin_2,
model   						               as  scvp73_mdl_x,
event_id								       as  scvp73_event_d,
start_time								       as  scvp73_strt_s,
end_time								       as  scvp73_end_s,
event_desc							           as  scvp73_event_x,
type             		        			   as  scvp73_typ_r,
net									           as  scvp73_net_r,
operator         						       as  scvp73_optr_r,
attach      								   as  scvp73_atch_x,
raw_payload									   as  scvp73_raw_payload_x,
process_status								   as  scvp73_proc_stat_c,
process_status_details						   as  scvp73_proc_stat_dtl_x,
process_status_date_time_utc                   as  scvp73_proc_stat_utc_s,
FROM_UNIXTIME(UNIX_TIMESTAMP())                as  scvp73_created_on_s,
'${hivevar:current_user}'					   as  scvp73_created_by_c,
partition_month_year                           as  scvp73_partition_month_year_x
from NSCVZ73_BAIDU_IVI_NONDUP_ST_HTE;
