-- konta fundacji
INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000000001', 'F', '17/06/20', 'pierwsze konto');

INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000000002', 'F', '18/02/25', 'drugie konto');

INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000000003', 'F', '18/07/30', 'trzecie konto');
commit;



-- podopieczni
-- reczne przypisanie konta
INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL, ID_KONTA)
VALUES ('Drozd', 'Jan', 'jan.drozd@poczta.com', 1);

INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL, ID_KONTA)
VALUES ('Nowak', 'Stefan', 'stefan.nowak@poczta.com', 2);

INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL, ID_KONTA)
VALUES ('Wanna', 'Hanna', 'hanna.wanna@poczta.com', 3);

INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL, ID_KONTA)
VALUES ('Karol', 'Opolski', 'karol.opolski@poczta.com', 3);

-- automatyczne przypisanie konta
INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL)
VALUES ('Kowalski', 'Andrzej', 'andrzej.kowalski@poczta.com');
commit;



-- slowa kluczowe
INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('DROZD', 'po nazwisku', 1);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('NOWAK', 'po nazwisku', 2);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('WANNA', 'po nazwisku', 3);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('OPOLSKI', 'po nazwisku', 4);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('KOWALSKI', 'po nazwisku', 5);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('ZBIÓRKA NR 1234', 'zbiórka 1234 na kiermaszu świątecznym 12.12.2018r.', 5);
commit;



-- operacje bankowe (darowizny)
INSERT INTO oper_bank_view(
    NAZWA_NADAWCY, 
    NR_KONTA_NADAWCY, 
    NR_KONTA_ODBIORCY,
    KWOTA, 
    TYTUL, 
    DATA_OPERACJI
) VALUES(
    'Zdzisław Wiśniewski',
    '40000000000000000000000001',
    '10000000000000000000000003',
    14.00,
    'darowizna OPOLSKI',
    TO_DATE('15-06-2018', 'DD-MM-YYYY')
);

INSERT INTO oper_bank_view(
    NAZWA_NADAWCY, 
    NR_KONTA_NADAWCY, 
    NR_KONTA_ODBIORCY,
    KWOTA, 
    TYTUL, 
    DATA_OPERACJI
) VALUES(
    'Zdzisław W',
    '40000000000000000000000001',
    '10000000000000000000000003',
    35.00,
    'darowizna WANNA',
    TO_DATE('16-06-2018', 'DD-MM-YYYY')
);

INSERT INTO oper_bank_view(
    NAZWA_NADAWCY, 
    NR_KONTA_NADAWCY, 
    NR_KONTA_ODBIORCY,
    KWOTA, 
    TYTUL, 
    DATA_OPERACJI
) VALUES(
    'Zdzisław W',
    '40000000000000000000000001',
    '10000000000000000000000003',
    35.00,
    'darowizna WANNA',
    TO_DATE('17-06-2018', 'DD-MM-YYYY')
);

-- TEST ta operacja nie powinna zostać automatycznie przypisana
-- ze wezgledu na 2 slowa kluczowe w tytule dla roznych osob
INSERT INTO oper_bank_view(
    NAZWA_NADAWCY, 
    NR_KONTA_NADAWCY, 
    NR_KONTA_ODBIORCY,
    KWOTA, 
    TYTUL, 
    DATA_OPERACJI
) VALUES(
    'Zdzisław W',
    '40000000000000000000000001',
    '10000000000000000000000003',
    35.00,
    'darowizna WANNA i OPOLSKI',
    TO_DATE('17-06-2018', 'DD-MM-YYYY')
);

commit;









-- inne testowe TODO



-- TEST brak id darczyncy i data zalozenia != null
INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000002000', 'D', '17/06/20', 'pierwsze konto')

-- TEST data zalozenia powinna byc null
INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS, ID_DARCZYNCY)
VALUES ('10000000000000000000002000', 'D', '17/06/20', 'jakies konto', 1)



