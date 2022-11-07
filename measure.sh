# measure projects
cd ./scripts/measure
for file in ./*
do
	$file
done

cd ../..
./process.sh
