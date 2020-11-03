#' Récupération des données de consommation électrique annuelle
#' d'une commune
#'
#' @param annee entier, annee a recuperer (si missing, toutes)
#' @param commune character, commune a recuperer
#' @param verbose booleen qui indique si on print l'url
#' @param with_coord booleen, est ce qu'on doit récupérer les coordonnées
#'
#' @return data frame avec en ligne les données de consommation par commune x segment de clientèle
#' @export
#' @importFrom assertthat assert_that
#' @importFrom httr GET http_error http_status
#' @importFrom rjson fromJSON
#' @import dplyr
#' @import magrittr
#' @examples
#' get_conso_an_commune(annee = 2016, commune = 'Valenciennes')
#' get_conso_an_commune( commune = 'paris')

get_conso_an_commune <- function(annee,
                     commune ,
                     with_coord = FALSE,
                     verbose = FALSE){
  

  ##check des arguments
  if (!missing(annee)){
    assert_that(as.integer(annee) == annee)
    
  }
   assert_that(is.character(commune))
  assert_that(length(commune) == 1)
  
  ## mise en forme de la commune
  commune <- clean_name(commune)
  
  ##l url initiale
  adr <- 'https://data.enedis.fr/api/records/1.0/search/?dataset=consommation-electrique-par-secteur-dactivite-commune&q=&rows=-1'
  
  
  adr <- paste0(adr, '&refine.nom_commune=', commune)
  
  if (!missing(annee)){
    adr <- paste0(adr, '&refine.annee=', as.character(annee))
  }
  
  if(verbose){
    print(paste0('Recuperation de l url : ', adr))
  }
  
  
  
  brut <- GET(adr)
  
  ##arret si il y a une erreur
  if(http_error(brut)){
    stop(http_status(brut))
  }
  
  ##extraction du contenu et mise sous forme de dataframe
  contenu <- brut$content
 
  liste <- fromJSON(rawToChar(contenu))

  df_conso <- lapply(liste$records
                     ,FUN = function(rec){
                       
                       out <- as.data.frame(rec$fields) %>%
                         mutate_if(is.factor, as.character)
                       
                       if (!with_coord){
                         out <- out %>% select(-contains('geom.coord'))
                       }
                       
                       out
                     }) %>% bind_rows()
  
  ##warning si aucune donnees recuperee
  if(nrow(df_conso) == 0){
    warning('Pas de donnees recuperees')
  }
  
  df_conso
  
}