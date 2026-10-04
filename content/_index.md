---
title: "CometVisu - Smarthome Visualization"

features:
  sectionTitle: "The Modern Tile Structure"
  sectionSubtitle: "Responsive tile design with Web Components – perfect for touch operation on tablets and smartphones"
  items:
    - icon: grid
      title: "Tile-based Layout"
      text: "Organize tiles on pages or within groups. Fully responsive – adapts automatically to any screen size."
    - icon: touch
      title: "Touch-optimized"
      text: "Designed perfectly for operation on wall panels, tablets and smartphones."
    - icon: design
      title: "Modern Design"
      text: "Dark theme with soft gradients and animated transitions for an elegant appearance."
    - icon: components
      title: "Web Components"
      text: "Native Custom Elements like <code>&lt;cv-switch&gt;</code> for maximum extensibility."

customization:
  sectionTitle: "Unlimited Customization Options"
  sectionSubtitle: "From simple CSS adjustments to your own config structure – CometVisu grows with your requirements"
  levels:
    - number: 1
      title: "Use Existing Designs"
      text: "Choose from various included designs"
      kind: design
      designGroups:
        - label: "Tile Structure:"
          chips:
            - name: "Tile"
              color: "#ff8000"
        - label: "Pure Structure:"
          chips:
            - name: "Pure"
              color: "#ffb347"
            - name: "Metal"
              color: "#808080"
    - number: 2
      title: "Change Color Scheme"
      text: "Customize the entire appearance with just a few CSS variables"
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
      text: "Custom styles for individual adjustments without code changes"
      kind: code
      code: |
        .cv-switch.myCustomStyle {
          border-radius: 20px;
          box-shadow: 0 4px 15px rgba(0,0,0,0.3);
        }
    - number: 4
      title: "Custom Widgets & Plugins"
      text: "Develop custom widgets for special requirements"
      kind: list
      items:
        - "Plugin system for external libraries"
        - "Lazy-loading for optimal performance"
        - "Qooxdoo Framework for OOP development"
    - number: 5
      title: "Custom Config Structure"
      text: "For maximum flexibility: Develop your own structure like the Tile structure"
      kind: list
      featured: true
      items:
        - "Custom XML schema definition"
        - "Custom parsers and controllers"
        - "Completely standalone visualization"

backends:
  sectionTitle: "Compatible with Your System"
  sectionSubtitle: "CometVisu connects with various smarthome backends – even multiple ones simultaneously"
  items:
    - logo: "KNX"
      title: "KNX / knxd"
      text: "Direct communication with the KNX bus via knxd/eibd"
    - logo: "OH"
      title: "openHAB"
      text: "REST API integration with openHAB"
    - logo: "MQTT"
      title: "MQTT"
      text: "Universal MQTT connection for IoT devices"
---
