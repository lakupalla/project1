use ${db_name};
set hive.exec.dynamic.partition=true;
set hive.mapred.mode=nonstrict;
set hive.execution.engine=tez;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set mapreduce.map.memory.mb=8192;
set mapreduce.map.java.opts=-Xmx6144m;
set hive.exec.max.dynamic.partitions=1000000;
set hive.exec.max.dynamic.partitions.pernode=1000000;
set hive.session.id=${step_job_name};
set hive.optimize.sort.dynamic.partition=true;

INSERT INTO TABLE NSCVD73_BAIDU_IVI_DUP_HTE
SELECT
      scve73_sha_k                          as scvd73_sha_k,
      FROM_UNIXTIME(UNIX_TIMESTAMP()) 		as scvd73_created_on_s,
      "${current_user}"               		as scvd73_created_by_c
FROM  NSCVE73_BAIDU_IVI_TEMP_DUP_ST_HTE;
