# Nibby Nibble — version Java native

[English version](README.md)

Version Java native du jeu Amiga **Nibby Nibble** (© 1993 Gabriele Roncolato). Elle a été réécrite en
Java pur à partir de ce que la décompilation du programme 68000 d'origine a appris sur le jeu
(voir la [version émulée](emu/README.fr.md) dans le dossier `emu/` de ce dépôt, qui
porte le code d'origine routine par routine au-dessus d'une petite émulation du chipset Amiga).

Ici, aucune émulation : ni 68000, ni copper, ni blitter, ni mémoire Amiga. Les graphismes, les niveaux
et la musique ont été **extraits** du fichier de données original en images PNG, fichiers texte et
module `.mod`, et le jeu est du code Java classique : trois calques (labyrinthe, sprites, corps du
serpent) composés dans une image de 320×262, une palette de 32 couleurs pour les fondus et les effets
de mort, et un lecteur de module autonome.

## Organisation du dépôt

| dossier | contenu |
|---|---|
| `/` (racine) | **version Java native** (ce README) : ressources extraites, jeu en Java classique |
| [`emu/`](emu/README.fr.md) | **portage Java émulé** : les routines 68000 d'origine traduites une à une au-dessus d'une petite émulation du chipset Amiga, le fichier de données original, les listings désassemblés et les outils d'analyse |
| `tools/` | extracteur de ressources (`extract_assets.py`) |

## Captures d'écran

| | |
|:---:|:---:|
| ![Titre](docs/screenshots/title.png) | ![Niveau 1](docs/screenshots/level1.png) |
| Écran titre | Niveau 1 |
| ![Niveau 2](docs/screenshots/level2.png) | ![Mort](docs/screenshots/death.png) |
| Niveau 2 | Mort : le corps brûle de la queue vers la tête |

## Fidèle à l'original

Le comportement a été vérifié contre la version émulée (qui exécute la logique d'origine) : avec les
mêmes entrées, les deux versions produisent des **images identiques au pixel près** — titre, cheat
code, jeu, points mangés, croissance, morsure, mort par chrono, animations de combustion, de rotation
et d'explosion, fondus de fin de niveau, saut de niveau, retour au titre — et le **même son**
(à ±1 unité d'arrondi près sur le mixage 16 bits).

Détails repris du code d'origine : pas de 2 pixels par image, virages uniquement sur une case, murs qui
arrêtent le serpent, croissance tous les 2 puis 1 points (91 segments au maximum), corps dessiné avec
une image de retard (triple tampon dans l'original), collision tête/corps au pixel près (seuls les
pixels du corps de couleur 3 comptent), chrono qui ne tue qu'en bougeant à 0, dégradés copper, barre
d'état rafraîchie par la routine musicale, bruitages qui remplacent temporairement la voie 2 de la
musique.

## Préservation et but éducatif

Ce projet a pour seul but la **préservation du patrimoine du jeu vidéo Amiga** et un **usage
éducatif**. Le jeu original, © 1993 Gabriele Roncolato, a été distribué en **domaine public** sur la
disquette du magazine *Amiga Dream* ; tout le mérite du jeu revient à son auteur. Les ressources de
`src/main/resources/assets/` ont été extraites sans modification des données du jeu original ; elles ne
sont pas couvertes par la licence MIT. Ce projet n'a aucune vocation commerciale ; si un ayant droit
souhaite son retrait, il suffit d'ouvrir une issue ou de contacter l'auteur.

Auteur de la version Java : Guillaume Monet (guillaume.monet@free.fr). Licence : [MIT](LICENSE) pour le
code, les outils et la documentation.

## Lancer

Pré-requis : JDK 21. Rien d'autre : les ressources sont incluses dans le jar.

```sh
gradle run
# ou
gradle jar
java -jar build/libs/nibbynibble.jar
```

Version Windows portable avec runtime embarqué : `gradle jpackageImage` (résultat dans
`build/dist/NibbyNibble`, lancer `NibbyNibble.exe`).

Options : `--scale N` (zoom de la fenêtre, 3 par défaut), `--lives` / `--time` (trainers vies / temps
illimités), `--headless TRAMES DOSSIER événements...` (exécution sans fenêtre, sauve des PNG et
`audio.wav` ; événements `trame:action` avec `fire|up|down|left|right|lmb|rmb|esc` suivis de `+`/`-`,
`key=X+`/`key=X-` (`_` pour espace) ou `shot`).

## Contrôles

| Action | Touches |
|---|---|
| diriger | flèches (ou pavé numérique 8/2/4/6) |
| feu (démarrer) | Shift, Ctrl ou Entrée |
| retour au titre | Échap |
| quitter | F10 ou fermer la fenêtre |
| passer le niveau (cheat d'origine) | clic droit + feu + clic gauche |

Cheat d'origine : taper `THE RONCLER GANG` sur l'écran titre → vies infinies (et chrono figé).

## Code

```
nibby/Main.java       fenêtre, clavier/souris, boucle 50 Hz cadencée par l'audio, mode headless
nibby/Game.java       le jeu : titre, niveaux, déplacement, croissance, collisions, fondus, mort, rendu
nibby/ModPlayer.java  lecteur de module 4 voies (le replay style NoiseTracker du jeu) + bruitages
nibby/Level.java      un labyrinthe chargé depuis levels/levelNN.txt + ses deux tuiles
nibby/Bitmap.java     image d'index de palette (dessin avec masque, effacement)
nibby/Assets.java     chargement des PNG indexés et des fichiers texte
nibby/Input.java      état des entrées
```

## Ressources

`tools/extract_assets.py` reconstruit `src/main/resources/assets/` à partir du fichier de données
original (Python 3 + Pillow) :

```sh
python tools/extract_assets.py emu/original-assets/Nibby src/main/resources/assets
```

| fichier | contenu |
|---|---|
| `title.png`, `statusbar.png`, `stage.png`, `gameover.png`, `digits.png` | écrans, barre d'état, bannières, chiffres 8×8 |
| `rainbow.txt` | la table de couleurs arc-en-ciel du copper |
| `levels/levelNN.txt` | nombre de points, temps, palette et carte 20×14 (`0` mur, `.` point) |
| `levels/levelNN_wall.png`, `levelNN_dot.png` | les tuiles 16×16 de chaque niveau |
| `sprites/head_*`, `tail*`, `signature.png` | tête (sprites attachés, 4 directions × 3 images), morceaux de queue, signature « GR » |
| `shapes/body_*`, `burn_*`, `explosion_*` | formes et masque du corps, images de combustion et d'explosion |
| `nib-rsi.mod` | la musique (module ProTracker ; les samples 16 « esplosione » et 17 « bopp » servent de bruitages) |

Les images sont des PNG indexés : le jeu utilise les index de palette et applique ses propres palettes
à l'exécution.
