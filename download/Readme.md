Downloader erstellen
====================

mit folgenden Befehlen kann man in iesem Download-ordner eine Firmware Download Seite erstellen:

    cd ..
    unp site.tgz
    mv builds/ffki/ffki-site/ site
    rm -Rf builds/ffki/
    cd site/download/
    vi upgrade-downloadpage.sh
    # update the version
    ./upgrade-downloadpage.sh
