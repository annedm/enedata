#' Récupération des données de consommation électrique annuelle
#' d'une région
#'
#' @param annee entier, annee a recuperer (si missing, toutes)
#' @param verbose booleen qui indique si on print l'url
#' @param with_coord booleen, est ce qu'on doit récupérer les coordonnées
#' @param region character, le nom de la région
#' @return data frame avec en ligne les données de consommation par region x segment de clientèle
#' @export
#' @importFrom assertthat assert_that
#' @importFrom httr GET http_error http_status
#' @importFrom rjson fromJSON
#' @import dplyr
#' @examples
#' get_conso_an_region(annee = 2016, region = 'Franche-Comté')
#' get_conso_an_region(region = 'Bourgogne')

get_conso_an_region <- function(annee,
                                 region ,
                                 with_coord = FALSE,
                                 verbose = FALSE){
  
  get_energie_an_maille(annee,
                        maille ='region',
                        nom_maille=region,
                        prod = FALSE,
                        verbose = FALSE,
                        with_coord = FALSE)
}