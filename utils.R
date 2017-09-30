format_time_diff = function(x,y) {
  
  x.day = round_date(x, unit = "day")
  x.hour = round_date(x, unit = "hour")
  x.min = round_date(x, unit = "minute")
  
  y.day = round_date(y, unit = "day")
  y.hour = round_date(y, unit = "hour")
  y.min = round_date(y, unit = "minute")
  
  if (x.min == y.min) {
    
    output = difftime(x,y,units="secs") %>% as.numeric() %>% round(0) %>% paste0("s")
    
  } else if (x.hour == y.hour || (x.hour - y.hour) %>% as.integer() == 1) {
    
    output = difftime(x,y,units="mins") %>% as.numeric() %>% round(0) %>% paste0("m")
    
  } else if (x.day == y.day) {
    
    output = difftime(x,y,units="hours") %>% as.numeric() %>% round(0) %>% paste0("h")
    
  } else {
    
    output = difftime(x,y,units="days") %>% as.numeric() %>% round(0) %>% paste0("d")
    
  }
  
  return(output)
  
}
