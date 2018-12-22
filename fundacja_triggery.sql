create or replace TRIGGER przypisz_konto_trg
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
/

create or replace TRIGGER oper_bank_view_insert_trg
-- Wyzwalacz uruchamiany przy dodawaniu danych za pomoca perspektywy OPER_BANK_VIEW
-- Sprawdza czy NR_KONTA_ODBIORCY jest numerem konta nalezacym do fundacji.
-- Na podstawie NR_KONTA_NADAWCY przypisuje operacje do istniejacego darczyncy  
-- lub jesli nie istnieje - tworzy nowego darczynce zapamietujac jego nazwe.
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
/


create or replace TRIGGER PRZYPISZ_OP_DO_PODOP_TRG
-- podejmuje probe przypisania operacji do podopiecznego
-- na podstawie zdefiniowanych slow kluczowych
-- rozpatrywane sa tylko slowa kluczowe podopiecznych zwiazanych
-- z danym rachunkiem
BEFORE INSERT
    ON OPERACJE_BANKOWE
FOR EACH ROW 
WHEN (NEW.ID_PODOP IS NULL)
BEGIN
    BEGIN
        SELECT S.ID_PODOP, MIN(S.ID_SLOWA_KL) INTO :NEW.ID_PODOP, :NEW.ID_SLOWA_KL        
        --FROM SLOWA_KLUCZOWE WHERE REGEXP_LIKE (:NEW.TYTUL, WARTOSC);
        FROM SLOWA_KLUCZOWE S        
        JOIN PODOPIECZNI P ON S.ID_PODOP = P.ID_PODOP
        WHERE P.ID_KONTA = :NEW.ID_KONTA_ODBIORCY AND INSTR(UPPER(:NEW.TYTUL), WARTOSC) > 0
        GROUP BY S.ID_PODOP;
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
        -- niepowodzenie dopasowania pojedynczego podopiecznego na podstawie
        -- slow kluczowych - zaden podopieczny nie zostaje przypisany,
        -- konieczne reczne przypisania
        NULL;
    END;    
END;
/


CREATE OR REPLACE TRIGGER fkntm_op_bank_nadawca_trg BEFORE
    UPDATE OF id_konta_nadawcy ON operacje_bankowe FOR EACH ROW
    WHEN (new.id_konta_nadawcy <> old.id_konta_nadawcy)
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint on table OPERACJE_BANKOWE is violated');
END;
/


CREATE OR REPLACE TRIGGER fkntm_op_bank_odbiorca_trg BEFORE
    UPDATE OF id_konta_odbiorcy ON operacje_bankowe FOR EACH ROW
    WHEN (new.id_konta_odbiorcy <> old.id_konta_odbiorcy)
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint on table OPERACJE_BANKOWE is violated');
END;
/


CREATE OR REPLACE TRIGGER fkntm_slowa_kl_podop_trg BEFORE
    UPDATE OF id_podop ON slowa_kluczowe FOR EACH ROW
    WHEN (new.id_podop <> old.id_podop)
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint on table SLOWA_KLUCZOWE is violated');
END;
/


CREATE OR REPLACE TRIGGER fkntm_op_bank_sl_kl_trg BEFORE
    UPDATE OF id_slowa_kl ON operacje_bankowe FOR EACH ROW
    WHEN (new.id_slowa_kl <> old.id_slowa_kl AND new.id_slowa_kl <> NULL)
BEGIN
    raise_application_error(-20225,'Non Transferable FK constraint on table OPERACJE_BANKOWE is violated');
END;
/
