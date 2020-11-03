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
  
  
  
  
  
}