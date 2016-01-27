Änderungen mit Firmwareversion 0.8.1 basierend auf Gluon 2016.1
================================================================

Alle Neuerungen der an Gluon können hier eingesehen werden: https://gluon.readthedocs.org/en/latest/releases/v2016.1.html#new-features

Freifunk Nord spezifische Änderungen:
-------------------------------------

 * site.conf wurde an das neue Layout für Gluon 2016.1 angepasst
 * http://openwrt.draic.info wurde als OPKG Repository hinzugefügt. Damit ist opkg auf den Nodes nutzbar
 * Neue NTP Server
 * vorhandene Server sind nun erreichbar
 * Next-node IP Fehler beseitigt. Der Node ist nun einheitlich unter IPv4 = '10.187.254.254' oder IPv6 = '2a03:2267:4e6f:7264::ffff' erreichbar.
 * Alle Nodes bauen nun noch Verbindung zu einem Gateway auf. Das reduziert das Hintergrundrauschen um 50%.
 * VPN1 - fastd Key aktualisiert.
 * URLs für die Autoupdateserver hinterlegt.
 * Autoupdate Server (VPN0) ist nun auch via IPv4 erreichbar.
 * Firmware Signatur von Tarnatos hinzugefügt.
 * Firmware Signatur von rubo77 hinzugefügt.
 * Freifunk Router mit ausreichend Flash und USB haben nun eine aktive USB Unterstützung.
 * Angepasste Firmware für den Futro S550 wird nun auf den Updateservern bereitgestellt.

Generelle Änderungen an Gluon 2016.1
------------------------------------

 * Update auf OpenWRT 15.05 "Chaos Clamer"
 * Die Router-Statusseite unter http://[2a03:2267:4e6f:7264::ffff] wurde komplett überarbeitet und zeigt nun umfangreiche Statistiken an
 * ICMP und ICMPv6 Echo Requests (ping) und Node Information Queries werden nun nicht mehr per Multicast an alle Nodes verteilt. Das reduziert die Netzlast.
 * (die Config Seite ist nun auch auf französisch abrufbar) - in FFNord nicht implementiert.
 * Die Kanalbreite im 2,4Ghz Band wurde auf 20Mhz begrenzt. Dadurch werden andere 2,4Ghz Netz weniger stark beeinflusst.
 * (das AdHoc MESH arbeitet nun auch nach dem 802.11s Standard. Noch in Entwicklung) - in FFNord nicht implementiert.
 * Wechsel von gluon-cron zu micrond.

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
Die x86 64Bit Architektur wird jetzt unterstützt. Dieses Image kann ebenfalls für KVM mit WirtIO genutzt werden.
