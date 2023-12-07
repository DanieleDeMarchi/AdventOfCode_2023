import 'dart:io';
import 'dart:math';

/**
 * Almost the same as part 1
 * Different parse of input
 */
void main() {
  part1('../input2.test');
}

void part1(String inputFilePath) {
  final file = File(inputFilePath);
  final List<String> lines = file.readAsLinesSync();
  final String line1 = lines[0];
  final String line2 = lines[1];
  final (time, distance) = parseInput(line1, line2);
  final int result = calculateNumberOfWaysToWin(time, distance);
  print('Part2 result: $result');
}

(int, int) parseInput(String line1, String line2) {
  String time = RegExp(r'\d+')
      .allMatches(line1)
      .map((e) => e.group(0)!)
      .fold("", (previousValue, element) => previousValue + element);
  String distance = RegExp(r'\d+')
      .allMatches(line2)
      .map((e) => e.group(0)!)
      .fold("", (previousValue, element) => previousValue + element);

  return (int.parse(time), int.parse(distance));
}

int calculateNumberOfWaysToWin(int time, int distance) {
  return numberOfIntegerSolutions(1, -time.toDouble(), distance.toDouble());
}

(double, double) solveQuadraticEquation(double a, double b, double c) {
  final double delta = b * b - 4 * a * c;
  if (delta == 0) {
    final x = -b / (2 * a);
    return (x, x);
  }
  final double x1 = (-b - sqrt(delta)) / (2 * a);
  final double x2 = (-b + sqrt(delta)) / (2 * a);
  print('Solving ${a}x^2 ${b}x $c');
  print('Solutions: $x1, $x2');
  return (x1, x2);
}

int numberOfIntegerSolutions(double a, double b, double c) {
  var (x1, x2) = solveQuadraticEquation(a, b, c);
  print('Real interval: [${x1},${x2}]');

  var left = x1.ceil() + 1;
  var right = x2.floor() - 1;
  print('Integer interval: [${left},${right}]');

  return right - left + 1;
}
