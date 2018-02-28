#!/bin/bash

#script which creates Main.cpp file and also source and header files for classes which names are given as arguments

#-s <folder_path> save file to the folder_path
#-o don't create main.cpp

src_path="./"
main_flag=1
opt_index=0

while getopts ":s: :o" opt; do
	case $opt in
		s)
			src_path=$OPTARG
		;;
		o)
			echo "Omiting main.cpp"
			main_flag=0
		;;
		\?)
			echo "You've choosen a wrong option."
			exit 1
		;;
		:)
			exit 1
			echo "No arguments needed for this option."
		;;
	esac

	opt_index=$OPTIND
done

echo $opt_index

if [ $main_flag -eq 1 ]; then
	touch "Main.cpp"
	>Main.cpp
fi

echo $@

for i in "$@"
do
	
	if [ $opt_index -gt 1 ]; then
		opt_index=$((opt_index - 1))
		continue
	fi

	touch $i".cpp"

	header=$i".h"
	#echo $src_path$header

	touch $src_path$header
	
	printf "#ifndef %sH\n#define "%s"H\nclass %s\n{\npublic:\nprivate:\n};\n#endif" $i $i $i > $src_path$header

	if [ $main_flag -eq 1 ]; then
		echo "#include \"$header\"" >> $src_path"Main.cpp"
	fi

	echo "#include \""$header"\"" > $src_path$i".cpp"
done

if [ $main_flag -eq 1 ]; then
	echo -e "\nint main()\n{\n\nreturn 0;\n}" >> $src_path"Main.cpp"
fi
