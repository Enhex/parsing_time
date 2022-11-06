mkdir -p ../build

# get Clang Build Analyzer
wget -q --show-progress -nc -O ../build/ClangBuildAnalyzer https://github.com/aras-p/ClangBuildAnalyzer/releases/download/v1.4.0/ClangBuildAnalyzer-linux
chmod +x ../build/ClangBuildAnalyzer

# setup projects
cd ./scripts/setup
for file in ./*
do
	$file
done
