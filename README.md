# FIFO Server - Inter-Process Communication

## Descriere
Proiectul implementeaza un model client-server folosind script-uri Bash si fisiere speciale de tip **FIFO** (named pipes) pentru comunicare. Serverul primeste cereri pentru pagini de manual (`man`) si trimite continutul acestora inapoi catre clienti prin canale dedicate.

## Functionalitati
* **Comunicare Sincronizata:** Utilizarea unui "well-known FIFO" pentru receptia cererilor.
* **Izolare Clienti:** Fiecare client primeste raspunsul intr-un FIFO personalizat bazat pe PID (Process ID).
* **Protocol Specific:** Cererile respecta sintaxa `BEGIN-REQ [client-pid: nume_comanda] END-REQ`.
* **Procesare Automata:** Serverul foloseste `awk` pentru parsarea mesajelor si `man` pentru extragerea informatiilor.

## Utilizare
1. **Configurare:** Seteaza calea pentru FIFO-ul principal in `config/server_config.cfg`.
2. **Pornire Server:** `./src/server.sh`.
3. **Trimitere Cerere (exemplu):** `echo "BEGIN-REQ [1234:ls] END-REQ" > /cale/catre/well_known_fifo`
4. **Citire Raspuns:** `cat /tmp/server-reply-1234`.

## Concepte Invatate
* Gestiunea proceselor in Linux.
* Lucrul cu fisiere speciale si redirectari.
* Automatizare prin script-uri Shell.
