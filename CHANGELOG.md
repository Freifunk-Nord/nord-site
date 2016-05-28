Änderungen mit Firmwareversion 0.16.5 basierend auf Gluon 2016.1.5
================================================================

Freifunk Nord spezifische Änderungen:
-------------------------------------

 * Es wurde ein neuer Autoupdaterbranch "early bird" eingeführt. Dieser kann genutzt werden, um Firmwareupdates direkt nach dem erscheinen automatisch zu beziehen. Im early Branch werden untested experimental Firmware Versionen ausgeliefert. Wer diesen nutzt, sollte sich daher im klaren sein, dass ggf. Probleme auftreten können.
 * Es wurde ein neuer Autoupdaterbranch "ownbuild" eingeführt. Dieser kann genutzt werden, wenn ein Node Updates in eigener Zuständigkeit erhalten soll. Somit ist für Administratoren ersichtlich, dass ein Node über eine selbst erstellte Firmware verfügt. Dies ist gerade dann wichtig zu wissen, wenn der Erfolg/Misserfolg eines Rollouts bewerten werden soll.
 * das Gluon Paket fastd-traffic-status wurde eingefügt, um Traffic Statistiken in Grafana auszuwerten.

Generelle Änderungen an Gluon 2016.1.5
--------------------------------------
 * Es wurde ein Fehler behoben, der zu Problemen beim nacheinander kompilieren mehrerer Gluon Targets führte.
 * Es wurde ein Fehler behoben, der zu Problemen beim kompilieren von Gluon zu der Fehlermeldung "recursive dependency" führte.
 * Gluon kann nun mit GCC6 kompiliert werden.
 * Es wurde ein Fehler behoben, welcher batman-adv daran hinderte korrekt mit VLANs zu funktionieren.
 * Ein Fehler in Gluon 2016.1.4 verhinderte die Funktion von auf ath10k Chipsätzen basierenden Endgeräten. Dieser wurde behoben. 
 * Gluon kann nun auf allen unterstützten Ubiquiti Geräten installiert werden, ohne zuvor auf AirOS 5.5 downzugraden.
 * Leerzeichen werden nun automatisch aus der Geolokalisierung entfernt und die Kompatiblität zu respondd damit verbessert.
 
Mehr Routermodelle werden unterstützt
-------------------------------------

    ar71xx-generic
        OpenMesh MR600 (v1, v2), MR900 (v1, v2), OM2P (v1, v2), OM2P-HS (v1, v2), OM2P-LC, OM5P, OM5P-AN
        Ubiquiti Rocket M XW
        TP-Link WR841N/ND (v11)
        
 Offizielle Changelogs zum nachlesen:
------------------------------------

* https://gluon.readthedocs.org/en/v2016.1.5/releases/v2016.1.5.html

Generelle Änderungen an Gluon 2016.1.4
--------------------------------------
 * Der WLAN Treiber aller unterstützen Router wurde auf eine neuere Version aktualisiert. Dadurch wurde die Stabilität bei vielen Routern verbessert
 * Es wurde ein Fehler behoben der zu Problemen beim kompilieren von Gluon mit der Option -jx führte
 * Der Fehler “Too many levels of symbolic links” der bei kompilieren von Gluon auftrat ist nun behoben
 * Weitere Optimierungen beim kompilieren von Gluon

Mehr Routermodelle werden unterstützt
-------------------------------------

    ar71xx-generic
        8devices Carambola 2
        Meraki MR12/MR62/MR16/MR66


Offizielle Changelogs zum nachlesen:
------------------------------------

* https://gluon.readthedocs.org/en/v2016.1.4/releases/v2016.1.4.html



Änderungen mit Firmwareversion 0.16.3 basierend auf Gluon 2016.1.3
================================================================

