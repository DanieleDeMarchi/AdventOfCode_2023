import 'dart:io';
import 'dart:math';

void main() {
  part1('../input1');
  // part2('../input2');
}

void part1(String inputFilePath){
  final file = File(inputFilePath);
  final value = file
      .readAsLinesSync()
      .map((line) => calculateScoreOfLine(line))
      .fold(0, (prev, cur) => prev + cur);

  print('Part1 result: $value');
}


class Match {
  Set<int> winningNumbers;
  List<int> myNumbers;

  Match(this.winningNumbers, this.myNumbers);

  int calcScore() {
    int winningCards = 0;
    for (var number in myNumbers) {
      if(winningNumbers.contains(number)){
        winningCards++;
      }
    }
    return winningCards > 0 ? pow(2, winningCards-1).toInt() : 0;
  }
}

int calculateScoreOfLine(String line) {
  Match match = parseLine(line);
  return match.calcScore();
}

Match parseLine(String line) {
  line.indexOf(":");
  List<String> leftRightStrings = line.substring(line.indexOf(":") + 1).split("|");
  String winningPart = leftRightStrings[0];
  String myPart = leftRightStrings[1];

  Set<int> winningNumbers = RegExp(r'\d+').allMatches(winningPart)
      .map((e) => int.parse(winningPart.substring(e.start, e.end))).toSet();
  List<int> myNumbers = RegExp(r'\d+').allMatches(myPart)
      .map((e) => int.parse(myPart.substring(e.start, e.end))).toList();
  return Match(winningNumbers, myNumbers);
}

