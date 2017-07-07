#!/bin/sh
#this runs the entire directory of programs from inside of here

$ -N test1
$ -l h_vmem=10G
$ -l h_rt=3:00:00
$ -w e 
$ -pe shm 1
$ -m eas
$ -M esnakemaster1@gmail.com
$ -o /srv/gsfs0/internship_files/patientfilewriter/output.txt
$ -e /srv/gsfs0/internship_files/patientfilewriter/errors.txt
$ -cwd

#use the next lines when on the cluster
$ module load ruby/1.8.7
$ module load samtools/1.4

#echo "making individual patient files"
#cd 'c:/users/esnak/documents/internship_files'
#echo "type the data file name ie: data.vcf"
$ ruby patientfilecreator/patientfilecreatormaster.rb
#sleep 3 
#clear



#echo "switching from writing donor files to geneinfo sorting"

$ ruby mutationhandling/mutationfindermaster.rb
#echo "made gene chunk files"



$ samtools 

#read
