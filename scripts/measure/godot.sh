cd ../../../build/

rm -rf ./godot-master
unzip -q ./godot.zip
cd ./godot-master


../ClangBuildAnalyzer --start ./

# use_static_cpp is used to workaround missing libatomic.a: https://github.com/godotengine/godot/issues/46375
# libatomic-static isn't available on all distros
scons -j$(nproc) platform=linuxbsd use_llvm=yes use_lld=yes use_static_cpp=no CCFLAGS="-ftime-trace"

../ClangBuildAnalyzer --stop ./ ../godot-capture.bin
../ClangBuildAnalyzer --analyze ../godot-capture.bin > ../godot.txt
