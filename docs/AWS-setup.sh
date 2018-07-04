## step 1) login to console, sudo su, open R
## install packages from Setup
## for topic models, run: sudo apt-get install libgsl0-dev

# deleting previous users

for i in 0{1..9} {10..50}
do
	userdel -r user$i
done

# creating new users

for i in 0{1..9} {10..50}
do
	adduser --quiet --disabled-password --shell /bin/bash --home /home/upf$i --gecos "User" upf$i
	echo "upf$i:password$i" | chpasswd
done

# copying files and changing permissions
for i in 0{1..9} {10..50}
do
	mkdir /home/upf$i/code
	mkdir /home/upf$i/data
	cp /home/rstudio/code/* /home/upf$i/code/
	cp /home/rstudio/data/* /home/upf$i/data/	
	sudo chown upf$i -R /home/upf$i/
done	


# solutions challenge 1
for i in 0{1..9} {10..50}
do
	cp /home/rstudio/code/challenge1-solutions.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge1-solutions.html /home/upf$i/code/
	sudo chown upf$i -R /home/upf$i/
done

# materials day 2
for i in 0{1..9} {10..50}
do
	cp /home/rstudio/code/04-dictionary-methods.Rmd /home/upf$i/code/
	cp /home/rstudio/code/05-supervised-learning.Rmd /home/upf$i/code/
	cp /home/rstudio/code/06-advanced-supervised-learning.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge2.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge3.Rmd /home/upf$i/code/
	cp /home/rstudio/data/FB-UK-parties.csv /home/upf$i/data/
	cp /home/rstudio/data/incivility.csv /home/upf$i/data/
	cp /home/rstudio/data/liwc-dictionary.csv /home/upf$i/data/
	cp /home/rstudio/data/UK-tweets.csv /home/upf$i/data/
	sudo chown upf$i -R /home/upf$i/
done

# solutions challenge 2
for i in 0{1..9} {10..50}
do
	cp /home/rstudio/code/challenge2-solutions.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge2-solutions.html /home/upf$i/code/
	sudo chown upf$i -R /home/upf$i/
done


# solutions challenge 3
for i in 0{1..9} {10..50}
do
	cp /home/rstudio/code/challenge3-solutions.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge3-solutions.html /home/upf$i/code/
	sudo chown upf$i -R /home/upf$i/
done


# materials day 3
for i in 0{1..9} {10..50}
do
	cp /home/rstudio/code/07-text-discovery.Rmd /home/upf$i/code/
	cp /home/rstudio/code/08-topic-models.Rmd /home/upf$i/code/
	cp /home/rstudio/code/09-advanced-topic-models.Rmd /home/upf$i/code/
	cp /home/rstudio/code/09-advanced-topic-models.Rmd /home/upf$i/code/
	cp /home/rstudio/code/10-networks-intro.Rmd /home/upf$i/code/
	cp /home/rstudio/code/11-networks-discovery.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge4.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge5.Rmd /home/upf$i/code/
	cp /home/rstudio/data/recsm-nodes.csv /home/upf$i/data/
	cp /home/rstudio/data/recsm-edges.csv /home/upf$i/data/
	cp /home/rstudio/data/nytimes.csv /home/upf$i/data/
	cp /home/rstudio/data/GOT-edges.csv /home/upf$i/data/
	cp /home/rstudio/data/congress-twitter-network-edges.csv /home/upf$i/data/
	cp /home/rstudio/data/congress-twitter-network-nodes.csv /home/upf$i/data/
	sudo chown upf$i -R /home/upf$i/
done


# solutions challenge 4
for i in 0{1..9} {10..50}
do
	cp /home/rstudio/code/challenge4-solutions.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge4-solutions.html /home/upf$i/code/
	sudo chown upf$i -R /home/upf$i/
done


# solutions challenge 5
for i in 0{1..9} {10..50}
do
	cp /home/rstudio/code/challenge5-solutions.Rmd /home/upf$i/code/
	cp /home/rstudio/code/challenge5-solutions.html /home/upf$i/code/
	sudo chown upf$i -R /home/upf$i/
done