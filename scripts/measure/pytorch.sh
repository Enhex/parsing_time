cd ../../../build

rm -rf ./pytorch-build
mkdir ./pytorch-build
cd ./pytorch-build

cmake ../pytorch -G "Unix Makefiles" -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release -DPYTHON_EXECUTABLE:PATH=`which python3` \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../pytorch-capture.bin
../ClangBuildAnalyzer --analyze ../pytorch-capture.bin > ../pytorch.txt
