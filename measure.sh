# measure projects
cd ./scripts/measure
for file in ./*
do
	$file
done

cd ../../../build
python3 ../parsing_time/process.py
