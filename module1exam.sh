# change to course directory
cd ~/Documents/cmdlntools/
### only run these if the file is still compressed
### unzip
#gunzip gencommand*.tar.gz
### untar
#tar -xvf gencommand*.tar
cd gencommand_proj1_data
ls

echo "How many chromosomes are there in the genome?"
grep ">" apple.genome | wc -l

echo "How many genes and transcript variants?"
echo "Genes: "
cut -f1 apple.genes | uniq | wc -l
echo "Variants: "
cut -f2 apple.genes | wc -l

echo "How many genes have a single variant?"
cut -f1 apple.genes | uniq -c | grep -c " 1 "

echo "How many genes have multiple variants?"
cut -f1 apple.genes | uniq -c | grep -v " 1 " | wc -l

echo "How many genes are there on each of the '+' and '-' strands?"
echo "+: "
cut -f1,4 apple.genes | grep "+" | uniq -c | wc -l
echo "-: "
cut -f1,4 apple.genes | grep "-" | uniq -c | wc -l

echo "How many genes (and transcripts) are there on each chromosome?"
CHRS=$(cut -f3 apple.genes | sort -u)
echo $CHRS

for chromosome in $CHRS; do
	echo $chromosome
	echo "Genes: "
	cut -f1,3 apple.genes | grep $chromosome | uniq -c | wc -l
	
	echo "Transcripts: "
	cut -f3 apple.genes | grep $chromosome | wc -l
done


echo "What genes are in common between condition A and condition B?"
cut -f1 apple.conditionA | sort -u > condAgenes
cut -f1 apple.conditionB | sort -u > condBgenes
echo "Genes in common: "
comm -1 -2 condAgenes condBgenes | wc -l
echo "How many genes are exclusively specific to condition A?"
comm -2 -3 condAgenes condBgenes | wc -l
echo "How many genes are exclusively specific to condition B?"
comm -1 -3 condAgenes condBgenes | wc -l

echo "How many genes are in common to all three conditions?"
cut -f1 apple.conditionC | sort -u > condCgenes
comm -1 -2 condAgenes condBgenes > ABgenes
comm -1 -2 ABgenes condCgenes | wc -l
