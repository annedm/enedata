#' Récupération des données de consommation électrique annuelle
#' d'une commune
#'
#' @param annee entier, annee a recuperer (si missing, toutes)
#' @param verbose booleen qui indique si on print l'url
#' @param with_coord booleen, est ce qu'on doit récupérer les coordonnées
#'
#' @return data frame avec en ligne les données de consommation par commune x segment de clientèle
#' @export
#' @examples
#' get_conso_an_commune(annee = 2016, commune = 'Valenciennes')
#' get_conso_an_commune( commune = 'paris')

get_conso_an_commune <- function(annee,
                                 commune ,
                                 with_coord = FALSE,
                                 verbose = FALSE){
  
  
  ## check des arguments : TODO
  
  
  ## DANS UN SECOND TEMPS :TODO mise en forme de la commune ('paris' doit passer) 
  commune <- clean_name(commune)
  
  ##TODO : changer l url pour recuperer la bonne ville  et la bonne annee (ici c'est lille)
  ##l url initiale 
  adr <- 'https://data.enedis.fr/api/records/1.0/search/?dataset=consommation-electrique-par-secteur-dactivite-commune&q=&rows=-1&refine.nom_commune=Valenciennes'
   

  if(verbose){
    print(paste0('Recuperation de l url : ', adr))
  }
  
  
  
  brut <- GET(adr)
  
  ##TODO: arret si il y a une erreur
  # utiliser httr::status
  
  ##extraction du contenu et mise sous forme de dataframe
  contenu <- brut$content
  
  liste <- fromJSON(rawToChar(contenu))
  
  ## TODO: supprimer les variables qui contiennent les geom.coordinates 
  ##si pas demande 
  df_conso <- lapply(liste$records
                     ,FUN = function(rec){
                       
                       out <- as.data.frame(rec$fields) %>%
                         mutate_if(is.factor, as.character)
                      
                       
                       out
                     }) %>% bind_rows()
  
  ## TODO warning si aucune donnees recuperee
 
  
  df_conso
  
}