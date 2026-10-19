# Nibby Nibble — portage Java

Portage en Java du jeu Amiga **Nibby Nibble** (© 1993 Gabriele Roncolato, publié par Amiga News),
obtenu en décompilant le programme 68000 d'origine (`../nibbynibble/data/Nibby`, installation WHDLoad).

## Préservation et but éducatif

Ce projet a pour seul but la **préservation du patrimoine du jeu vidéo Amiga** et un **usage éducatif** :
documenter le fonctionnement interne d'un jeu de 1993 (code 68000, copper, blitter, sprites matériels,
Paula), montrer une démarche de rétro-ingénierie complète et garder ce jeu jouable sur les machines
actuelles, sans émulateur.

- Le jeu original reste la propriété de son auteur, Gabriele Roncolato, et de ses ayants droit.
  Toutes les marques et tous les droits leur appartiennent.
- **Aucune donnée du jeu n'est distribuée dans ce dépôt** (ni graphismes, ni musique, ni niveaux, ni
  exécutable). Le portage lit le fichier `data/Nibby` d'une installation WHDLoad que l'utilisateur
  doit posséder.
- Ce projet n'a aucune vocation commerciale. Si un ayant droit souhaite son retrait, il suffit d'ouvrir
  une issue ou de contacter l'auteur : il sera retiré sans délai.

Auteur du portage : Guillaume Monet (guillaume.monet@free.fr).

## Le portage

Le jeu n'est **pas** réécrit « à peu près » : chaque routine du programme 68000 a été traduite en
méthode Java (l'adresse d'origine est indiquée en commentaire). Les ressources (graphismes, copper lists,
niveaux, module musical) sont lues directement depuis le fichier de données original. Aucun
asset n'est dupliqué dans le projet.

## Lancer

Pré-requis : JDK 21.

```sh
gradle jar
java -jar build/libs/nibbynibble.jar ../nibbynibble/data/Nibby
# ou
gradle run
```

Options :

| option            | effet                                                          |
|-------------------|----------------------------------------------------------------|
| `--scale N`       | facteur de zoom de la fenêtre (3 par défaut)                   |
| `--lives`         | trainer « Unlimited Lives » de l'install WHDLoad               |
| `--time`          | trainer « Unlimited Time »                                     |
| `--headless N DIR evt...` | exécute N trames sans fenêtre, sauve des PNG et `audio.wav` (tests) |

Exemple headless : `--headless 700 out 100:fire+ 110:fire- 200:fire+ 205:fire- 320:right+ 400:shot`
(événements `frame:action`, actions `fire|up|down|left|right|lmb|rmb` suivies de `+`/`-`,
un code clavier Amiga en hexa, ou `shot`).

## Contrôles

