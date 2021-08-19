### Common startup script for each chapter ###
### Aug 18 2021

### this is from R for EPI
# clear workspace
rm(list = ls(all = TRUE))



# dealing in advance with package conflicts:
library(conflicted)
#conflict_prefer('shift', 'spatstat', quiet = T)
conflict_prefer('filter', 'dplyr', quiet = T)
conflict_prefer('select', 'dplyr', quiet = T)
conflict_prefer("area", "spatstat.geom", quiet = T)


#load core packages
pacman::p_load(
  rio,
  here,
  tidyverse,
  sf,
  sp,
  tmap,
  huxtable
)


# Settings

options(scipen=1, digits=7)


### FUNCTIONS FOR CHAPTER BEGINNING ###
lo <- rio::import('../schedule-2021.xlsx', which = 'learning objectives')

print_learn_objective <- function(topic){
  lo %>%
    filter(Mod2 == topic) %>%
    as_hux() %>%
    select(3) %>%
    set_all_padding(2) %>%
    set_label('learning-ob') %>%
    set_caption('Learning objectives by weekly module') %>%
    set_bold(1, everywhere) %>%
    set_width(1) %>%
    set_wrap(TRUE) %>%
    theme_grey() 
}


print_vocab <- function(week){
  rio::import('vocabulary.xlsx') %>%
    filter(module == week) %>%
    arrange(Term) %>%
    select(-module) %>%
    as_hux() %>%
    set_all_padding(2) %>%
    set_caption(paste0('Vocabulary for Week ', week)) %>%
    set_bold(everywhere, 1) %>%
    set_width(.9) %>%
    #set_col_width(0.4, 0.6) %>%
    set_wrap(TRUE) %>%
    theme_blue() 
}



