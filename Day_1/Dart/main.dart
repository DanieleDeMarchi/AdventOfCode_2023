import 'dart:io';

void main() {
  part1('../input1');
  part2('../input2');
}

void part1(String inputFilePath) {
  final file = File(inputFilePath);
  final value = file
      .readAsLinesSync()
      .map((line) => calcCalibrationValue(line))
      .fold(0, (prev, cur) => prev + cur);

  print('Part1 result: $value');
}

void part2(String inputFilePath) {
  final file = File(inputFilePath);
  final value = file
      .readAsLinesSync()
      .map((line) => calcCalibrationValue2(line))
      .fold(0, (prev, cur) => prev + cur);

  print('Part2 result: $value');
}

int calcCalibrationValue(String input) {
  int indexOfFirstDigit = input.indexOf(RegExp(r'\d'));
  int indexOfLastDigit = input.lastIndexOf(RegExp(r'\d'));
  String concatString = input[indexOfFirstDigit] + input[indexOfLastDigit];
  return int.parse(concatString);
}

int calcCalibrationValue2(String input) {
  RegExp regExp =
      RegExp(r'(?=(\d|one|two|three|four|five|six|seven|eight|nine|zero))');
  Iterable<Match> matches = regExp.allMatches(input);
  String firstMatch = matches.first[1]!;
  String lastMatch = matches.last[1]!;
  int firstDigit = int.tryParse(firstMatch) ?? convStrToInt(firstMatch);
  int lastDigit = int.tryParse(lastMatch) ?? convStrToInt(lastMatch);
  String concatString = '$firstDigit$lastDigit';
  return int.parse(concatString);
}

int convStrToInt(String str) {
  final list = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
  ];
  return list.indexOf(str);
}