| Amiga                      | PC                                  |
|----------------------------|-------------------------------------|
| joystick                   | flèches (ou pavé numérique 8/2/4/6) |
| bouton feu                 | Shift, Ctrl ou Entrée               |
| ESC (retour au titre)      | Échap                               |
| quitter (F10 sous WHDLoad) | F10 ou fermer la fenêtre            |
| clic droit + feu + clic gauche | idem à la souris : passe le niveau (cheat d'origine) |

Cheat d'origine : taper `THE RONCLER GANG` sur l'écran titre → vies infinies (et chrono figé).

## Règles (déduites du code)

- Labyrinthe de 20×14 cases de 16×16 ; 10 niveaux qui bouclent (le niveau 11 redevient le 1).
- Il faut manger tous les points avant la fin du chrono. Chaque point vaut 1 (affiché ×10).
- Le serpent grandit d'un segment tous les 2 puis 1 point en alternance (91 segments maximum).
- Un mur ne tue pas : le serpent s'arrête. On ne peut tourner qu'à angle droit, sur une case.
- On meurt en se mordant (collision matérielle sprite de la tête / playfield du corps),
  ou en bougeant alors que le chrono est à 0. On recommence alors le niveau (les points reviennent,
  le score est conservé). 3 vies supplémentaires au départ.

## Architecture

```
nibby/Main.java              lanceur, fenêtre Swing, boucle 50 Hz cadencée par l'audio, mode headless
nibby/amiga/Rnc.java         décompresseur Rob Northen ProPack (méthode 1) — data/Nibby est compressé
nibby/amiga/Memory.java      512 Ko de chip RAM ; l'image du programme est chargée à $30000
nibby/amiga/Custom.java      registres $DFFxxx (écrits par le jeu et par le copper)
nibby/amiga/Video.java       copper + bitplanes (dual playfield) + sprites (attachés) + CLXDAT → framebuffer 320×264
nibby/amiga/Blitter.java     blitter (canaux A/B/C/D, décalages, masques, minterms)
nibby/amiga/Paula.java       4 voies audio DMA avec le comportement de « latch » des registres
nibby/amiga/Machine.java     synchronisation : le programme 68000 porté tourne dans son thread
                             et attend la VBL comme l'original attendait le faisceau
nibby/game/NibbyNibble.java  le jeu : titre, niveaux, déplacement, croissance, mort, fondus, HUD
nibby/game/Replay.java       la routine musicale d'origine (style NoiseTracker) + bruitages sur la voie 2
```

Plutôt que de redessiner l'écran avec des primitives Java2D, le portage garde le modèle d'affichage
de l'original : le jeu écrit dans les copper lists, dans les mots de contrôle des sprites et fait
dessiner le corps par le blitter via une copper list générée à chaque trame. Une petite émulation du
chipset (copper ligne par ligne, blitter, sprites, détection de collision) suffit alors à rendre
fidèlement les dégradés copper, le double playfield et les collisions pixel à pixel dont dépend
la règle « se mordre la queue ».

## Analyse du binaire d'origine

### Chargement (`NibbyNibble.slave`, voir `reverse/listings/whdload_slave.s`)

Le slave WHDLoad charge `data/Nibby` décompressé (RNC) à `$30000`, applique des patchs
(attente blitter, clavier : flèches + Shift droit, interruptions) puis saute à `$30000`.
Trainers : NOP de `subi #1,$31896` (vies) et de `subi #1,$31898` (temps).

### Carte mémoire (image de 256 Ko chargée à `$30000`)

| adresse           | contenu                                                                    |
|-------------------|----------------------------------------------------------------------------|
| `$30000-$31818`   | code du jeu                                                                |
| `$3181A`          | interruption clavier (code brut → `$3188A`)                                |
| `$31878`          | séquence du cheat (`THE RONCLER GANG`, codes clavier bruts)               |
| `$3188A-$31912`   | variables (voir les champs de `NibbyNibble`)                               |
| `$31956`          | copper list du jeu (dual playfield 3+2 plans, sprites, palette)            |
| `$31A76`          | copper list de la mort                                                     |
| `$31BFA` / `$31C66` | écrans « STAGE nn » / « GAME OVER »                                      |
| `$31CD2`          | copper list de la barre d'état                                             |
| `$31D6E`          | copper list du titre (180 lignes de dégradé sur COLOR14)                   |
| `$323D2`          | table de couleurs arc-en-ciel                                              |
| `$32484-$33304`   | sprites de la tête (4 directions × 3 images, paires attachées), sprites de queue |
| `$32FC4-$33784`   | formes du corps (32×16, 2 plans), masque, images d'explosion               |
| `$33B04`          | tuile vide ; `$33B64` copie de travail du niveau                           |
| `$33C7C-$34B90`   | 10 niveaux : descripteur {carte, tuile mur, tuile point, palette}, carte = nb points, temps, 20×14 caractères (`0` mur, `.` point) |
| `$34CBC/$34DFC/$35214` | tables décalage/offset X et offset Y pour le blitter                  |
| `$35194`          | police de chiffres 8×8                                                     |
| `$35418-$366D8`   | historique circulaire des positions (600 entrées, doublé pour la lecture)  |
| `$366D8-$36F66`   | replay musical + interruptions CIA                                         |
| `$38000`          | image du titre (4 plans 320×200)                                           |
| `$40000`          | module ProTracker « nib-rsi » (sample 16 « esplosione », 17 « bopp »)      |
| `$57800`          | barre d'état (3 plans 320×37)                                              |
| `$5E000/$5F000`   | copper lists de blit du corps (double tampon, générées)                    |
| `$60000/$65000/$6A000` | 3 tampons du playfield du corps (triple tampon)                       |
| `$70000`          | playfield du labyrinthe (3 plans entrelacés)                               |

### Outils (`reverse/tools`)

Scripts Python utilisés pour l'analyse (Python 3 + `capstone` + `pillow`) :

- `rnc.py data/Nibby nibby.bin` — décompression ;
- `m68kdis.py fichier début fin base` — désassemblage 68000 linéaire ;
- `copper.py adresse [n]` — décodage d'une copper list ;
- `gfx.py` — extraction PNG des graphismes (titre, barre d'état, tuiles, sprites).

`copper.py` et `gfx.py` lisent `work/nibby.bin`.

Les listings désassemblés sont dans `reverse/listings`.

## Écarts connus

- Le filtre passe-bas de l'Amiga (commande E0x) n'est pas émulé ; la sortie audio est un mélange
  stéréo direct des 4 voies, avec un léger crossfeed.
- Le timing est à la trame (50 Hz) : les attentes de raster et les blits sont instantanés.
