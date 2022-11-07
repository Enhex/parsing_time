cd ../../../build

rm -rf ./ninja-master
unzip -q ./ninja.zip
cd ./ninja-master

cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../ninja-capture.bin
../ClangBuildAnalyzer --analyze ../ninja-capture.bin > ../ninja.txt
