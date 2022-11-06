cd ../../../build/

rm -rf ./boost_1_80_0
tar -xf ./boost_1_80_0.tar.gz
cd ./boost_1_80_0

./bootstrap.sh --with-toolset=clang
./b2 clean

../ClangBuildAnalyzer --start ./

./b2 -j $(nproc) toolset=clang cxxflags="-ftime-trace" cflags="-ftime-trace"

../ClangBuildAnalyzer --stop ./ ../boost-capture.bin
cd ..
./ClangBuildAnalyzer --analyze ./boost-capture.bin > ./boost.txt
