# estimated prevalence in group 1
p1 <- 0.01
# estimated prevalence in group 2
p2 <- 0.04

# initial N
n <- 200

# sims
nSim <- 10000

# significance level
sigLevel <- 0.05

# power level
powerTarget <- 0.9

estimated_power <- 0
while(T) {
   cat("Testing n=",n,"\n")
   powers <- unlist(lapply(1:nSim,function(i) {
      # generate two random groups according to prevalence
      g1 <- rbinom(n,1,p1)
      g2 <- rbinom(n,1,p2)

      # compute statistical test
      result <- prop.test(c(sum(g1),sum(g2)),n=c(n,n))
      result$p.value
   }))

   estimated_power <- sum(powers<0.05,na.rm=T)/length(powers)

   if(estimated_power>=powerTarget) {
      break
   }
   n <- n + 10
}

cat("for prevalence of ",p1," and ",p2," n of ",n,"is suffice at power",powerTarget,"\n")
