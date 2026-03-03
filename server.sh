#!/bin/bash

config_file="server_config.cfg"
# fisierul cofnigurabil in care se afla PATH-ul serverului fifo

server_fifo=$(cat "$config_file")
# se citeste continutul fisierului de configurare si se salveaza in variabila

while true; do
# se deschide o bucla infinita, ca serverul sa ruleze si 
# sa primeasca cereri in permanenta

if read cerere < $server_fifo; then
# se citeste cererea din FIFO-ul serverului

    echo "Serverul a primit cererea: $cerere"
    # se afiseaza mesajul de confirmare a primirii cererii

    pid=$(echo "$cerere" | awk -F'[][]|:' '{print $2}')
    comanda=$(echo "$cerere" | awk -F'[][]|:' '{print $3}')
    # se extrag PID ul si comanda clientului folosind
    # comanda awk si delimitatorii [ , ] si :
    # {print $2} si {print $3} selecteaza campurile 2, respectiv 3 
    # din textul delimitat

    client_fifo="/home/mara/server-client-$pid"
    if [[ ! -p $client_fifo ]]; then
        mkfifo $client_fifo
    fi
    # se construieste numele FIFO-ului clientului folosind PID-ul sau
    # daca fisierul nu exista, este creat

    man_output=$(man "$comanda" 2>/dev/null || echo "Eroare: Nu exista pagina de manual pentru $comanda")
    # se ruleaza comanda "man" pe comanda data de client, 
    # pentru a obtine pagina de manual dorita
    # 2>/dev/null redirectioneaza erorile catre /dev/null (sunt ignorate)
    # sau afiseaza mesajul de eroare pentru comenzi introduse gresit

    echo "$man_output" > $client_fifo
    # pagina de manual este scrisa in FIFO-ul clientului

    echo "Raspuns trimis clientului $pid in FIFO-ul $client_fifo"
    # se afiseaza mesajul de confirmare a trimiterii raspunsului
fi

rm $client_fifo
# se sterge FIFO-ul clientului dupa primirea raspunsului

done




