import 'package:flutter_test/flutter_test.dart';
import 'package:game_097_screw_puzzle/core/arcade.dart';
import 'package:game_097_screw_puzzle/core/level_plan.dart';
import 'package:game_097_screw_puzzle/game/casual_engine.dart';
import 'package:game_097_screw_puzzle/game/rules.dart';

void main() {
  final rules = ScrewPuzzleRules();
  final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: rules.optionalMechanics);

  CasualSim fresh([int n = 1]) => CasualSim(rules.build(planner.spec(n)).puzzle);

  test('a stuck board costs a life and restarts the same board', () {
    final s = fresh(4);
    final g = s.goalText;
    s.boardFailed();
    expect(s.lives, 2);
    expect(s.goalText, g);
  });

  test('autopilot clears the first twelve boards without losing a life', () {
    for (var n = 1; n <= 12; n++) {
      final s = fresh(n);
      expect(runBot(s, rules.bot, 60 * 60 * 6).won, isTrue, reason: 'level $n');
      expect(s.lives, 3, reason: 'level $n');
    }
  });

  test('screw: covered screws cannot be taken; the proven order clears the board', () {
    final s = fresh(20) as ScrewSim;
    for (final k in s.order) {
      expect(s.isFree(k), isTrue);
      final sc = s.screws[k];
      s.tick(ArcadeInput(down: true, tap: true, x: sc.x, y: sc.y));
      s.tick(const ArcadeInput(x: 0, y: 0));
      if (s.over) break;
    }
    expect(s.won, isTrue);
    expect(s.buffer, isEmpty);
  });
}
