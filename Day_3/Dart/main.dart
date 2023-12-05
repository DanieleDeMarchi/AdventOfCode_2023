import 'dart:io';
import 'dart:math';

void main() {
  part1('../input1');
//   part2('../input2');
}

void part1(String inputFilePath) {
  final file = File(inputFilePath);

  List<String> lines = file.readAsLinesSync();

  int total = 0;

  for (var i = 0; i < lines.length; i++) {
    total += extractNumbers(lines[i], i)
      .where((number) => isNearSymbol(number, lines))
      .map((number) => number.value)
      .fold(0, (previousValue, element) => previousValue + element);
  }

  print('Part1 result: $total');
}

class Number {
  int value;
  int row;
  int startColumnIndex;
  int endColumnIndex;
  Number(this.value, this.row, this.startColumnIndex, this.endColumnIndex); 
}

List<Number> extractNumbers(String input, int rowNumber) {
  return RegExp(r'\d+').allMatches(input)
    .map((match) => new Number(int.parse(input.substring(match.start, match.end)), rowNumber, match.start, match.end))
    .toList();
}

bool isNearSymbol(Number number, List<String> lines) {
  // print('Check number ${number.value}');
  // print('Number row ${number.row}');
  // print('startColumnIndex ${number.startColumnIndex} \nendColumnIndex ${number.endColumnIndex}');
  for (var i = max(number.row-1, 0); i < min(number.row+2, lines.length); i++) {
    var lineLenght = lines[i].length;
    for (var j = max(number.startColumnIndex-1, 0); j < min(number.endColumnIndex+1, lineLenght); j++) {
      // print('Checking cell $i, $j');
      if(i == number.row && j >= number.startColumnIndex && j < number.endColumnIndex) {
        continue;
      }

      if(lines[i][j] != '.') {
        // print('number ${number.value} is near symbol ${lines[i][j]}');
        return true;
      }

    }
  }

  return false;
} 
