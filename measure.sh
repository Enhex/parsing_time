# measure projects
cd ./scripts/measure
for file in ./*
do
	$file
	$file d
done

cd ../..
./process.sh
