#!/bin/sh
#this runs the entire directory of programs from inside of here





echo "making individual patient files"
cd 'c:/users/esnak/documents/internship_files'
echo "type the data file name ie: data.vcf"
sruby patientfilecreator/patientfilecreatormaster.rb
sleep 3 
clear



echo "switching from writing donor files to geneinfo sorting"

ruby mutationhandling/mutationfindermaster.rb
echo "made gene chunk files"


#read
