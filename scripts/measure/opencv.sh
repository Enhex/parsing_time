cd ../../../build

rm -rf ./opencv-4.x-build
mkdir ./opencv-4.x-build
cd ./opencv-4.x-build

cmake ../opencv-4.x -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../opencv-capture.bin
../ClangBuildAnalyzer --analyze ../opencv-capture.bin > ../opencv.txt
