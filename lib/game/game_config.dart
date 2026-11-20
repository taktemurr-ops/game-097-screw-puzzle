import 'package:flutter/material.dart';

import '../app/arcade_stage.dart';
import '../app/game_api.dart';
import '../core/game_rules.dart';
import 'casual_engine.dart';
import 'casual_view.dart';
import 'rules.dart';

final gameConfig = GameConfig(
  gameId: 'game-097-screw-puzzle',
  title: const ['Vida Bulmacası', 'Screw Puzzle', 'Schrauben-Puzzle', 'Rompecabezas de Tornillos', 'Puzzle de Vis'],
  tagline: const ['Vidaları doğru sırayla sök, kutuları doldur!', 'Unscrew in the right order, fill the boxes!', 'In der richtigen Reihenfolge!', '¡En el orden correcto!', 'Dans le bon ordre !'],
  seedColor: const Color(0xFF457B9D),
  icon: Icons.hardware,
  rules: ScrewPuzzleRules(),
  buildPlay: (ctx) => ArcadeStage(
    ctx: ctx,
    create: () => CasualSim((ctx.generated as GeneratedLevel<CasualLevel>).puzzle),
    paint: paintCasual,
    sound: casualSound,
    boosterIcon: Icons.add_box,
    boosterLabel: (l) => l == 'tr' ? '+1 park yeri' : '+1 parking slot',
    howTo: const ['Üstte kalan (parlak) vidaya dokun. Vida aynı renkli kutuya, yoksa park alanına gider.', 'Tap a free (bright) screw. It goes to the matching box, otherwise to the parking tray.', 'Freie Schraube antippen.', 'Toca un tornillo libre.', 'Touchez une vis libre.'],
  ),
  tutorial: const [
    TutorialStep(Icons.touch_app, ['Parlak vidalara dokun; soluklar kapalı.', 'Tap bright screws; faded ones are covered.', 'Helle Schrauben antippen.', 'Toca los brillantes.', 'Touchez les vives.']),
    TutorialStep(Icons.inventory_2, ['Kutunun rengine uygun vidaları sök.', 'Pick screws matching the boxes.', 'Passend zu den Kisten.', 'Igual que las cajas.', 'Comme les boîtes.']),
    TutorialStep(Icons.warning, ['Park alanı dolmasın!', 'Do not fill the parking tray!', 'Parkplatz nicht füllen!', '¡No llenes el parking!', 'Ne remplissez pas le parking !']),
  ],
);
