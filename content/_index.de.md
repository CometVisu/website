---
title: "CometVisu - Smarthome Visualisierung"

features:
  sectionTitle: "Die moderne Tile-Struktur"
  sectionSubtitle: "Responsives Kacheldesign mit Web Components – perfekt für Touch-Bedienung auf Tablets und Smartphones"
  items:
    - icon: grid
      title: "Kachelbasiertes Layout"
      text: "Ordne Kacheln auf Seiten oder in Gruppen an. Vollständig responsiv – passt sich automatisch jeder Bildschirmgröße an."
    - icon: touch
      title: "Touch-optimiert"
      text: "Perfekt für die Bedienung auf Wandpanels, Tablets und Smartphones konzipiert."
    - icon: design
      title: "Modernes Design"
      text: "Dunkles Theme mit sanften Farbverläufen und animierten Übergängen für ein edles Erscheinungsbild."
    - icon: components
      title: "Web Components"
      text: "Native Custom Elements wie <code>&lt;cv-switch&gt;</code> für maximale Erweiterbarkeit."

customization:
  sectionTitle: "Unbegrenzte Anpassungsmöglichkeiten"
  sectionSubtitle: "Von einfachen CSS-Anpassungen bis hin zur eigenen Config-Struktur – CometVisu wächst mit deinen Anforderungen"
  levels:
    - number: 1
      title: "Vorhandene Designs nutzen"
      text: "Wähle aus verschiedenen mitgelieferten Designs"
      kind: design
      designGroups:
        - label: "Tile-Struktur:"
          chips:
            - name: "Tile"
              color: "#ff8000"
        - label: "Pure-Struktur:"
          chips:
            - name: "Pure"
              color: "#ffb347"
            - name: "Metal"
              color: "#808080"
    - number: 2
      title: "Farbschema ändern"
      text: "Mit wenigen CSS-Variablen das komplette Erscheinungsbild anpassen"
      kind: code
      code: |
        :root {
          --primaryColor: #ff9900;
          --appBackground: #515151;
          --tileBackground: #2e2e2e;
          --primaryText: #b6b6b6;
        }
    - number: 3
      title: "Custom CSS"
      text: "Eigene Styles für individuelle Anpassungen ohne Code-Änderungen"
      kind: code
      code: |
        .cv-switch.myCustomStyle {
          border-radius: 20px;
          box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }
    - number: 4
      title: "Eigene Widgets & Plugins"
      text: "Entwickle eigene Widgets für spezielle Anforderungen"
      kind: list
      items:
        - "Plugin-System für externe Bibliotheken"
        - "Lazy-Loading für optimale Performance"
        - "Qooxdoo Framework für OOP-Entwicklung"
    - number: 5
      title: "Eigene Config-Struktur"
      text: "Für maximale Flexibilität: Entwickle deine eigene Struktur wie die Tile-Struktur"
      kind: list
      featured: true
      items:
        - "Eigene XML-Schema-Definition"
        - "Eigene Parser und Controller"
        - "Vollständig eigenständige Visualisierung"

backends:
  sectionTitle: "Kompatibel mit deinem System"
  sectionSubtitle: "CometVisu verbindet sich mit verschiedenen Smarthome-Backends – auch gleichzeitig mit mehreren"
  items:
    - logo: "KNX"
      title: "KNX / knxd"
      text: "Direkte Kommunikation mit dem KNX-Bus über knxd/eibd"
    - logo: "OH"
      title: "openHAB"
      text: "REST-API Integration mit openHAB"
    - logo: "MQTT"
      title: "MQTT"
      text: "Universelle MQTT-Anbindung für IoT-Geräte"
---
