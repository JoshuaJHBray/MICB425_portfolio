install.packages("randomcoloR")
install.packages("pals")

library(tidyverse)
library(phyloseq)
library(ggplot2)
library(dplyr)
library(stringr)
library(magrittr)
library(knitr)
library(randomcoloR)

#Load the data
load("mothur_phyloseq.RData")
load("qiime2_phyloseq.RData")

plot_bar(mothur, fill="Phylum")

#Data Preparation
set.seed(4831)
q.norm = rarefy_even_depth(qiime2, sample.size=100000)
m.norm = rarefy_even_depth(mothur, sample.size=100000)
# Get percentages
m.percent = transform_sample_counts(m.norm, function(x) 100 * x/sum(x))
q.percent = transform_sample_counts(q.norm, function(x) 100 * x/sum(x))

phylum_name_mothur = "Chloroflexi"
phylum_name_qiime2 = "D_1__Chloroflexi"

# Taxa abundance
m.percent %>%
  plot_bar(fill="Phylum")+
  geom_bar(aes(fill=Phylum), stat="identity")+
  labs(title="Phyla across samples for mothur")+
  scale_fill_manual(values=col_vector)

n <- 40
palette <- distinctColorPalette(35)

