cd ../../../build/llvm-project

rm -rf ./build
mkdir build
cd build
cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../../ClangBuildAnalyzer --stop ./ ../../clang-capture.bin
cd ../..
./ClangBuildAnalyzer --analyze ./clang-capture.bin > ./clang.txt
