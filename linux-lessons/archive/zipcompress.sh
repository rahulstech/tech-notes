# delete any existing zip files
rm *.zip

# zip <output zip file name> file1 [file2 ...]
zip output.zip file1.txt file2.txt 

# zipinfo [options] <zip file name>[.zip]
# 1 : list zip file entries names only, one per each line
echo "contents of output.zip"
zipinfo -1 output.zip 

# output
# =======
# file1.txt
# file2.txt

# r : compress directory with its contents
zip -r output-dir.zip dir2/

echo "content of output-dir.zip"
zipinfo -1 output-dir.zip

# output
# ======
# dir2/
# dir2/file21.txt
# dir2/file22.txt

# z : add comment; this will open a promt to enter comment;
#     to end comment input enter >  . (period) > enter 
echo "the comment of zip" | zip -r -z zip-with-comment.zip dir1/

echo "content of zip-with-comment.zip"
# z : show zip comment
zipinfo -z zip-with-comment.zip

# 0 to 9 : compression value; 0 = no compression, 1 fast compress, 9 best compress, default 6
# NOTE: compression is not noticible when etries are already compressed or very small in size
bash directory-builder.sh 4

zip -0r without-compression.zip dir4

zip -1r fast-compression.zip dir4

zip -9r best-compression.zip dir4

zip -r default-compression.zip dir4

ls -lah without-compression.zip
ls -lah fast-compression.zip
ls -lah best-compression.zip
ls -lah default-compression.zip

# m : delete original when compressed
zip -mr output4.zip dir4

ls dir4/ > /dev/null 2>&1

if (( $? != 0 ))
then
  echo "dir4 removed successfully"
else
  echo "dir4/ not removed"
fi
