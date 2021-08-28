::Enable swift compilation
set SWIFTFLAGS=-sdk %SDKROOT% -resource-dir %SDKROOT%\usr\lib\swift -I %SDKROOT%\usr\lib\swift -L %SDKROOT%\usr\lib\swift\windows

::Build the exe using the .swift files
swiftc %SWIFTFLAGS% -emit-executable -o build/Sudoku.exe source/main.swift source/Board.swift && cd build

::Clear screen, then run .exe
cls && Sudoku