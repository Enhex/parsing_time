if [ -z "$1" ]
then
	build_type="template_release"
	capture_dir="capture-Release"
else
	build_type="template_debug"
	capture_dir="capture-Debug"
fi

cd ../../../build/

mkdir -p ./$capture_dir

rm -rf ./godot-master
unzip -q ./godot.zip
cd ./godot-master


../ClangBuildAnalyzer --start ./

# use_static_cpp is used to workaround missing libatomic.a: https://github.com/godotengine/godot/issues/46375
# libatomic-static isn't available on all distros
scons -j$(nproc) platform=linuxbsd use_llvm=yes use_lld=yes use_static_cpp=no CCFLAGS="-ftime-trace" target=$build_type

../ClangBuildAnalyzer --stop ./ ../$capture_dir/godot.bin
../ClangBuildAnalyzer --analyze ../$capture_dir/godot.bin > ../$capture_dir/godot.txt
