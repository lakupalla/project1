use ${hivevar:db_name};

create external table if not exists NSCVD73_BAIDU_IVI_DUP_HTE
(
   scvd73_sha_k string,
   scvd73_created_on_s TIMESTAMP,
   scvd73_created_by_c VARCHAR(10)
)
stored as orc
location '/project/CVDP/CVDP${hivevar:hdfs_env}/Warehouse/Secure/BaiduIVI/nscvd73_baidu_ivi_dup_hte';

create external table if not exists NSCVE73_BAIDU_IVI_TEMP_DUP_ST_HTE
(
   scve73_sha_k string
)
location '/project/CVDP/CVDP${hivevar:hdfs_env}/Warehouse/Staging/BaiduIVI/nscve73_baidu_ivi_temp_dup_st_hte';
create external table if not exists NSCVS73_BAIDU_IVI_ST_HTE
(
   sha_key string,
   event_date string,
   uuid varchar(50),
   vin varchar(17),
   model varchar(50),
   event_id varchar(20),
   start_time Timestamp,
   end_time Timestamp,
   event_desc varchar(200),
   type int,
   net int,
   operator int,
   attach varchar(200),
   raw_payload string,
   partition_month_year string,
   process_status string,
   process_status_details string,
   process_status_date_time_utc timestamp
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
location '/project/CVDP/CVDP${hivevar:hdfs_env}/Warehouse/Staging/BaiduIVI/nscvs73_baidu_ivi_st_hte';

create external table if not exists NSCVZ73_BAIDU_IVI_NONDUP_ST_HTE
(
   sha_key string,
   event_date string,
   uuid varchar(50),
   vin varchar(17),
   model varchar(50),
   event_id varchar(20),
   start_time Timestamp,
   end_time Timestamp,
   event_desc varchar(200),
   type int,
   net int,
   operator int,
   attach varchar(200),
   raw_payload string,
   partition_month_year string,
   process_status string,
   process_status_details string,
   process_status_date_time_utc timestamp
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
location '/project/CVDP/CVDP${hivevar:hdfs_env}/Warehouse/Staging/BaiduIVI/nscvz73_baidu_ivi_nondup_st_hte';

create external table if not exists NSCVP73_BAIDU_IVI_PII_HTE
(
   scvp73_sha_k string,
   scvp73_event_y string,
   scvp73_uu_d varchar(50),
   scvp73_vin_2 varchar(17),
   scvp73_mdl_x varchar(50),
   scvp73_event_d varchar(20),
   scvp73_strt_s Timestamp,
   scvp73_end_s Timestamp,
   scvp73_event_x varchar(200),
   scvp73_typ_r int,
   scvp73_net_r int,
   scvp73_optr_r int,
   scvp73_atch_x varchar(200),
   scvp73_raw_payload_x string,
   scvp73_proc_stat_c string,
   scvp73_proc_stat_dtl_x string,
   scvp73_proc_stat_utc_s timestamp,
   scvp73_created_on_s timestamp,
   scvp73_created_by_c varchar(10)
)
partitioned by (scvp73_partition_month_year_x string)
stored as orc
location '/project/CVDP/CVDP${hivevar:hdfs_env}/Warehouse/Secure/BaiduIVI/nscvp73_baidu_ivi_pii_hte'
tblproperties ('orc.compress.size'='8192');
