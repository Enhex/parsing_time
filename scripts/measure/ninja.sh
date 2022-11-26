if [ -z "$1" ]
then
	build_type="Release"
else
	build_type="Debug"
fi

cd ../../../build

mkdir -p ./capture-$build_type

rm -rf ./ninja-master
unzip -q ./ninja.zip
cd ./ninja-master

cmake -DCMAKE_BUILD_TYPE=$build_type -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../capture-$build_type/ninja.bin
../ClangBuildAnalyzer --analyze ../capture-$build_type/ninja.bin > ../capture-$build_type/ninja.txt
