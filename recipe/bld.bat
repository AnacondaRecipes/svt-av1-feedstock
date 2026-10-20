@echo on

cd Build

set "EXTRA_CMAKE_ARGS="
if "%target_platform%"=="win-arm64" (
  set "CC=clang-cl"
  set "CXX=clang-cl"
  set "EXTRA_CMAKE_ARGS=-DCMAKE_ASM_COMPILER=clang-cl -DENABLE_NEON_I8MM=OFF -DENABLE_SVE=OFF -DENABLE_SVE2=OFF"
)

cmake -G "Ninja"                                     ^
      -DCMAKE_BUILD_TYPE=Release                     ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_INSTALL_LIBDIR="lib"                   ^
      -DBUILD_SHARED_LIBS=ON                         ^
      -DBUILD_TESTING=OFF                            ^
      %EXTRA_CMAKE_ARGS%                             ^
      ..
if errorlevel 1 exit 1

ninja
if errorlevel 1 exit 1

@REM Tests are skipped due to the fact that they hang at the very beginning
@REM ctest --output-on-failure
@REM if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
