# ## ------------------------------------------------------------------------
# # clear up the environment
# rm(list = ls())
# #clear the console
# cat("\f")
# 
# ## ------------------------------------------------------------------------
# for(i in 1:10){
#   print(i)
# }
# 
# ## ------------------------------------------------------------------------
# x <- c("apples", "oranges", "bananas", "strawberries")
# 
# for (i in seq(x)) {
#     print(x[i])
# }
# 
# ## ------------------------------------------------------------------------
# if (!require("stringr")) install.packages("stringr")
# library(stringr)
# 
# for (i in seq(x)) {
#     print(str_sub(x[i],1,-2))
# }

## ------------------------------------------------------------------------
set.seed(6)
digital.jelly <- round(rlnorm(n = 20, meanlog = 5 ))
digital.jelly <- sort(digital.jelly,decreasing = T)
names(digital.jelly) <- paste0("species.",LETTERS[seq(digital.jelly)])
plot(digital.jelly, log='y')

## ------------------------------------------------------------------------
sample.community <- function (x,n){
  survey <- sample(seq(x),size = n, replace = T,prob = x)
  survey.sum <- rep(0, length(x))
  for (i in survey){
    survey.sum[i]<-survey.sum[i]+1
  }
  return(survey.sum)
}

## ------------------------------------------------------------------------
# Functions from alpha diversity handout
S.obs <- function(x = ""){
  rowSums(x > 0) * 1
}

S.chao1 <- function(x = ""){
  S.obs(x) + (sum(x == 1)^2) / (2 * sum(x == 2))
}

## ------------------------------------------------------------------------
S.true <- length(digital.jelly)
plot(0, t="n", xlim=c(S.true/2, 1.5*S.true), ylim=c(S.true/2, 1.5*S.true), 
     xlab="S.obs", ylab="S.chao1")
abline(h=S.true,v = S.true, col="red")
N <- 150
for ( i in 1:100){
  sample.dj <- sample.community(digital.jelly,N)
  x<-S.obs(t(sample.dj))
  y<-S.chao1(t(sample.dj))
  points(x,y)
}

## ------------------------------------------------------------------------

#Collectors curve
# S.observed as a function of N
#first take a single sample of N=100
N<-1000
sample.dj <- sample.community(digital.jelly,n = N)
#generate vector to store results
S.collectors <- rep(NA, N)
#loop through 1:N and check S.obs
for (i in 1:N){
  current <-  sample.community(sample.dj,n = i)
  S.collectors[i] <- S.obs(t(current))
}

plot(1:N, S.collectors, xlab = "Sample size",ylab = "S.obs")

## ------------------------------------------------------------------------

