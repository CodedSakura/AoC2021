data <- as.matrix(read.fwf("input.txt", widths=rep(1, 10)))
counter <- 0
for (i in 1:100) {
    data <- data+1
    while (any(data > 9)) {
        for (pos in which(data > 9)) {
            counter <- counter + 1
            pos.r <- (pos - 1) %% 10 + 1
            pos.c <- (pos - pos.r) / 10 + 1

            p.r <- (-1:1+pos.r)[(-1:1+pos.r) %in% 1:10]
            p.c <- (-1:1+pos.c)[(-1:1+pos.c) %in% 1:10]
            data[pos.r,pos.c] <- -1
            data[p.r,p.c] <- data[p.r,p.c] + sign(data[p.r,p.c])
        }
    }
    data <- apply(data, c(1, 2), function (x) ifelse(x < 0, 0, x))
}
cat(counter, "\n")