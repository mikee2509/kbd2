-- konta fundacji
INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000000001', 'F', '17/06/20', 'pierwsze konto');

INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000000002', 'F', '18/02/25', 'drugie konto');

INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000000003', 'F', '18/07/30', 'trzecie konto');
commit;


-- podopieczni
-- automatyczne przypisanie konta
INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL)
VALUES ('Drozd', 'Jan', 'jan.drozd@poczta.com');

INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL)
VALUES ('Nowak', 'Stefan', 'stefan.nowak@poczta.com');

INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL)
VALUES ('Wanna', 'Hanna', 'hanna.wanna@poczta.com');

-- reczne przypisanie konta
INSERT INTO PODOPIECZNI (NAZWISKO, IMIE, EMAIL, ID_KONTA)
VALUES ('Kowalski', 'Andrzej', 'andrzej.kowalski@poczta.com', 1);
commit;


--slowa kluczowe
INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('Drozd', 'po nazwisku', 1);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('Nowak', 'po nazwisku', 2);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('Wanna', 'po nazwisku', 3);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('Kowalski', 'po nazwisku', 4);

INSERT INTO SLOWA_KLUCZOWE (WARTOSC, OPIS, ID_PODOP)
VALUES('zbiórka nr 1234', 'zbiórka 1234 na kiermaszu świątecznym 12.12.2018r.', 4);
commit;




------------------------------
-- drafts - remove

-- darczyncy
INSERT INTO DARCZYNCY (NAZWA, EMAIL) VALUES ('Konrad Wiśniewski', 'k.wisn@poczta.com');

-- konta darczyncow
INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, ID_DARCZYNCY)
VALUES ('40000000000000000000000001', 'D', 1);


INSERT INTO OPERACJE_BANKOWE (KWOTA, DATA_OPERACJI, ID_KONTA_NADAWCY, ID_KONTA_ODBIORCY, ID_PODOP, TYTUL)
VALUES (12.60, current_timestamp, 4, 1, 4 , 'jakas wplata')









-- brak id darczyncy
INSERT INTO KONTA (NR_KONTA, TYP_WLASCICIELA, DATA_ZALOZENIA, OPIS)
VALUES ('10000000000000000000002000', 'D', '17/06/20', 'pierwsze konto')

-- data zalozenia powinna byc null



