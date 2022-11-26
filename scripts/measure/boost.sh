if [ -z "$1" ]
then
	build_type="release"
	capture_dir="capture-Release"
else
	build_type="debug"
	capture_dir="capture-Debug"
fi

cd ../../../build/

mkdir -p ./$capture_dir

rm -rf ./boost_1_80_0
tar -xf ./boost_1_80_0.tar.gz
cd ./boost_1_80_0

./bootstrap.sh --with-toolset=clang
./b2 clean

../ClangBuildAnalyzer --start ./

./b2 -j $(nproc) toolset=clang cxxflags="-ftime-trace" cflags="-ftime-trace" $build_type

../ClangBuildAnalyzer --stop ./ ../$capture_dir/boost.bin
cd ..
./ClangBuildAnalyzer --analyze ./$capture_dir/boost.bin > ./$capture_dir/boost.txt
