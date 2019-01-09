create or replace procedure uzytkownicy(wzorzec in varchar2 default NULL) as 
	dummy boolean;
	clause varchar2(1000);
begin
	htp.htmlopen;
	htp.headopen;
	htp.title(’Użytkownicy bazy danych’);
	htp.headclose;
	htp.bodyopen;
	htp.header(1, ’Użytkownicy bazy danych’);

	-- Dodatkowa klauzula ustala selekcję i sortowanie,
	-- funkcji upper użyto, gdyż nazwy w słowniku danych są zapisywane dużymi literami
	clause := ’where username like upper(’’%’ || wzorzec || ’%’’) order by username’;
	
	-- Procedura tableprint wyprowadza zawartość tabeli/perspektywy w postaci tabeli HTML
	dummy := owa_util.tableprint(ctable=>’all_users’, cclauses=>clause);

	htp.bodyclose;
	htp.htmlclose;
end uzytkownicy;