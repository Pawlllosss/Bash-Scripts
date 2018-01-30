#!/bin/bash

#script which creates Main.cpp file and also source and header files for classes which names are given as arguments

touch "Main.cpp"

>Main.cpp

for i in "$@"
do
	touch $i".cpp"

	header=$i".h"
	touch $header
	
	printf "#ifndef %sH\n#define "%s"H\nclass %s\n{\n\n};\n#endif" $i $i $i > $header

	echo "#include \"$header\"" >> "Main.cpp"
	echo "#include \""$header"\"" > $i".cpp"
done

echo -e "\nint main()\n{\n\nreturn 0\n}" >> "Main.cpp"
