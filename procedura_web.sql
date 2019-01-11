create or replace procedure startWWW(
	-- Procedura Web-PL/SQL
	-- Wyswietla tabele prezentujaca sume wplat dla podopiecznych w danym miesiacu danego roku.
	-- Pokazywany jest rowniez formularz umozliwiajacy uruchomienie procedury z danymi podanymi przez
	-- uzytkownika (miesiac (liczba 1-12), rok (4 cyfry)).
	-- Domyslnie prezentuje dane dla biezacego miesiaca.
    -- Przyklady parametrow: miesiac=6, rok=2018 lub miesiac=12 rok=2018 

	miesiac in sumy_darowizn_mview.miesiac%TYPE default EXTRACT(MONTH FROM SYSDATE),
	rok in sumy_darowizn_mview.rok%TYPE default EXTRACT(YEAR FROM SYSDATE)) as 
	dummy boolean;
	clause varchar2(500);
begin
	htp.htmlopen;
	htp.headopen;
	htp.title('Sumy wpłat');
	htp.style(cstyle=>'h5{margin-bottom:2px; margin-top:4px;} form{margin-bottom:20px;}');
	htp.headclose;
	htp.bodyopen;
	htp.header(1, 'Sumy wpłat dla podopiecznych dla miesiąca ' || TO_CHAR(miesiac, '00') || '.' || rok);
	htp.header(4, 'Tabela przedstawia sumy wpłat dla podopiecznych w miesiącu podanym w formularzu. <br />Domyślnie dla bieżącego miesiąca. Inne przyklady: 06.2018 lub 12.2018');

	htp.formopen(curl=>'',cmethod=>'GET');
	htp.header(5,'Miesiąc (MM)');
	htp.formtext(cname=>'miesiac', cvalue=>miesiac);
	htp.header(5,'Rok (YYYY)');
	htp.formtext(cname=>'rok',  cvalue=>rok);
	htp.p('<br />');
	htp.formsubmit(cvalue=>'Załaduj');
	htp.formreset();
	htp.formclose();

	clause := 'where rok =' || rok || 'and miesiac =' || miesiac || 'order by id_podopiecznego';

	dummy := owa_util.tableprint(
			ctable=>'sumy_darowizn_mview',
			cattributes=>'border=1',
			ccolumns=>'ID_PODOPIECZNEGO, IMIE, NAZWISKO, EMAIL, SUMA_DAROWIZN',
			ccol_aliases=>'ID, Imie, Nazwisko, Email, Suma darowizn (PLN)',
			cclauses=>clause
	);

	htp.bodyclose;
	htp.htmlclose;
end startWWW;