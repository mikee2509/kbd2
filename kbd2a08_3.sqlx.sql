SELECT XMLElement( 
    "konta", 
    XMLAgg(XMLElement(
        "konto", 
        XMLAttributes(id_konta AS "id"), 
        XMLElement("numer", nr_konta), 
        XMLElement(
            "podopieczni", 
            (
                SELECT XMLAgg(XMLElement("podopieczny", XMLAttributes(id_podop AS "id"), imie||' '||nazwisko) ORDER BY id_podop)
                FROM podopieczni p
                WHERE p.id_konta=k.id_konta 
            )
        )
    ) ORDER BY id_konta )
).getClobVal()
FROM konta k
WHERE k.typ_wlasciciela = 'F';
