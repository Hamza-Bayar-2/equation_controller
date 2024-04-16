void main() {
  List<String> equations = [
    "2 + 3 * (4 - 1)",
    "3 * (4 + 2 / 3",
    "(10 - 5) / (2 + 3 * 2)",
    "12 + ((3 - 2) * 4) / 2",
    "2 * 3 / 0"
  ];
  List<String> equations2 = [
    "2 +* 3",
    "3 *",
    "/ (2 + 3 * 2)",
    "12 + ((3 - 2) * )",
    "( + 3 * 2)",
    "(3 + 3 * 2) f",
    "(2 @+ 3 * 2)",
  ];
  Controller controller = new Controller();

  for (var i = 0; i < equations2.length; i++) {
    print("\"${equations2[i]}\"");

    if(controller.isThisMathematical(equations2[i])) {
      print("The entered expression is a mathematical expression.\n");
    }
    else{
      print("The entered expression is NOT a mathematical expression\n");
    }
  }

}

class Controller{
  bool isThisMathematical(String entry) {
    String fixedEntry = entry.replaceAll(" ", "");

    // if the entry contains anything beside numbers, brackets and operand it returns FALSE
    if(!justNumbersBracketsAndMathematicalOperations(fixedEntry)) {
      return false;
    }
    // if there is brackets error the method returns FALSE
    if (!bracketsController(fixedEntry)) {
      return false;
    }

    // if there is division by zero the method returns TRUE
    if (containsDivisionByZero(fixedEntry)) {
      return false;
    }

    // if there is mathematical operation error the method returns FALSE
    if(!mathematicalOperationController(fixedEntry)) {
      return false;
    }

    return true;
  }

  bool mathematicalOperationController(String fixedEntry) {
    //if there are mathematical operations in the beginning or in the end it returns FALSE
    if(RegExp(r'[\+\-\*\/]').hasMatch(fixedEntry[0]) || 
      RegExp(r'[\+\-\*\/]').hasMatch(fixedEntry[fixedEntry.length - 1])) {
      return false;
    }
    
    for (var i = 0; i < fixedEntry.length; i++) {
      if(RegExp(r'[\+\-\*\/]').hasMatch(fixedEntry[i])) {
        // if the mathematical operations in row it returns FALSE 
        if(RegExp(r'[\+\-\*\/]').hasMatch(fixedEntry[i + 1])) {
          return false;
        }
        // inside the brackets if there is no number after or before the mathematical operation it returns FALSE
        if(fixedEntry[i + 1] == ")" || fixedEntry[i - 1] == "(") {
          return false;
        }
      }
    }

    return true;
  }

  bool containsDivisionByZero(String fixedEntry) {
    if(fixedEntry.contains("/0")) {
      return true;
    }
    else{
      return false;
    }
  }

  bool justNumbersBracketsAndMathematicalOperations(String fixedEntry) {
    if(RegExp(r'^[0-9\+\-\*\/\(\)]+$').hasMatch(fixedEntry)) {
      return true;
    }
    else {
      return false;
    }
  }

  bool bracketsController(String fixedEntry) {
    List<String> stackOfOpenBrackets = [];

    for (var i = 0; i < fixedEntry.length; i++) {
      if(fixedEntry[i] == "(") {
        stackOfOpenBrackets.add("(");
      }
      else if(fixedEntry[i] == ")") {
        if(stackOfOpenBrackets.isNotEmpty) {
          stackOfOpenBrackets.removeLast();
        }
        else{
          return false;
        }
      }
    }

    if(stackOfOpenBrackets.isNotEmpty) {
      return false;
    }
    else{
      return true;
    }
  }
}