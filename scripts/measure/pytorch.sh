if [ -z "$1" ]
then
	build_type="Release"
else
	build_type="Debug"
fi

cd ../../../build

mkdir -p ./capture-$build_type

rm -rf ./pytorch-build
mkdir ./pytorch-build
cd ./pytorch-build

cmake ../pytorch -G "Unix Makefiles" -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=$build_type -DPYTHON_EXECUTABLE:PATH=`which python3` \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../capture-$build_type/pytorch.bin
../ClangBuildAnalyzer --analyze ../capture-$build_type/pytorch.bin > ../capture-$build_type/pytorch.txt
