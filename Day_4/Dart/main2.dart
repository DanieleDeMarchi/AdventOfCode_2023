import 'dart:io';
import 'dart:math';

void main() {
  part2('../input1');
}


void part2(String inputFilePath){
  final file = File(inputFilePath);
  List<Card> cards = file
      .readAsLinesSync()
      .map((line) => parseLine(line))
      .toList();

  for (var i = 0; i < cards.length; i++) {
    int cardScore = cards[i].calcScore();
    // print('Score of card $i: $cardScore');
    for (var j = i+1; j < min(i+1+cardScore, cards.length) ; j++) {
      // print('Adding one copy of card $j');
      cards[j].copies += cards[i].copies;
    }
  }

  final int total = cards.fold(0, (previousValue, element) => previousValue + element.copies);

  print('Part2 result: $total');
}


class Card {
  Set<int> winningNumbers;
  List<int> myNumbers;
  int score = 0;
  int copies = 1;

  Card(this.winningNumbers, this.myNumbers);

  int calcScore() {
    for (var number in myNumbers) {
      if(winningNumbers.contains(number)){
        score++;
      }
    } 
    return this.score;
  }
}

Card parseLine(String line) {
  line.indexOf(":");
  List<String> leftRightStrings = line.substring(line.indexOf(":") + 1).split("|");
  String winningPart = leftRightStrings[0];
  String myPart = leftRightStrings[1];

  Set<int> winningNumbers = RegExp(r'\d+').allMatches(winningPart)
      .map((e) => int.parse(winningPart.substring(e.start, e.end))).toSet();
  List<int> myNumbers = RegExp(r'\d+').allMatches(myPart)
      .map((e) => int.parse(myPart.substring(e.start, e.end))).toList();
  return Card(winningNumbers, myNumbers);
}

