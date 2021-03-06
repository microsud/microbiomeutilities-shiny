#' @title Summarize the percent taxa classification for phyloseq
#' @description Summarize the percent taxa classification for \code{\link{phyloseq-class}}.
#' @param x \code{\link{phyloseq-class}} object
#' @return table with information on percent OTUs classified.
#' @import utils
#' @importFrom stats TukeyHSD
#' @importFrom stats aov
#' @importFrom stats terms
#' @importFrom stats wilcox.test
#' @importFrom stats aggregate
#' @importFrom stats as.dist
#' @importFrom stats coef
#' @importFrom stats cor
#' @importFrom stats cor.test
#' @importFrom stats density
#' @importFrom stats dist
#' @importFrom stats dnorm
#' @importFrom stats hclust
#' @importFrom stats kernel
#' @importFrom stats lm
#' @importFrom stats loess
#' @importFrom stats loess.control
#' @importFrom stats median
#' @importFrom stats na.fail
#' @importFrom stats na.omit
#' @importFrom stats p.adjust
#' @importFrom stats pnorm
#' @importFrom stats predict
#' @importFrom stats quantile
#' @importFrom stats rnorm
#' @importFrom stats sd
#' @importFrom stats time
#' @importFrom stats var
#' @importFrom stats frequency
#' @export
#' @author Contact: Sudarshan A. Shetty \email{sudarshanshetty9@@gmail.com}
#' @examples \dontrun{
#'   # Example data
#'     library(microbiomeutilities)
#'     data("biogeogut")
#'     pseq <- biogeogut
#'     percent_classified(pseq)
#'     
#'           }
#' @keywords utilities
percent_classified <- function(x)
{
  
  ta <- ld <- ldna <- lp <- lpna <- lc <- lcna <- lo <- lona <- lf <- lfna <- lg <- lgna <- ls <- lsna <- df1 <- df2 <- NULL
  
  ta <- as.data.frame.matrix(tax_table(x))
  
  message("Only patterns such as [g__] or similar is expected. [g__<empty>] or similar not considered\n
          please convert for eg. g__unclassified to uniform [g__]")
  
  tax_table(x)[is.na(tax_table(x)[,1])] <- "k__"
  tax_table(x)[is.na(tax_table(x)[,2])] <- "p__"
  tax_table(x)[is.na(tax_table(x)[,3])] <- "c__"
  tax_table(x)[is.na(tax_table(x)[,4])] <- "o__"
  tax_table(x)[is.na(tax_table(x)[,5])] <- "f__"
  tax_table(x)[is.na(tax_table(x)[,6])] <- "g__"
  tax_table(x)[is.na(tax_table(x)[,7])] <- "s__"
  
  ############################### DOMAIN######################
  
  if (colnames(ta[1]) == "Domain")
  {
    
    ld <- length(grep("k__$", ta$Domain, value = TRUE))
    ldna <- length(anyNA(ta$Domain))
    
    lev1 <- paste0(signif(((nrow(ta)) - (ld + ldna))/(nrow(ta)) * 
                            100), " %")
  } else if (colnames(ta[1]) == "Kingdom")
  {
    ld <- length(grep("k__$", ta$Kingdom, value = TRUE))
    ldna <- length(anyNA(ta$Kingdom))
    
    lev1 <- paste0(signif(((nrow(ta)) - (ld + ldna))/(nrow(ta)) * 
                            100), " %")
  } else
  {
    
    stop(paste("First rank name must be either Kingdom or Domain now it is =", rank_names(x)[1]))
  }
  
  ############################## PHYLUM#######################
  
  
  lp <- length(grep("p__$", ta$Phylum, value = TRUE))
  lpna <- length(anyNA(ta$Phylum))
  
  lev2 <- paste0(signif(((nrow(ta)) - (lp + lpna))/(nrow(ta)) * 
                          100), " %")
  
  ############################ CLASS########################
  
  lc <- length(grep("c__$", ta$Class, value = TRUE))
  lcna <- length(anyNA(ta$Class))
  
  lev3 <- paste0(signif(((nrow(ta)) - (lc + lcna))/(nrow(ta)) * 
                          100), " %")
  
  ############################ ORDER#########################
  
  lo <- length(grep("o__$", ta$Order, value = TRUE))
  lona <- length(anyNA(ta$Order))
  
  lev4 <- paste0(signif(((nrow(ta)) - (lo + lona))/(nrow(ta)) * 
                          100), " %")
  
  
  ########################## FAMILY###########################
  
  lf <- length(grep("f__$", ta$Family, value = TRUE))
  lfna <- length(anyNA(ta$Family))
  
  lev5 <- paste0(signif(((nrow(ta)) - (lf + lfna))/(nrow(ta)) * 
                          100), " %")
  
  ######################### GENUS###########################
  
  lg <- length(grep("g__$", ta$Genus, value = TRUE))
  lna <- length(anyNA(ta$Genus))
  
  lev6 <- paste0(signif(((nrow(ta)) - (lg + lna))/(nrow(ta)) * 
                          100), " %")
  
  ########################## SPECIES###########################
  
  if (ncol(ta) == 7)
  {
    ls <- length(grep("s__$", ta$Species, value = TRUE))
    lsna <- length(anyNA(ta$Species))
    
    lev7 <- paste0(signif(((nrow(ta)) - (ls + lsna))/(nrow(ta)) * 
                            100), " %")
    
    df1 <- data.frame(`Domain/Kingdom` = lev1, Phylum = lev2, 
                      Class = lev3, Order = lev4, Family = lev5, Genus = lev6, 
                      Species = lev7, `OTUs/ASVs` = nrow(ta))
    df1 <- t(df1)
    colnames(df1) <- "Percent_classified"
    return(as.data.frame.matrix(df1))
  } else
  {
    
    df2 <- data.frame(`Domain/Kingdom` = lev1, Phylum = lev2, 
                      Class = lev3, Order = lev4, Family = lev5, Genus = lev6, 
                      `OTUs/ASVs` = nrow(ta))
    df2 <- t(df2)
    colnames(df2) <- "Percent_classified"
    return(as.data.frame.matrix(df2))
  }
  

  ##################################################### 
  
  
}