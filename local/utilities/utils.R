



# Reusable Functions ------------------------------------------------------


block_cont <- function(data, var, cols, digits = 1, pg = 1) {

    # Prepare formats
    fmtdg1 <- paste0("%.", digits, "f")
    fmtdg2 <- paste0("%.", digits + 1, "f")

    # Prepare statistics labels
    label <- c("n", "Mean", "SD", "Median", "Q1, Q3", "Min, Max")

    # Prepare stub columns
    stub <- data.frame(var, label, stringsAsFactors = FALSE)

    # Perform calculations
    ntbl <- table(data[["ARM"]][!is.na(data[[var]])])
    ngrp <- data.frame(Group.1 = names(ntbl), x = as.numeric(ntbl))
    meangrp <- aggregate(data[[var]], list(data[["ARM"]]), FUN = mean, na.rm = TRUE)
    sdgrp <- aggregate(data[[var]], list(data[["ARM"]]), FUN = sd, na.rm = TRUE)
    mediangrp <- aggregate(data[[var]], list(data[["ARM"]]), FUN = mean, na.rm = TRUE)
    q1grp <- aggregate(data[[var]], list(data[["ARM"]]), FUN = quantile, na.rm = TRUE, probs = .25)
    q3grp <- aggregate(data[[var]], list(data[["ARM"]]), FUN = quantile, na.rm = TRUE, probs = .75)
    mingrp <- aggregate(data[[var]], list(data[["ARM"]]), FUN = min, na.rm = TRUE)
    maxgrp <- aggregate(data[[var]], list(data[["ARM"]]), FUN = max, na.rm = TRUE)

    # Perform formatting
    nrw <- sprintf("%d", ngrp$x)
    meanrw <- sprintf(fmtdg1, meangrp$x)
    sdrw <- sprintf(fmtdg2, sdgrp$x)
    medianrw <- sprintf(fmtdg1, mediangrp$x)
    qrw <- sprintf(paste0(fmtdg1, ", ", fmtdg1), q1grp$x, q3grp$x)
    mrw <- sprintf("%d, %d", mingrp$x, maxgrp$x)

    # Turn statistics into its own data frame
    stats <- as.data.frame(rbind(nrw, meanrw, sdrw, medianrw, qrw, mrw))

    # Combine stub to statistics
    ret <- cbind(stub, stats)

    # Clear out row names
    rownames(ret) <- NULL

    # Reassign column names
    names(ret) <- c("var", "label", names(ntbl))

    ret$page <- pg

    return(ret)

}



block_cat <- function(data, var, cols, srt = NULL, digits = 1, pg = 1) {


    # Perform counts
    notmiss <- !is.na(data[[var]])
    pop <- table(data[["ARM"]][notmiss])
    vcnt <- aggregate(data[[var]][notmiss],
                      by = list(data[["ARM"]][notmiss], data[[var]][notmiss]),
                      FUN = length)

    # Prepare format
    dg <- max(nchar(as.character(pop)))
    fmtdg1 <- paste0("%", dg, "d ", "(%5.", digits, "f)")

    # Perform formatting
    vcnt$y <- sprintf(fmtdg1, vcnt$x,
                      (vcnt$x / pop[vcnt$Group.1]) * 100)

    # Select desired columns
    stats <- vcnt[ , c("Group.1", "Group.2", "y")]

    # Transpose
    res <- reshape(stats, timevar = "Group.1", idvar = c("Group.2"), direction = "wide")

    # Add var column
    res <- data.frame(var, res)

    # Clean up column and row names
    rownames(res) <- NULL
    names(res) <- c("var", "label", names(pop))

    for (nm in names(pop)) {

        res[[nm]] <- ifelse(is.na(res[[nm]]), sprintf(fmtdg1, 0, 0), res[[nm]])
    }


    if (!is.null(srt)) {

        # Deal with sorting
        res$label <- factor(res$label, levels = srt)
        res <- sort(res, by = c("label"))

    }

    res$page <- pg

    return(res)
}

