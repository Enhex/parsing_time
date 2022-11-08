cd ../../../build

rm -rf ./freeCAD-build
mkdir ./freeCAD-build
cd ./freeCAD-build

cmake ../FreeCAD-master -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" \
-D CMAKE_C_COMPILER=clang -D CMAKE_C_FLAGS="-ftime-trace" -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_CXX_FLAGS="-ftime-trace"

../ClangBuildAnalyzer --start ./

make -rj$(nproc)

../ClangBuildAnalyzer --stop ./ ../freeCAD-capture.bin
../ClangBuildAnalyzer --analyze ../freeCAD-capture.bin > ../freeCAD.txt
