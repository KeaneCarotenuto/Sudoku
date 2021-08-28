enum Color: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"

#if !os(Windows)
    static func + (_ left: Color, _ right: String) -> String {
        return left.rawValue + right + "\u{001B}[0;37m"
    }

    static func + (_ left: String, _ right: Color) -> String {
        return left + right.rawValue
    }
#else
    static func + (_ left: Color, _ right: String) -> String {
        return right
    }

    static func + (_ left: String, _ right: Color) -> String {
        return left
    }
#endif
}

var running : Bool = true;

while running {
    let tempGrid : Board = Board();
    var solveAnother = false;
    var randomPuzzle = false;

    print("Welcome to Keane's Sudoku Solver\n")
    print("Choose Option:")
    print((.yellow + "[1]") + " Start Solver")
    print((.yellow + "[2]") + " Solve Random")
    print((.yellow + "[3]") + " Quit\n")

    let input : String = readLine() ?? ""

    if (input == "1") {
        solveAnother = true;
    }
    else if (input == "2") {
        solveAnother = true;
        randomPuzzle = true;
    }
    else if (input == "3") {
        running = false;
    }
    else {
        print(Color.red + "\nPlease only enter [1], [2], or [3]\n")
    }

    if solveAnother {
        if (randomPuzzle){
            var amount : Int? = nil;


            while amount == nil {
                print("Please enter desired amount pre-filled cells (0-25, takes longer for larger amounts):")
                amount = Int(readLine() ?? "") ?? nil;

                if (amount == nil || amount! < 0 || amount! > 25) {
                    amount = nil;
                }
            }

            tempGrid.RandomGrid(amount!);
            print("\n\nRandom Grid:")
            tempGrid.display();
            print("\n")
        }
        else {
            tempGrid.GetBoardInput();
        }        

        tempGrid.itCount = 0;

        print(Color.yellow + "\n\nSolving...")
        print("Result:")
        if (tempGrid.Solve(0, 0))
        {
            tempGrid.display();
            print (Color.green + "Solved in \(tempGrid.itCount) steps");
        }
        else 
        {
            print(Color.red + "Board is Unsolvable.")
        }

        print("\n\n\n");
    }
}