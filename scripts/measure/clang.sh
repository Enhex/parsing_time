if [ -z "$1" ]
then
	build_type="Release"
else
	build_type="Debug"
fi

cd ../../../build

mkdir -p ./capture-$build_type

cd ./llvm-project

rm -rf ./build
mkdir build
cd build
cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=$build_type -G "Unix Makefiles" ../llvm \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../../ClangBuildAnalyzer --stop ./ ../../capture-$build_type/clang.bin
cd ../..
./ClangBuildAnalyzer --analyze ./capture-$build_type/clang.bin > ./capture-$build_type/clang.txt
