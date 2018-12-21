create or replace TRIGGER przypisz_konto
-- Znajduje konto z najmniejsza liczba przypisanych podopiecznych
-- i przypisuje nowego podopiecznego do tego konta
BEFORE INSERT
	ON PODOPIECZNI
FOR EACH ROW 
WHEN (NEW.ID_KONTA IS NULL) 
BEGIN
    SELECT ID_KONTA
    INTO :NEW.ID_KONTA
    FROM 
    	(SELECT K.ID_KONTA FROM KONTA K LEFT JOIN PODOPIECZNI P ON P.ID_KONTA = K.ID_KONTA group by K.ID_KONTA ORDER BY COUNT(P.ID_PODOP) ASC)
	WHERE ROWNUM = 1;    
END;


create or replace TRIGGER oper_bank_view_insert_trg
INSTEAD OF INSERT ON oper_bank_view
DECLARE
    id_konta_nadawcy KONTA.NR_KONTA%TYPE;
    id_konta_odbiorcy KONTA.NR_KONTA%TYPE;
    id_nowego_darczyncy DARCZYNCY.ID_DARCZYNCY%TYPE;
BEGIN 
    SELECT ID_KONTA INTO id_konta_odbiorcy
    FROM KONTA K
    WHERE K.TYP_WLASCICIELA = 'F' AND K.NR_KONTA = :NEW.NR_KONTA_ODBIORCY;

    BEGIN
        SELECT ID_KONTA INTO id_konta_nadawcy
        FROM KONTA K 
        WHERE K.TYP_WLASCICIELA = 'D' AND K.NR_KONTA = :NEW.NR_KONTA_NADAWCY;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO DARCZYNCY (NAZWA) VALUES (:NEW.NAZWA_NADAWCY)
            RETURNING id_darczyncy INTO id_nowego_darczyncy;

            INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, ID_DARCZYNCY)
            VALUES(:NEW.NR_KONTA_NADAWCY, 'D', id_nowego_darczyncy)
            RETURNING id_konta INTO id_konta_nadawcy;
    END;

    INSERT INTO OPERACJE_BANKOWE (KWOTA, DATA_OPERACJI, ID_KONTA_NADAWCY, ID_KONTA_ODBIORCY, TYTUL)
    VALUES(:NEW.KWOTA, :NEW.DATA_OPERACJI, id_konta_nadawcy, id_konta_odbiorcy, :NEW.TYTUL);
END;



CREATE OR REPLACE TRIGGER PRZYPISZ_OP_DO_PODOP_TRG
-- podejmuje probe przypisania operacji do podopiecznego
-- na podstawie zdefiniowanych slow kluczowych
BEFORE INSERT
	ON OPERACJE_BANKOWE
FOR EACH ROW 
WHEN (NEW.ID_PODOP IS NULL)
BEGIN

    SELECT ID_SLOWA_KL, ID_PODOP INTO :NEW.ID_SLOWA_KL, :NEW.ID_PODOP 
    --FROM SLOWA_KLUCZOWE WHERE REGEXP_LIKE (:NEW.TYTUL, WARTOSC);
    FROM SLOWA_KLUCZOWE WHERE INSTR(:NEW.TYTUL, WARTOSC) > 0        
    JOIN PODOPIECZNI P ON P.ID_KONTA = :NEW.ID_KONTA_ODBIORCY; -- TODO sprawdzic - chodzi o to, zeby szukac tylko w ramach slow kluczowych dla tego konta

END;
/