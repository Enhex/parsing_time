cd ../../../build

rm -rf ./nlohmann_json-build
mkdir ./nlohmann_json-build
cd ./nlohmann_json-build

cmake ../nlohmann_json -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../nlohmann_json-capture.bin
../ClangBuildAnalyzer --analyze ../nlohmann_json-capture.bin > ../nlohmann_json.txt
