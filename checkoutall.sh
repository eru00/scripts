FORCE=0
DIR="."
BRANCH="develop"
while getopts d:fb: option
    do
        case "${option}"
            in
                d) DIR=${OPTARG};;
                f) FORCE=1;;
		b) BRANCH=${OPTARG};;
        esac
    done
cd $DIR &&
for d in */ ; 
do
    if [ $FORCE -eq 1 ]; then
        echo "$d checkout to $BRANCH"; cd $d && git checkout $BRANCH; cd ..
    else
        read -p "Checkout $d to $BRANCH? [y/n]" doit 
        case $doit in  
            y|Y) cd $d && git checkout $BRANCH ; cd .. ;; 
            n|N) echo Skipping $d ;; 
            *) echo Skipping $d ;; 
        esac
    fi
done
