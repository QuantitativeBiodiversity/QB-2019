################################################################################
#                                                                              #
# MothurTools Functions Source Code                                            #
#                                                                              #
################################################################################
#                                                                              #
# Written by: Mario Muscarella                                                 #
#                                                                              #
# Last update: 2015/02/22                                                      #
#                                                                              #
################################################################################
#                                                                              #
# Notes: This code provides numerous functions to be used in the analysis of   #
#        16S rRNA sequence data post mothur anlaysis                           #
#                                                                              #
# Issues: Slow performance reading in OTU tables (common R issue)              #
#                                                                              #
# Recent Changes:                                                              #
#                                                                              #
# Future Changes (To-Do List):                                                 #
#         1. Design functions to work with shared files in memory              #
#         2. Add warnings                                                      #
#                                                                              #
################################################################################

require("reshape")||install.packages("reshape");require("reshape")

# Import OTU Site-by-Species Matrix
read.otu <- function(shared = " ", cutoff = "0.03"){
  matrix <- read.table(shared, header=T, fill=TRUE, comment.char="", sep="\t")
  matrix.cutoff <- subset(matrix, matrix$label == cutoff)
  matrix.out    <- as.matrix(matrix.cutoff[1:dim(matrix.cutoff)[1],
                                           4:(3+mean(matrix.cutoff$numOtus))])
  row.names(matrix.out) <- matrix.cutoff$Group
  return(matrix.out)
  }

# Import Taxonomy Information
read.tax <- function(taxonomy = " ", format = "rdp"){
  tax_raw <- read.delim(taxonomy)                 # load genus-level data
  if (format == "rdp"){
    tax <- cbind(OTU = tax_raw[,1],colsplit(tax_raw[,3], split="\\;",
               names=c("Domain","Phylum","Class","Order","Family","Genus")))
    for (i in 2:7){
      tax[,i] <- gsub("\\(.*$", "", tax[,i])
    }
  } else {
    stop("This funciton currently only works for RDP taxonomy")
  }
  return(tax)
}
