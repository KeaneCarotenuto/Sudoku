let dim = 9;

class Board {
    var grid : [[Int]] = Array(repeating: Array(repeating: 0, count: dim), count: dim);
    var itCount = 0;

    func ResetGrid() 
    {
        grid = Array(repeating: Array(repeating: 0, count: dim), count: dim);
    }

    func RandomGrid(_ totalNums : Int = 10)
    {
        print(Color.yellow + "\nStarting New Random Board...")
        ResetGrid();
        let copyNums : Int = totalNums;
        var numsLeft : Int = totalNums;

        while numsLeft > 0 {            
            let randX : Int = Int.random(in: 0..<dim);
            let randY : Int = Int.random(in: 0..<dim);
            let randNum : Int = Int.random(in: 1...dim);

            if (grid[randX][randY] == 0 && CheckPos(randX, randY, randNum)) {
                grid[randX][randY] = randNum;
                numsLeft -= 1;
            }
        }

        print(Color.yellow + "Testing Board...")
        let copyGrid : [[Int]] = grid;
        if (Solve(0,0)){
            print(Color.green + "-Passed.")
            grid = copyGrid;
            print(Color.green + "Done.")
        }
        else {
            print(Color.red + "-Failed.")
            RandomGrid(copyNums);
        }
    }

    func display(_ marker : Int = -1)
    {
        let topBar : String = String(repeating: "+---", count: (dim)) + "+";

        var pos : Int = 0;

        print(Color.blue + topBar)
        for row in grid {
            var rowString : String = Color.blue +  "| ";
            for char in row {
                if (pos == marker) {
                    rowString += .red + "X"
                }
                else if (String(char) == "0") {
                    rowString += " ";
                }
                else {
                    rowString += .yellow + String(char);
                }
                rowString += Color.blue +  " | "

                pos += 1;
            }
            print(rowString);
            print(Color.blue + topBar)
        }
    }

    func GetBoardInput()
    {
        var count : Int = 0;

        var input : String = "";

        while count < dim*dim {
            print("Enter Integer(s) to be placed. Type " + (Color.yellow + "[end]") + " to solve board as is.");
            print("The " + (Color.red + "[X]") + " in the grid, is where they will be placed.");
            print("You may enter multiple at a time.  e.g. (" + (Color.yellow + "[1234]") + " or " + (Color.yellow + "[1 2 3 4]") + ").");
            print("Non-Int values are ignored. " + (Color.yellow + "[.]") + " and " + (Color.yellow + "[0]") + " acts as empty spaces.")

            print("Board:")
            self.display(count);
            print("\n")

            print("Enter:")
            input = readLine() ?? "";
            if (input.lowercased() == "end") {
                return;
            } 

            for char in input {
                var num : Int? = Int(String(char));
                if (num == nil){
                    if (String(".").contains(char)){
                        num = 0;
                    }
                }
                if (num != nil){
                    let row : Int = count / dim;
                    let col : Int = count % dim;


                    if (CheckPos(row, col, num!)) {
                        grid[row][col] = num!;
                        count += 1;
                    }
                    else {
                        print(.red + "\n\nWARNING: Duplicate Number Detected! Stopping at \(num!).")
                        break;
                    }

                    if count >= dim*dim {
                        print(.red + "\n\nWARNING: Too many numbers! Stopping at \(num!).")
                        break;
                    }
                }

                print("\n\n")
            }
        }
    }

    func CheckPos(_ row : Int, _ col : Int, _ num : Int) -> Bool
    {
        if (num == 0) {
            return true;
        }

        for x in 0...8 
        {
            if (grid[row][x] == num) 
            {
                return false;
            }
        }

        for x in 0...8 
        {
            if (grid[x][col] == num)
            {
                return false;
            }
        }
            
        for i in 0..<3
        {
            for j in 0..<3
            {
                if (grid[i + (row / 3)*3][j + (col / 3)*3] == num)
                {
                    return false;
                }
            }
        }
    
        return true;
    }

    func Solve(_ row : Int, _ col : Int) -> Bool
    {
        itCount += 1;

        var row : Int = row;
        var col : Int = col;

        if (row == dim - 1 && col == dim) 
        {
            return true;
        }
    
        if (col == dim)
        {
            row += 1;
            col = 0;
        }

        if (grid[row][col] != 0) 
        {
            return Solve(row, col + 1);
        }
    
        for num in 1...dim
        {
            if (CheckPos(row, col, num))
            {
                grid[row][col] = num;

                if (self.Solve(row, col + 1)) 
                {
                    return true;
                }
            }
            grid[row][col] = 0;
        }
        return false;
    }
}