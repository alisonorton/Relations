import 'dart:io';

/*****************************************************
 * DISPLAY
 *****************************************************/
void display(List sets, List pairs) {
  stdout.write("Set: {${sets.join(", ")}}\n");
  stdout.write("Relation: { ");

  for (int i = 0; i < pairs.length; i++) {
    var displayPair = new List();
    displayPair = pairs[i].split(' ');
    if (i == pairs.length - 1) {
      stdout.write("(${displayPair[0]}, ${displayPair[1]}) }\n");
    } else {
      stdout.write("(${displayPair[0]}, ${displayPair[1]}), ");
    }
  }

  //Checking and displaying reflexive
  if (checkReflexive(sets, pairs)) {
    stdout.write("Reflexive: Yes\n");
  } else {
    stdout.write("Reflexive: No\n");
  }

  //Checking and displaying symmetric
  if (checkSymmetric(pairs)) {
    stdout.write("Symmetric: Yes\n");
  } else {
    stdout.write("Symmetric: No\n");
  }
}
/*****************************************************
 * CHECKING REFLEXIVE
 *****************************************************/

bool checkReflexive(List sets, List pairs) {
  bool reflexive = false;
  var thisPair = new List();

  for (int i = 0; i < sets.length; i++) {
    for (int j = 0; j < pairs.length; j++) {
      thisPair = pairs[j].split(' ');
      //Comparing each set member to each ordered pair
      if (sets[i] == thisPair[0] && sets[i] == thisPair[1]) {
        reflexive = true;
        if (i == sets.length - 1) {
          break;
        }
      } else {
        reflexive = false;
      }
    }
  }

  return reflexive;
}

/*****************************************************
 * CHECKING SYMMETRIC
 *****************************************************/

bool checkSymmetric(List pairs) {
  bool symmetric = false;
  var thisPair = new List();
  var thatPair = new List();

  for (int i = 0; i < pairs.length; i++) {
    thisPair = pairs[i].split(' ');
    for (int j = 0; j < pairs.length; j++) {
      thatPair = pairs[j].split(' ');

      //If a pair is being compared to itself skip to next loop
      if (thisPair[0] == thatPair[0] && thisPair[1] == thatPair[1]) {
        continue;
        //Checking for symmetric ordered pairs
      } else if (thisPair[0] == thatPair[1] && thisPair[1] == thatPair[0]) {
        symmetric = true;
        if (i == pairs.length - 1) {
          break;
        }
      }
      //If it's a reflexive pair skip over and continue looping
      else if (thisPair[0] == thatPair[0] && thisPair[0] == thatPair[1]) {
        continue;
      } else {
        symmetric = false;
      }
    }
  }

  return symmetric;
}

/*****************************************************
 * MAIN
 *****************************************************/

void main(args) {
  if (args.isEmpty) {
    stdout.write("ERROR: Could not find input file.\n");
  } else {
    var sets = new List();
    var pairs = new List();

    new File(args[0].toString()).readAsLines().then((List<String> input) {
      for (int i = 0; i < input.length; i++) {
        if (i == 0) {
          sets = input[i].split(' ');
        } else {
          pairs.add(input[i]);
        }
      }

      display(sets, pairs);
    });
  }
}
