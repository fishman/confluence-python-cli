#!/bin/bash

USER=admin
PASS=12345678
SPACEKEY=ISMS
PARENTPAGE=$(./confluence.py -w http://localhost:8090 -u $USER -p $PASS listpages | grep $SPACEKEY | head -n 1 | cut -d, -f 1)

createmainpage() {
  ./confluence.py -w http://localhost:8090 -u $USER -p $PASS addpage -n '00 Dokumente' -s $SPACEKEY -P $PARENTPAGE
  ./confluence.py -w http://localhost:8090 -u $USER -p $PASS addpage -n '01 Anhang' -s $SPACEKEY -P $PARENTPAGE
}

createmetadatapage() {
  LABEL=$2
  sed -e "s/%LABEL%/$LABEL/" -e "s/%PAGEID%/$PARENTPAGE/" templates/pagemetadataoverview.txt > tmp/pagemetadataoverview.txt
  ./confluence.py -w http://localhost:8090 -u $USER -p $PASS updatepage -n "$1" -s $SPACEKEY -P $PARENTPAGE -f tmp/pagemetadataoverview.txt -l $LABEL
}

createdocument() {
  DOKUMENTEID=$(./confluence.py -w http://localhost:8090 -u $USER -p $PASS listpages | grep "$1" | head -n 1 | cut -d, -f 1)
  LABEL=$3
  ./confluence.py -w http://localhost:8090 -u $USER -p $PASS addpage -n "$2" -s $SPACEKEY -P $DOKUMENTEID -f templates/pagedefaultcontent.txt
  ./confluence.py -w http://localhost:8090 -u $USER -p $PASS updatepage -n "$2" -s $SPACEKEY -P $DOKUMENTEID -f templates/pagedefaultcontent.txt -l "$LABEL"
}

createmainpage
createmetadatapage "00 Dokumente" "dokumentation"
createdocument "00 Dokumente" "00 Verfahren zur Lenkung von Dokumenten und Aufzeichnungen" "dokumentation"
createdocument "00 Dokumente" "01 Projektplan" "dokumentation"
createdocument "00 Dokumente" "02 Verfahren zur Identifikation der Anforderungen" "dokumentation"
createdocument "00 Dokumente" "03 Dokument zum ISMS Anwendungsbereich" "dokumentation"
createdocument "00 Dokumente" "04 Informationssicherheitsrichtlinie" "dokumentation"
createdocument "00 Dokumente" "05 Methodik Risikoeinschaetzung und Risikobehandlung" "dokumentation"
createdocument "00 Dokumente" "06 Erklaerung zur Anwendbarkeit" "dokumentation"
createdocument "00 Dokumente" "07 Plan zur Risikobehandlung" "dokumentation"
createdocument "00 Dokumente" "09 Plan fuer Training und Awareness" "dokumentation"
createdocument "00 Dokumente" "10 Verfahren fuer interne Audits" "dokumentation"
createdocument "00 Dokumente" "11 Protokoll zur Management Bewertung" "dokumentation"
createdocument "00 Dokumente" "12 Verfahren zu Korrekturmassnahmen" "dokumentation"


createmetadatapage "01 Anhang" "anhang"
createdocument "01 Anhang" "06 Organisation der Informationssicherheit" "anhang"
createdocument "01 Anhang" "07 Personelle Sicherheit" "anhang"
createdocument "01 Anhang" "08 Management von Werten" "anhang"
createdocument "01 Anhang" "09 Zugangskontrolle" "anhang"
createdocument "01 Anhang" "10 Kryptographie" "anhang"
createdocument "01 Anhang" "11 Sicherheit von Koerper und Umfeld" "anhang"
createdocument "01 Anhang" "12 Betriebssicherheit" "anhang"
createdocument "01 Anhang" "13 Kommunikationssicherheit" "anhang"
createdocument "01 Anhang" "14 Systembeschaffung Entwicklung und" "anhang"
createdocument "01 Anhang" "15 Beziehungen zu Lieferanten" "anhang"
createdocument "01 Anhang" "16 Informationssicherheits Vorfallmanagement" "anhang"
createdocument "01 Anhang" "17 a Sicherstellung des Geschaeftsbetriebs Richtlinie" "anhang"
createdocument "01 Anhang" "17 b Sicherstellung des Geschaeftsbetriebs Geschaeftsauswirkungsanalyse" "anhang"
createdocument "01 Anhang" "17 c Sicherstellung des Geschaeftsbetriebs Strategie" "anhang"
createdocument "01 Anhang" "17 d Sicherstellung des Geschaeftsbetriebs Plan" "anhang"
createdocument "01 Anhang" "17 e Sicherstellung des Geschaeftsbetriebs Weiteres" "anhang"
