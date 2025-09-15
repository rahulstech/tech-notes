# gzip command creates .gz seperate archive files for each input files 
# k : keep orignal file; by default gzip remove original files on successful compress
# 1 : fast compress
# 9 : best compress
# f : force output; if output archived or unarchived file exists then overrides it
# v : verbose output
# NOTE: i can add the gzip options in condensed format like -k9f or uncondensed format like -k -9 -f etc
gzip -k9f file1.txt file2.txt 

# to read a gzipped text file without unzipping use zcat command
content1=$(zcat file1.txt.gz)
content2=$(zcat file2.txt.gz)

echo "content of file1.txt $content1"
echo "content of file2.txt $content2"

# r : compress all files inside the directory but not the directory
gzip -r dir1/

content11=$(zcat dir1/file11.txt.gz)
content12=$(zcat dir1/file12.txt.gz)

echo "content of dir1/file11.txt $content11"
echo "content of dir1/file12.txt $content12"

# -d : decompress a .gz archive file
#
# the following command decompress all the .gz files inside dir1/ and deletes .gz files on success
# instead of gzip -d i can also use gunzip which is used for decompressing
gzip -dr dir1/
