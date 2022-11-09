cd ../../../build

rm -rf ./fmt-master-build
mkdir ./fmt-master-build
cd ./fmt-master-build

cmake ../fmt-master -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../fmt-capture.bin
../ClangBuildAnalyzer --analyze ../fmt-capture.bin > ../fmt.txt