Freifunk Nord spezifische Änderungen:
-------------------------------------

 * site.conf wurde an das neue Layout für Gluon 2016.1 angepasst
 * Ein OPKG Repository wurde auf Gateway 2 angelegt. Damit ist opkg auf den Nodes nutzbar
 * Neue NTP Server
 * vorhandene Server sind nun erreichbar
 * Next-node IP Fehler beseitigt. Der Node ist nun einheitlich unter IPv4 = '10.187.254.254' oder IPv6 = '2a03:2267:4e6f:7264::ffff' erreichbar.
 * Alle Nodes bauen nun noch Verbindung zu einem Gateway auf. Das reduziert das Hintergrundrauschen um 50%.
 * VPN1 - fastd Key aktualisiert.
 * damit ist Gateway 1 nun für alle nutzbar
 * URLs für die Autoupdateserver hinterlegt.
 * Autoupdate Server (VPN0) ist nun auch via IPv4 erreichbar.
 * Firmware Signatur von Tarnatos hinzugefügt.
 * Firmware Signatur von rubo77 hinzugefügt.
 * Freifunk Router mit ausreichend Flash und USB haben nun eine aktive USB Unterstützung.
 * Slots für insg. 15 mögliche Gateways eingefügt
 * Autoupdate Branch wird durch dieses Firmware Update auf "stable" geändert.

Generelle Änderungen an Gluon 2016.1.3
--------------------------------------
* Der Fehler der in Version 2016.1.2 wahrlos defekte Images erzeugte, ist nun behoben.
* Sysupgradeprozess bei XEN Images repariert.
* Gluon kann nun auf Systemen gebaut werden, die LibreSSL statt OpenSSL verwenden

Mehr Routermodelle werden unterstützt
-------------------------------------

    Alfa
        Hornet UB / AP121 / AP121U
    TP-Link
        TL-WA7510N

Generelle Änderungen an Gluon 2016.1.2
--------------------------------------

 * Update auf OpenWRT 15.05 "Chaos Clamer"
 * Die Router-Statusseite unter http://[2a03:2267:4e6f:7264::ffff] wurde komplett überarbeitet und zeigt nun umfangreiche Statistiken an
 * ICMP und ICMPv6 Echo Requests (ping) und Node Information Queries werden nun nicht mehr per Multicast an alle Nodes verteilt. Das reduziert die Netzlast.
 * (die Config Seite ist nun auch auf französisch abrufbar) - in FFNord nicht implementiert.
 * Die Kanalbreite im 2,4Ghz Band wurde auf 20Mhz begrenzt. Dadurch werden andere 2,4Ghz Netz weniger stark beeinflusst.
 * (das AdHoc MESH arbeitet nun auch nach dem 802.11s Standard. Noch in Entwicklung) - in FFNord nicht implementiert.
 * Wechsel von gluon-cron zu micrond.
 * Verbesserter Ubiquiti Support. Ubiquiti Geräte mit Firmwareversion 5.6 oder höher brauchen nun nicht mehr auf 5.5 downgegraded werden. Die Freifunkfirmware kann direkt mit der "factory" Version aufgespielt werden ohne das Gerät zu bricken.

Mehr Routermodelle werden unterstützt
-------------------------------------

    Buffalo
        WZR-HP-G300NH
    D-Link
        DIR-505 (A1)
    TP-Link
        CPE210/220/510/520 v1.1
        TL-WA901N/ND v1
        TL-WR710N v2
        TL-WR801N/ND v1, v2
        TL-WR841N/ND v10
        TL-WR940N v1, v2, v3
        TL-WR941ND v6
        TL-WR1043N/ND v3
        TL-MR13U v1
    
    Onion
        Omega

    Ubiquiti
        airGateway
        airRouter
        UniFi AP Outdoor+

    Western Digital
        My Net N600
        My Net N750

 * x86-xen_domu
Ein Image für XEN Virtualisierung wird nun standardmäßig mit ausgeworfen.

 * x86-64
Die x86 64Bit Architektur wird jetzt unterstützt. Dieses Image kann ebenfalls für KVM mit VirtIO genutzt werden.

Offizielle Changelogs zum nachlesen:
------------------------------------

* https://gluon.readthedocs.org/en/v2016.1/releases/v2016.1.html
* https://gluon.readthedocs.org/en/v2016.1.1/releases/v2016.1.1.html
* https://gluon.readthedocs.org/en/v2016.1.2/releases/v2016.1.2.html
* https://gluon.readthedocs.org/en/v2016.1.3/releases/v2016.1.3.html
* https://gluon.readthedocs.org/en/v2016.1.4/releases/v2016.1.4.html
* https://gluon.readthedocs.org/en/v2016.1.5/releases/v2016.1.5.html
