#exemple de recuperation des donnees de conso pour la ville de lille 
library(rjson)
library(httr)
library(dplyr)

adr <- 'https://data.enedis.fr/api/records/1.0/search/?dataset=consommation-electrique-par-secteur-dactivite-commune&q=&rows=-1&refine.nom_commune=Lille'

brut <- GET(adr)
brut
contenu <- brut$content
str(contenu)
liste <- fromJSON(rawToChar(contenu))
attributes(liste)
liste$records[[1]]

names(liste$records[[1]]$fields)

###suggestion de facon de remettre en forme les donnees 
df_conso <- lapply(liste$records
                   ,FUN = function(rec){
                     
                     as.data.frame(rec$fields) %>%
                       mutate_if(is.factor, as.character)
                   }) %>% bind_rows()

head(df_conso[,1:10])
