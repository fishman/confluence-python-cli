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
  ./confluence.py -w http://localhost:8090 -u $USER -p $PASS addpage -n "$2" -s $SPACEKEY -P $DOKUMENTEID
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


# DOKUMENTEID=$(./confluence.py -w http://localhost:8090 -u $USER -p $PASS listpages | grep "00 Dokumente" | head -n 1 | cut -d, -f 1)
# ./confluence.py -w http://localhost:8090 -u $USER -p $PASS addpage -n '00 Verfahren zur Lenkung von Dokumenten und Aufzeichnungen' -s $SPACEKEY -P $DOKUMENTEID
# ./confluence.py -w http://localhost:8090 -u $USER -p $PASS updatepage -n '00 Verfahren zur Lenkung von Dokumenten und Aufzeichnungen' -s $SPACEKEY -P $DOKUMENTEID -f templates/pagedefaultcontent.txt -l dokumentation
# ./confluence.py -w http://localhost:8090 -u $USER -p $PASS addpage -n '01 Projektplan' -s $SPACEKEY -P $DOKUMENTEID


createmetadatapage "01 Anhang" "anhang"
# DOKUMENTEID=$(./confluence.py -w http://localhost:8090 -u $USER -p $PASS listpages | grep "01 Anhang" | head -n 1 | cut -d, -f 1)
# LABEL=anhang
# sed -e "s/%LABEL%/$LABEL/" -e "s/%PAGEID%/$DOKUMENTEID/" templates/pagemetadataoverview.txt > tmp/pagemetadataoverview.txt
# ./confluence.py -w http://localhost:8090 -u $USER -p $PASS updatepage -n '01 Anhang' -s $SPACEKEY -P $PARENTPAGE -f tmp/pagemetadataoverview.txt -l dokumentation
