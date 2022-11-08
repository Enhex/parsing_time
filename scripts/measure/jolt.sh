cd ../../../build

rm -rf ./JoltPhysics-master
unzip -q ./jolt.zip
cd ./JoltPhysics-master/Build

cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../../ClangBuildAnalyzer --stop ./ ../../jolt-capture.bin
../../ClangBuildAnalyzer --analyze ../../jolt-capture.bin > ../../jolt.txt
