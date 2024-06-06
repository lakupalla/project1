SELECT T2.* FROM tableN T1 JOIN tableN T2 ON T1.trainerid <> T2.trainerid AND (T1.starttime BETWEEN T2.starttime AND T2.endtime) AND (T1.endtime BETWEEN T2.starttime AND T2.endtime)
