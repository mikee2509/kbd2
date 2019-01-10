BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"KBD2A08"."REFRESH_MVIEWS"',
            job_type => 'PLSQL_BLOCK',
            job_action => 'EXEC DBMS_MVIEW.refresh(''sumy_darowizn_mview'');
EXEC DBMS_MVIEW.refresh(''WPLATY_DARCZYNCOW_MVIEW'');',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2019-01-10 22:06:20.000000000 EUROPE/BELGRADE','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'FREQ=DAILY;BYHOUR=22;BYMINUTE=0;BYSECOND=0',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'odswiezenie perspektyw zmaterializowanych sumy_darowizn_mview i WPLATY_DARCZYNCOW_MVIEW');

         
     
 
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"KBD2A08"."REFRESH_MVIEWS"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
      
  
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"KBD2A08"."REFRESH_MVIEWS"', 
             attribute => 'max_run_duration', value => to_dsinterval('+00 00:15:00.000000'));
    
    DBMS_SCHEDULER.enable(
             name => '"KBD2A08"."REFRESH_MVIEWS"');
END;

----------------------------------------------

BEGIN
  DBMS_SCHEDULER.create_job (
    job_name        => 'refresh_mviews',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'EXEC DBMS_MVIEW.refresh(''sumy_darowizn_mview''); EXEC DBMS_MVIEW.refresh(''WPLATY_DARCZYNCOW_MVIEW'');',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'freq=daily; byminute=0; bysecond=0;',
    enabled         => TRUE);
END;
/