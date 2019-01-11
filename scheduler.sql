BEGIN
  DBMS_SCHEDULER.create_job (
    job_name        => 'refresh_mviews',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'EXEC TODO;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'freq=daily; byminute=0; bysecond=0;',
    enabled         => TRUE);
END;
/