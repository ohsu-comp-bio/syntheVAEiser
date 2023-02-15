packages <- c("circlize","GetoptLong","ComplexHeatmap","optparse")
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages],dependencies=TRUE,repos = "http://cran.us.r-project.org")
}
invisible(lapply(packages, library, character.only = TRUE))

option_list = list(
    make_option(c("-f", "--file"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-c", "--ftwo"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-o", "--out"), type="character", default="out.txt", 
              help="output file name [default= %default]", metavar="character"),
    make_option(c("-t", "--transpose"), type="character", action="store_true", 
              help="output file name [default= %default]", metavar="character")
); 
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

expr = read.table(opt$file, sep = "\t", header = TRUE)
expr_synth = read.table(opt$ftwo, sep = "\t", header = TRUE)


if (isTRUE(opt$transpose)){
    t(expr)
    t(expr_synth)
}

dim(expr)
expr_synth = expr_synth[0:40,]

dim(expr_synth)

#expr <- expr[order(expr$Labels),] 
#Labels = expr["Labels"]

expr$Labels <- 'STOCK'
expr_synth$Labels <- 'SYNTH'

ult <- rbind(expr,expr_synth)
new_ult = ult
Labels = ult["Labels"]


ult = ult[ ,  !names(expr) %in% c("Labels")]
ult = ult[!duplicated(expr[[1]]), ]
rownames(ult) = ult[[1]]
ult = ult[-1]
ult = as.matrix(ult)

ult = ult[apply(ult, 1, function(x) sum(x > 0)/length(x) > 0.5), , drop = FALSE]

#get_correlated_variable_genes = function(mat, n = nrow(mat), cor_cutoff = 0, n_cutoff = 0) {
#    ind = order(apply(mat, 1, function(x) {
#            q = quantile(x, c(0.1, 0.9))
#            x = x[x > q[1] & x < q[2]]
#            var(x)/mean(x)
#        }), decreasing = TRUE)[1:n]
#    mat2 = mat[ind, , drop = FALSE]
#    dt = cor(t(mat2), method = "spearman")
#    diag(dt) = 0
#    dt[abs(dt) < cor_cutoff] = 0
#    dt[dt < 0] = -1
#    dt[dt > 0] = 1
#
#    i = colSums(abs(dt)) > n_cutoff
#    mat3 = mat2[i, ,drop = FALSE]
#    return(mat3)
#}
#
#mat = get_correlated_variable_genes(expr, cor_cutoff = 0.5, n_cutoff = 20)

ult = t(apply(ult, 1, function(x) {
    q10 = quantile(x, 0.1)
    q90 = quantile(x, 0.9)
    x[x < q10] = q10
    x[x > q90] = q90
    scale(x)
}))

#colnames(mat2) = colnames(mat)
#dim(mat2)

#base_mean = rowMeans(expr)

ht_list = 
    #  row_split = Labels
    Heatmap(ult, col = colorRamp2(c(-1.5, 0, 1.5), c("blue", "white", "red")), 
    name = "scaled_expr", column_title = qq("relative expression for @{nrow(expr)} samples and @{ncol(expr)} genes"),
    show_column_names = FALSE, width = unit(8, "cm"),
    heatmap_legend_param = list(title = "Scaled expr"),show_row_names = FALSE, use_raster=TRUE) +   

    rowAnnotation(df=new_ult["Labels"])


pdf(opt$out)       
ht_list = draw(ht_list, main_heatmap = "scaled_expr")




