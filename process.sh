cd ../build/capture-Debug
echo "DEBUG:"
echo "======"
python3 ../../parsing_time/process.py

cd ../capture-Release
echo ""
echo ""
echo "RELEASE:"
echo "========"
python3 ../../parsing_time/process.py
