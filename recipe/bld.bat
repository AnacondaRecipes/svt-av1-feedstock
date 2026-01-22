@echo on

cd Build

cmake -G "NMake Makefiles"                           ^
      -DCMAKE_BUILD_TYPE=Release                     ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_LIBDIR="lib"                   ^
      -DBUILD_SHARED_LIBS=ON                         ^
      -DBUILD_TESTING=OFF                            ^
      -DNATIVE=OFF                                   ^
      ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

@REM Tests are skipped due to the fact that they hang at the very beginning
@REM ctest --output-on-failure
@REM if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
