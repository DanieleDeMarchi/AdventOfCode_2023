import 'dart:io';
import 'dart:math';

void main() {
  part1('../input1');
  part2('../input2');
}

void part1(String inputFilePath) {
  final file = File(inputFilePath);
  List<String> lines = file.readAsLinesSync();

  int total = 0;
  for (var i = 0; i < lines.length; i++) {
    total += extractNumbers(lines[i], i)
      .where((number) => isNearSymbol(number, lines, RegExp(r'[^0-9.*]')))
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

bool isNearSymbol(Number number, List<String> lines, RegExp regex) {
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

      if(regex.hasMatch(lines[i][j])) {
        // print('number ${number.value} is near symbol ${lines[i][j]}');
        return true;
      }
    }
  }

  return false;
} 

void part2(String inputFilePath) {
  final file = File(inputFilePath);
  List<String> lines = file.readAsLinesSync();
  int total = calcGear(lines);
  print('Part2 result: $total');
}

int calcGear(List<String> lines) {
  var total = 0;
  for (var i = 0; i < lines.length; i++) {
    // find *
    // get gear ratio of number near * (only if there are 2 numbers adjacent to *)
    // add to total
    total += RegExp(r'\*').allMatches(lines[i])
      .map((match) => calculateGearRatio(lines, i, match.start))
      .fold(0, (previousValue, element) => previousValue + element);
  }
  return total;
}

int calculateGearRatio(List<String> lines, int row, int column) {
  // find number in rows [row-1, row+1] (inclusive)
  List<Number> numbers = [];
  for(var i = max(0, row -1); i <= min(lines.length, row +1); i++) {
    numbers.addAll(extractNumbers(lines[i], i));
  }

  // keep only numbers that are in column range [column - 1, column + 1] (inclusive)
  numbers = numbers.where((number) => number.endColumnIndex > column-1 && number.startColumnIndex <= column + 1 ).toList();
  // if number of numbers == 2 multiply and return value
  if(numbers.length == 2) {
    return numbers[0].value * numbers[1].value;
  }
  // oteherwise return 0
  return 0;

}