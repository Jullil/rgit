#!/bin/bash

ROOT_PATH=$(cd $(dirname $0) && pwd);

get_modules() {
    echo "Get all modules"
    file="${ROOT_PATH}/repository_list"

    num=0
    while read line
    do
	i=0
	array[0]=""
	array[1]=""
	array[2]=""
	for word in $line
	do
	    array[$i]="$word"
	    i=$(($i+1))
	done
	
	modules[$num]=${array[*]}
	num=$(($num+1))
    done < $file
    
    
    #for a in ${modules[*]}
    #do
#	for b in ${a[*]}
#	do
#	    echo $b
#	done
#    done
}

get_module() {
    if [ -z "$1" ]
    then
	echo "Module name not setup"
    else
	name=$1
        for mod in ${modules[*]}
	do
	    if [ ${module[0]} = $name ]
	    then
		echo "Module find!!!"
		exec_module ${module[*]}
		return 1
	    fi
        done
	return 0
    fi
    return 0
}

exec_module() {
    echo "2222222222222"
    if [ -z "$1" ]
    then
	echo "Module not found"
    else
	module_data=$1
	echo "Module data:"
	echo ${module_data[0]}
	echo ${module_data[1]}
	echo ${module_data[2]}

	module_name=${module_data[0]}
	module_path=${module_data[1]}
	module_url=${module_data[2]}

	dir="${ROOT_PATH}/${module_path}"
	if [ -d $dir ] 
	then
	    echo "Pull changes of module ${module_name}"
	    #cd $dir
	    #git pull
	else
	    if [ -n $module_url ]
	    then
    		echo "Clone repository of module ${module_name}"
    		#git clone $module_url $dir
	    fi
	fi  

    fi
}

while [ $# != "0" ]
do 
    case $1 in
      "--all")
	echo "Update all modules"
      shift
          ;;
      *)
        echo "Find module $1"
	

	get_modules
	get_module $1 
          ;;
    esac
    shift
done




