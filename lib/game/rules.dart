import 'package:studio_core/core/arcade.dart';
import 'package:studio_core/core/level_plan.dart';
import 'package:studio_core/core/missions.dart';
import 'package:studio_core/core/stats.dart';
import 'casual_engine.dart';

class ScrewPuzzleRules extends ArcadeRules<CasualLevel> {
  @override
  String get gameId => 'game-097-screw-puzzle';

  @override
  List<String> get optionalMechanics => const [];

  @override
  List<GameStat> get gameStats => const [
        GameStat('screws_removed', 'Sökülen vida', 'Screws removed', scale: 2000),
        GameStat('boxes_filled', 'Dolan kutu', 'Boxes filled', scale: 500),
        GameStat('plates_dropped', 'Düşen plaka', 'Plates dropped', scale: 500),
      ];

  @override
  List<MissionTemplate> get missionTemplates => const [
        MissionTemplate('screws_removed', 'screws_removed', [500, 1000, 2000]),
        MissionTemplate('boxes_filled', 'boxes_filled', [62, 125, 250], coinReward: 80),
      ];

  @override
  CasualLevel generate(LevelSpec spec) => generateCasual(CasualKind.screw, spec);

  @override
  ArcadeMeta metaOf(CasualLevel l) => l.meta;

  @override
  ArcadeSim createSim(CasualLevel l) => CasualSim(l);

  @override
  ArcadeInput bot(ArcadeSim sim) => casualBot(sim);
}

ArcadeRules createRules() => ScrewPuzzleRules();
