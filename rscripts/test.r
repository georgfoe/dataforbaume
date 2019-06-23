library(dplyr)
library(readr)
library(ggplot2)
library(nlme)


## Bei Bedarf Daten runterladen


if (file.exists("data.raw/pop.ortsteile.RDS")) {
  
  df <- readRDS("data.raw/pop.ortsteile.RDS")

} else {

  df <- tibble()
  
  for (jahr in 2011:2018) {
  
    con <- sprintf("https://www.statistik-berlin-brandenburg.de/opendata/EWR_Ortsteile_%i-12-31.csv", jahr) %>% url()
    
    df.frag <- try(read_csv2(con, locale = locale(encoding = "latin1")), silent = TRUE)  
      
    if (!("try-error" %in% class(df.frag))) {
      df.frag$jahr = jahr
      df <- rbind(df, df.frag)
    }
    
  
  }
  
  df <- df %>% 
    rename(bezirk = `Bez-Name`, ortsteil = `Ortst-Name`)
  
  saveRDS(df, "data.raw/pop.ortsteile.RDS")

}