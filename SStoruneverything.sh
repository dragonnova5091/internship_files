#!usr/bin/sh
#some tests
echo "making individual patient files"
cd 'c:/users/esnak/documents/internship_files'
echo "type the data file name ie: data.vcf"
ruby patientfilecreator/patientfilecreatormaster.rb

for $file in patientfiles/*
  $limits = ruby mutationhandling/mutationfindermaster.rb

  for $data in $limits
    samtools view HGenome.bam "{$data[0]}:{$data[1]}-{$data[2]}" > $normSeq
  done
done



read
