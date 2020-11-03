#' Fonction interne qui récupère l'énergie annuelle (conso ou prod) pour
#' une maille données (epci, nom_maille, departement, region)
#'
#' @param annee entier, annee a recuperer (si non fourni, toutes)
#' @param with_coord booleen, est ce qu'on doit récupérer les coordonnées
#' @param maille character (epci, nom_maille, departement, region, iris) : maille d'intérêt
#' @param nom_maille character, nom de la maille à récupérer
#' @param prod booleen qui indique si on récupère la conso (FALSE, defaut) ou la prod (TRUE)
#' @return data frame avec en ligne les données de consommation par nom_maille x segment de clientèle
#' @export
get_energie_an_maille <- function(
  annee,
  maille,
  nom_maille,
  prod = FALSE,
  verbose = FALSE,
  with_coord = FALSE){
  
  
  
  ##check des arguments : TODO
  if (!missing(annee)){
    assert_that(as.integer(annee) == annee)
  }
  assert_that(maille %in% c('departement','commune','region'))
  
  assert_that(class(prod) == 'logical')
  assert_that(is.character(nom_maille))
  assert_that(length(nom_maille) == 1)
  
  ## mise en forme de la nom_maille
  nom_maille <- clean_name(nom_maille)
  
  ###adaptation de l'url a ce qu on cherche
  
  ##l url initiale
  if (maille == 'commune'){
    adr <- 'https://data.enedis.fr/api/records/1.0/search/?dataset=consommation-electrique-par-secteur-dactivite-commune&q=&rows=-1'
    
  }
  if (maille == 'departement'){
    adr <- 'https://data.enedis.fr/api/records/1.0/search/?dataset=consommation-electrique-par-secteur-dactivite-departement&q=&rows=-1'
  }
  
  ## cas de la maille region 
  if (maille == 'region'){
    
  }
  
  if (prod){
    ##TODO: aller chercher les donnees de production au lieu des consos
  }
  
  ##dans tous les cas: adapter a la maille qu'on cherche 
  adr <- paste0(adr, '&refine.nom_', maille  ,'=', nom_maille)
  
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