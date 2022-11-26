if [ -z "$1" ]
then
	build_type="Release"
else
	build_type="Debug"
fi

cd ../../../build

mkdir -p ./capture-$build_type

rm -rf ./fmt-master-build
mkdir ./fmt-master-build
cd ./fmt-master-build

cmake ../fmt-master -DCMAKE_BUILD_TYPE=$build_type -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../capture-$build_type/fmt.bin
../ClangBuildAnalyzer --analyze ../capture-$build_type/fmt.bin > ../capture-$build_type/fmt.txt
