"# internship_files"
the data used currently is simple_somatic_mutation.open.BRCA-EU.vcf
  it is a large .vcf file, probably too big to load on a normal computer. However, using the 'less' command in cmd is one way too look at its format. the other way to see the first part of the file is in the smalldata file, smalldata.txt

however, to use another file: open patientfilecreatormaster.rb with a text editor and change the 'datafile' variable to whatever location you want(make sure it stays in quotes)

the file i'm using to run everything is SStoruneverything.sh, a shell script that calls and executes everything needed to run the programs. it is the call all master program

!!## WARNING ##!!
this program takes about an hour to run on a normal computer when using the smalldata file. do not try and run the original file on a normal computer. unless you wish to run it for 3+ hours non-stop

a lot of folders and files will appear in this directory
#################

the final product should appear in the directory you've run this from. I think I'll call it: 'mutatedsequence.sam' or something else depending on how it is formatted. however, since im not done yet, the file is absent.


#############################
the required programs/modules are ruby and samtools.
preferably  ruby 1.8.7+
            samtools 1.4+
            i think shell scripts run like a batch, no requirements there
 