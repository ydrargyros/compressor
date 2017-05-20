#title          :compressor.sh
#description	:Compress all folders of specified folder. Has a nice progress bar, and deletes original folder. USE AT OWN RISK!
#				
#author			:Nick Loudaros
#date			:20111101
#version        :0.1    
#usage		 	:bash compressor.sh
#notes          :Makes usage of pv command.
#==============================================================================
#		Changelog:
#		Older version of this gziped each tar file of cPanel individually
#       e.g.
#       for i in $(find /home -type f -name "*.tar")
#       do
#       tar -czf $i.tar.gz $i
#       done


#VARIABLES
DIFF=0                          #Time difference in seconds
START=$(date +%s)       #Script starts at this time
FILES_LEFT=$(find /home/hephaestus -type d |wc -l)      #This is how many files/folders are left
clear
echo -e "\n"
echo "Nicer compressor Script v1.1"
echo -e "\n"
echo -e "The following \e[93m$FILES_LEFT\e[0m directories will be compressed"
echo "$(find . -mindepth 1 -type d|sort -n)"
echo -e "\n"
read -p "Press [Enter] key to start compression..."
clear


#START
for i in $(find /home/hephaestus -mindepth 1 -type d|sort -n)
do
echo -e "There are \e[93m$(find /home/hephaestus -type d|wc -l)\e[0m directories left to compress..." #yellow
echo -e "\n"
echo -e "Now compressing $i"
tar cf - $i -P | pv -s $(du -sb $i|awk '{print $1}')|gzip > $i.tar.gz
rm -rf $i
done
END=$(date +%s)         #Script ends at this time
DIFF=$(( $END - $START )) #Time spent on running the script
DIFF_S=$((DIFF %60))
DIFF_M=$(((DIFF/60)%60))
echo "Compressor script took $DIFF_M minutes and $DIFF_S seconds"       #Final echo to the user


#END