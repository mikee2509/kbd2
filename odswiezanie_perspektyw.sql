
-- https://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_6002.htm#SQLRF01302
-- START WITH Clause

-- następne odświeżenie o 4, kolejne też codziennie o 4
ALTER MATERIALIZED VIEW sumy_darowizn_mview
    REFRESH
    START WITH TRUNC(sysdate)+4/24
    NEXT TRUNC(sysdate)+1+4/24;



ALTER MATERIALIZED VIEW wplaty_darczyncow_mview
    REFRESH
    START WITH TRUNC(sysdate)+4/24
    NEXT TRUNC(sysdate)+1+4/24;


-- Lista zaplanowanych odświeżeń
select * from user_jobs;

    
-- bieżący czas
SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') "NOW" FROM DUAL;    

-- czas ostatniego odświeżenia mviews
SELECT owner, mview_name, last_refresh_date FROM all_mviews;