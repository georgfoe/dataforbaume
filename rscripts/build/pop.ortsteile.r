library(tidyverse)


output <- tibble()
  
  for (jahr in 2011:2018) {
  
    con <- sprintf("https://www.statistik-berlin-brandenburg.de/opendata/EWR_Ortsteile_%i-12-31.csv", jahr)
    
    df.frag <- try(read_csv2(con, locale = locale(encoding = "latin1")), silent = TRUE)  
      
    if (!("try-error" %in% class(df.frag))) {
      df.frag$jahr = jahr
      output <- rbind(output, df.frag)
    }
}
  
  output <- output %>% 
    rename(bezirk = `Bez-Name`, ortsteil = `Ortst-Name`)
  
output