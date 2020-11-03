#' Nettoyage de chaine de caractères dans les noms de maille
#'
#' @param name character 
#'
#' @return chaine de caractère avec une majuscule en premier, plus d espace superflu
#' @export
#' @import stringr
#' @examples
#' clean_name(' il y  a des espaces    en trop! ')
clean_name <- function(name){
  
  ##supprimer les blancs en trop 
  name <- str_trim() %>% 
    str_replace_all(pattern = "\\s+", replacement = " ")
  
  ##mettre la premiere lettre seulement en majuscule
  substr(name, 1, 1) <- toupper(substr(name, 1, 1))
  
  name
}