library(rmarkdown)
render("whatsaplace.Rmd",output_dir="outputs")
system("mupdf outputs/whatsaplace.pdf")
