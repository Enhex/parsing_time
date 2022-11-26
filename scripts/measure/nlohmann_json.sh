if [ -z "$1" ]
then
	build_type="Release"
else
	build_type="Debug"
fi

cd ../../../build

mkdir -p ./capture-$build_type

rm -rf ./nlohmann_json-build
mkdir ./nlohmann_json-build
cd ./nlohmann_json-build

cmake ../nlohmann_json -DCMAKE_BUILD_TYPE=$build_type -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../capture-$build_type/nlohmann_json.bin
../ClangBuildAnalyzer --analyze ../capture-$build_type/nlohmann_json.bin > ../capture-$build_type/nlohmann_json.txt
