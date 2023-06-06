# Expected prevalence in group 1
p1_values <- c(0.001,0.005,0.01,0.02,0.03,0.04,0.05,0.1)  

# Target significance level
sig.level <- 0.05 

# Desired power
power <- 0.90

# Difference in assumed prevalence rates for group 2 relative to group 1
# (p2 will equal p1_value + p2_value). This is done in the loop below.
p2_values <- p1_values

# generate the matrix
out <- matrix(data=NA,nrow=length(p1_values),ncol=length(p1_values))
for(i in 1:length(p1_values)) {
   p1 <- p1_values[i]
   for(j in 1:length(p2_values)) {
      p2 <- p1+p2_values[j]
      # this is our proportion test
      result <- power.prop.test(p1=p1,p2=p2, sig.level = sig.level, power = power)
      # return the estimated n
      out[i,j] <- result$n
   }
}

# round the results
out <- round(out)
# label the rows and columns
rownames(out) <- paste0(p1_values*100,"%")
colnames(out) <- paste0("p1 + ",p1_values*100,"%")
