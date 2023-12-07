import 'dart:io';
import 'dart:math';

/**
 * Total time is given (Ttot)
 * Distance to beat is given (Drec)
 * Time of push is the varaible to find (Tpush = x)
 * Time of run is Trun = Ttot - Tpush
 * Speed = Tpush = x
 * distance = Trun * speed = Trun * x
 * To beat record 
 * Trun * x > Drec 
 * => (Ttot - Tpush) * x > Drec   => 
 * => (Ttot - x) * x > Drec       => 
 * => -x^2 + Ttot*x - Drec > 0    => 
 * => x^2 - Ttot*x + Drec < 0  
 * 
 * Solution is number of integers that satisfy the inequality x^2 - Ttot*x + Drec < 0 
 */

void main() {
  part1('../input2');
}

void part1(String inputFilePath) {
  final file = File(inputFilePath);
  List<String> lines = file.readAsLinesSync();
  String line1 = lines[0];
  String line2 = lines[1];
  final value = parseInput(line1, line2)
      .map((pair) => calculateNumberOfWaysToWin(pair))
      .fold(1, (prev, cur) => prev * cur);

  print('Part1 result: $value');
}

class Pair<T, V> {
  T left;
  V right;
  Pair(this.left, this.right);
}

List<Pair<int, int>> parseInput(String line1, String line2) {
  var line1Numbers = RegExp(r'\d+')
      .allMatches(line1)
      .map((e) => int.parse(e.group(0)!))
      .toList();
  var line2Numbers = RegExp(r'\d+')
      .allMatches(line2)
      .map((e) => int.parse(e.group(0)!))
      .toList();

  List<Pair<int, int>> result = [];
  for (var i = 0; i < line1Numbers.length; i++) {
    result.add(Pair(line1Numbers[i], line2Numbers[i]));
  }
  return result;
}

int calculateNumberOfWaysToWin(Pair<int, int> input) {
  return numberOfIntegerSolutions(
      1, -input.left.toDouble(), input.right.toDouble());
}

Pair<double, double> solveQuadraticEquation(double a, double b, double c) {
  final double delta = b * b - 4 * a * c;
  if (delta == 0) {
    final x = -b / (2 * a);
    return Pair(x, x);
  }
  final double x1 = (-b - sqrt(delta)) / (2 * a);
  final double x2 = (-b + sqrt(delta)) / (2 * a);
  print('Solving ${a}x^2 ${b}x $c');
  print('Solutions: $x1, $x2');
  return Pair(x1, x2);
}

int numberOfIntegerSolutions(double a, double b, double c) {
  var solutions = solveQuadraticEquation(a, b, c);
  var left = solutions.left == solutions.left.roundToDouble()
      ? // se numero è intero
      (solutions.left + 1).toInt()
      : solutions.left.toInt();

  var right = solutions.right == solutions.right.roundToDouble()
      ? // se numero è intero
      (solutions.right).toInt()
      : solutions.right.toInt();
  print('Interval: [${left},${right}]');

  return right - left;
}
