# CometVisu Website

Diese Website wird mit [Hugo](https://gohugo.io/) generiert und über GitHub Pages ausgeliefert.

## Lokale Entwicklung

### Voraussetzungen

- [Hugo Extended](https://gohugo.io/installation/) (Version 0.120.0 oder höher)

#### Installation auf verschiedenen Systemen

**macOS (Homebrew):**
```bash
brew install hugo
```

**Linux (Debian/Ubuntu):**
```bash
# Snap
sudo snap install hugo --channel=extended

# Oder als Download von GitHub Releases
wget https://github.com/gohugoio/hugo/releases/download/v0.136.0/hugo_extended_0.136.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.136.0_linux-amd64.deb
```

**Windows (Chocolatey):**
```bash
choco install hugo-extended
```

### Lokale Vorschau starten

```bash
# Im website Verzeichnis
cd website

# Entwicklungsserver starten
hugo server -D

# Oder mit Live-Reload und Draft-Posts
hugo server -D --navigateToChanged
```

Die Website ist dann unter `http://localhost:1313/` erreichbar.

### Produktion-Build erstellen

```bash
hugo --gc --minify
```

Die generierten Dateien befinden sich im `public/` Verzeichnis.

## Projektstruktur

```
website/
├── .github/
│   └── workflows/
│       └── website.yml    # GitHub Actions für automatisches Deployment
├── content/
│   └── _index.md          # Startseite Inhalt
├── layouts/
│   ├── _default/
│   │   └── baseof.html    # Basis-Template
│   └── index.html         # Homepage Layout
├── static/
│   ├── css/
│   │   └── style.css      # Haupt-Stylesheet
│   ├── js/
│   │   └── main.js        # JavaScript
│   └── images/
│       └── logo.svg       # Logo und Bilder
├── hugo.toml              # Hugo Konfiguration
└── README.md              # Diese Datei
```

## Neuen Blogbeitrag veröffentlichen

Neue Beiträge liegen als Markdown-Dateien in `content/blog/`. So geht ihr vor:

### 1. Dateien anlegen

Legt pro Sprache eine Datei mit demselben Basisnamen an, damit Hugo sie als Übersetzungen verknüpft:

```
content/blog/mein-beitrag.md      # Englisch (Standardsprache)
content/blog/mein-beitrag.de.md   # Deutsch
```

### 2. Frontmatter ausfüllen

```yaml
---
title: "CometVisu 1.2.0 veröffentlicht"
date: 2026-08-15
description: "Ein kurzer Teaser-Text, der auf der Blog-Übersicht angezeigt wird."
category: "Release"
tags: ["release", "changelog"]
---
```

- `category` wird als kleines Badge auf dem Beitrag angezeigt (z.B. `Release`, `News`, `Guide`, `Tip`).
- `tags` werden am Ende des Beitragskopfs angezeigt und sind nützlich für eine spätere Filterfunktion.
- `date` bestimmt die Sortierung auf der Blog-Übersicht (neueste zuerst).

### 3. Inhalt schreiben

Alles unterhalb des Frontmatters ist normales Markdown – Überschriften, Listen, Codeblöcke, Links und Bilder funktionieren wie gewohnt.

### 4. Lokal testen

```bash
hugo server --port 1313 --bind 0.0.0.0
```

Öffnet anschließend `http://localhost:1313/blog/` (Englisch) bzw. `http://localhost:1313/de/blog/` (Deutsch), um das Ergebnis zu prüfen.

Fertig – nach dem Merge und Deployment erscheint der neue Beitrag automatisch oben in der Blog-Übersicht.

### English version

New posts live in `content/blog/` as Markdown files. Quick workflow:

1. **Create the files** – one file per language, sharing the same base filename so Hugo links them as translations:
   ```
   content/blog/my-post-slug.md      # English (default language)
   content/blog/my-post-slug.de.md   # German
   ```
2. **Add front matter** (see YAML example above). `category` is shown as a small badge on the post, `tags` at the bottom of the post header, and `date` controls the sort order on the blog overview page (newest first).
3. **Write the content** – everything below the front matter is regular Markdown.
4. **Preview locally** with `hugo server --port 1313 --bind 0.0.0.0`, then open `http://localhost:1313/blog/` (English) or `http://localhost:1313/de/blog/` (German).

Once merged and deployed, the new post automatically shows up at the top of the blog overview.

## Deployment

Die Website wird automatisch über GitHub Actions deployed, wenn Änderungen in den `website/` Ordner gepusht werden.

### Manuelles Deployment

1. Stelle sicher, dass GitHub Pages für das Repository aktiviert ist
2. Setze die Source auf "GitHub Actions"
3. Push Änderungen auf den `main` oder `develop` Branch

## Bilder hinzufügen

Für Screenshots der CometVisu:

1. Erstelle Screenshots im PNG-Format
2. Lege sie in `static/images/` ab
3. Referenziere sie im HTML mit `{{ "images/screenshot.png" | relURL }}`

### Empfohlene Screenshot-Einstellungen

- **Tile-Demo**: 1920x1080px, dunkles Theme
- **Pure-Demo**: 1920x1080px, verschiedene Designs
- **Widgets**: 400x300px, einzelne Widget-Beispiele

## Anpassungen

### Farben ändern

Die Hauptfarben sind in `static/css/style.css` als CSS-Variablen definiert:

```css
:root {
    --primary: #4ecdc4;
    --secondary: #667eea;
    --accent: #f093fb;
    /* ... */
}
```

### Inhalte bearbeiten

Die Hauptseite ist in `layouts/index.html` definiert. Textänderungen können direkt dort vorgenommen werden.

Für mehrsprachige Inhalte nutze die Sprachkonfiguration in `hugo.toml`.

## Lizenz

Die Website-Inhalte unterliegen der gleichen Lizenz wie das CometVisu-Projekt (GPL-3.0).
