csr <- read.csv("seq.csr.csv")
no_csr <- read.csv("seq.nocsr.csv")

speedup = no_csr$Mean / csr$Mean
speedup
mean(speedup)

gm <- exp(mean(log(speedup)))
print(paste("Geo. Mean of speedups:", gm, "%"))
