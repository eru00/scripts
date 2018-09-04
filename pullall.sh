FORCE=0
DIR="."
while getopts d:f option
    do
        case "${option}"
            in
                d) DIR=${OPTARG};;
                f) FORCE=1;;
        esac
    done
cd $DIR &&
for d in */ ; 
do
    if [ $FORCE -eq 1 ]; then
        echo $d; cd $d && git pull ; cd ..
    else
        read -p "Pull $d? [y/n]" doit 
        case $doit in  
            y|Y) cd $d && git pull ; cd .. ;; 
            n|N) echo Skipping $d ;; 
            *) echo Skipping $d ;; 
        esac
    fi
done