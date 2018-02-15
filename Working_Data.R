#DAY 1
#install tidyverse using:
install.packages("tidyverse")

#Read in a table
read.table(file="Saanich.metadata.txt")

#Read in a table with added parameters
#Save it as an R object
metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t", na.strings="nan")

#Read in a new table with the Saanich.OTU file
Saanich.OTU = read.table(file="Saanich.OTU.txt", header=TRUE, row.names=1, sep="\t", na.strings="nan")

#Exercise 1

#Select Oxygen Data
metadata %>% 
  select(O2_uM)

#select all data with oxygen in it
metadata %>% 
  select(matches("O2|oxygen"))

#Filter samples to show only those without any oxygen
metadata %>% 
  filter(O2_uM == 0)

#Combine filter and select with a pipe
metadata %>%
  filter(O2_uM ==0) %>% 
  select(Depth_m)

#DAY 2
#install tidyverse using:
install.packages("tidyverse")
library(tidyverse)

#Exercise 2

#At what depths is methane<100 nM while Temp<10_C
metadata %>% 
  filter(CH4_nM > 100 & Temperature_C < 10) %>% 
  select(Depth_m, CH4_nM, Temperature_C)

#Mutate - creating new variables
metadata %>% 
  mutate(N2O_uM = N2O_nM/1000)

metadata %>% 
  mutate(N2O_uM = N2O_nM/1000) %>% 
  ggplot() + geom_point(aes(x=Depth_m, y=N2O_uM))

#PLOTTING DATA IN RSTUDIO
  #Feb 12 2018

#Load tidyverse
library(tidyverse)

#install phyloseq from Bioconductor
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq", type = "source")

#and load phyloseq
library(phyloseq)

#reload updated metadata
metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t", na.strings="nan")
OTU = read.table(file="Saanich.OTU.txt", header=TRUE, row.names=1, sep="\t", na.strings="nan")

#load phyloseq data
###THIS DOES NOT WORK?! 
load("phyloseq_object.RData")

#Error in readChar(con, 5L, useBytes = TRUE) : cannot open the connection
#In addition: Warning message:
#  In readChar(con, 5L, useBytes = TRUE) :
# cannot open compressed file 'phyloseq_object.RData', probable reason 'No such file or directory'

#Dot plots
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point()

#Dot plots with colour
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(color="blue")

#Dot plot with legend
ggplot(metadata, aes(x=O2_uM, y=Depth_m, size=OxygenSBE_V)) +
  geom_point()

#Exercise 1
  #SiO2 vs Depth, with purple triangles
ggplot(metadata, aes(x=SiO2_uM, y=Depth_m)) +
  geom_point(color="purple", shape=17)

#Exercise 2
  #Temperature_F vs Depth_m
metadata %>%
  mutate(Temperature_F = Temperature_C*9/5+32) %>% #Convert temperature to F and pipe it to ggplot
    ggplot(aes(x=Temperature_F, y=Depth_m)) +
      geom_point()

#ggplot with phyloseq
  ##Cannot do, do not have "phyloseq_object.RData"
  ##Added correct code anyways

#Plot phylum communites by depth
plot_bar(physeq, "Phylum")

#Transform samples to percentage and plot them
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))
plot_bar(physeq_percent, fill="Phylum")

#Plot it again without the separating bars
plot_bar(physeq_percent, fill="Phylum") + 
  geom_bar(aes(fill=Phylum), stat="identity")

#Exercise 3
plot_bar(physeq_percent, fill="Class") + 
  geom_bar(aes(fill=Class), stat="identity") +
  labs(x="Sample Depth", y="Percent relative abundance") +
  title="Class from 10 to 200 m in Saanich Inlet"

#Faceting
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum)

#Faceting, with independent scaling
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum, scales="free_y") +
  theme(legend.position="none")

#Exercise 4

metadata %>% 
  gather(Nutrient, uM, NH4_uM, NO2_uM, NO3_uM, O2_uM, PO4_uM, SiO2_uM) %>% 
  ggplot(aes(x=Depth_m, y=uM))+
  geom_point() +
  geom_line() +
  facet_wrap(~Nutrient, scales="free_y") +
  theme(legend.position="none")
  
