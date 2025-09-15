if (( $# != 1 )) then
  echo "COMMAND: bash directory-builder.sh <tag>"
  exit 1
fi

TAG=$1
ROOT_DIR="dir$TAG"

if [[ ! -d "$ROOT_DIR" ]]
then
  # create the directory
  mkdir "$ROOT_DIR"
fi

cd "$ROOT_DIR"

# create 3 files
for index in $(seq 1 3)
do
  filename="file$TAG$index.txt"
  if [[ ! -f "$filename" ]]
  then
    touch "$filename"
  fi
done

# create 2 subdirectories
for index in $(seq 1 2)
do
  dirname="subdir$index"
  if [[ ! -d "$dirname" ]]
  then
    mkdir "$dirname"
    touch "$dirname/file1.txt"
  fi
done
