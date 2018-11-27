# make figures showing the ugly and tidy Excel files for Activity 1

library(broman)

# read data
ugly <- read.table("example_ugly.csv", sep=",",
                 header=FALSE, stringsAsFactors=FALSE,
                 blank.lines.skip=FALSE,
                 colClasses=character())

# restore two blank lines
ugly <- rbind(rep("", ncol(ugly)),
              ugly[1:5,],
              rep("", ncol(ugly)),
              ugly[-(1:5),])


pdf("../Figs/spreadsheet_ugly.pdf", height=6, width=8, pointsize=14)
excel_fig(ugly, col_names=FALSE)
dev.off()

tidy <- read.csv("example_tidy.csv",
                 header=TRUE, stringsAsFactors=FALSE,
                 colClasses=character())

pdf("../Figs/spreadsheet_tidy.pdf", height=5, width=8, pointsize=12)
excel_fig(tidy[1:9,])
dev.off()

## Fig 2A from data org paper
# "fill in all the cells"
pdf("../Figs/spreadsheet_fill_in_all_cells.pdf", height=5, width=8, pointsize=14)
mat <- data.frame(id=101:107,
                  date=c("2015-06-14", "", "2015-06-18", "", "", "2015-06-20", ""),
                  glucose=myround(c(149.3, 95.3, 97.5, 117.0, 108.0, 149.0, 169.4), 1),
                  stringsAsFactors=FALSE)
excel_fig(mat, cellwidth=110, mar=rep(0.6, 4))
dev.off()


## Fig 5A from data org paper
# "make it a rectangle"
pdf("../Figs/spreadsheet_make_rectangle.pdf", height=5, width=8, pointsize=14)
mat <- data.frame(id=101:105,
                  sex=sample(c("Male", "Female"), 5, replace=TRUE),
                  glucose=myround(runif(5, 70, 150), 1),
                  insulin=myround(runif(5, 0.5, 1.5), 2),
                  triglyc=myround(runif(5, 70, 300), 1),
                  stringsAsFactors=FALSE)
mat2 <- t(mat)
mat2 <- cbind(rownames(mat2), mat2)
mat2 <- rbind(rep("", 6),
              mat2[1:2,],
              rep("", 6),
              mat2[c(1,3),],
              rep("", 6),
              mat2[c(1,4),])
mat2[c(2,5,8),1] <- ""
excel_fig(mat2, col_names=FALSE, mar=rep(0.6, 4))
dev.off()

## Fig 5C from data org paper
# "no calculations with the raw data"
pdf("../Figs/spreadsheet_no_calculations.pdf", height=6, width=8, pointsize=14)
mat4 <- rbind(rep("", 7),
              c("Date", "11/3/14", rep("", 5)),
              c("Days on diet", "126", rep("", 5)),
              c("Mouse #", "43", rep("", 5)),
              c("sex", "f", rep("", 5)),
              c("experiment", "", "values", "", "", "mean", "SD"),
              c("control", "", 0.186, 0.191, 1.081, "", ""),
              c("treatment A", "", 7.414, 1.468, 2.254, "", ""),
              c("treatment B", "", 9.811, 9.259, 11.296, "", ""),
              rep("", 7),
              c("fold change", "", "values", "", "", "mean", "SD"),
              c("treatment A", "", 7.414, 1.468, 2.254, "", ""),
              c("treatment B", "", 9.811, 9.259, 11.296, "", ""))

for(i in 7:9) {
    # calc mean and SD
    x <- as.numeric(mat4[i, 3:5])
    mat4[i,6] <- round(mean(x), 2)
    mat4[i,7] <- round(sd(x), 2)

    if(i > 7) {
      # fold change
      y <- as.numeric(mat4[7, 3:5])
      z <- x/mean(y)
      mat4[i+4,3:5] <- round(z, 2)
      mat4[i+4,6] <- round(mean(z), 2)
      mat4[i+4,7] <- round(sd(z), 2)
    }
}
excel_fig(mat4, cellwidth=c(90, 105, 95, rep(90, 5)),
          mar=rep(0.6, 4))
dev.off()

## Fig 7 from data org paper
# "use one header row"
pdf("../Figs/spreadsheet_one_header.pdf", height=4, width=9, pointsize=10)
mat6 <- rbind(c("", "", "week 4", "", "", "week 6", "", "", "week 8", "", ""),
              c("Mouse ID", "SEX", rep(c("date", "weight", "glucose"), 3)),
              c("3005", "M", "3/30/2007",  19.3, 635.0, "4/11/2007",  31,   460.7, "4/27/2007",  39.6, 530.2),
              c("3017", "M", "10/6/2006",  25.9, 202.4, "10/19/2006", 45.1, 384.7, "11/3/2006",  57.2, 458.7),
              c("3434", "F", "11/22/2006", 26.6, 238.9, "12/6/2006",  45.9, 378.0, "12/22/2006", 56.2, 409.8),
              c("3449", "M", "1/5/2007",   27.5, 121.0, "1/19/2007",  42.9, 191.3, "2/2/2007",   56.7, 182.5),
              c("3499", "F", "1/5/2007",   19.8, 220.2, "1/19/2007",  36.6, 556.9, "2/2/2007",   43.6, 446.0))

excel_fig(mat6, cellwidth=c(85, 85, 85, 105, 85, 95, 105, 85, 95, 105, 85, 95),
          fig_width=780, fig_height=150, col_names=FALSE, mar=rep(0.6, 4))
dev.off()
