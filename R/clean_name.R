#' Nettoyage de chaine de caractères dans les noms de maille
#'
#' @param name character 
#'
#' @return chaine de caractère avec une majuscule en premier, plus d espace superflu
#' @export
#' @import magrittr
#' @importFrom stringr str_to_title str_trim str_replace str_replace_all
#' @examples
#' clean_name(' il y  a des espaces    en trop! ')
clean_name <- function(name){
  name <- name %>%
    str_replace_all(pattern ='\\s+', replacement = ' ') %>%
    str_trim() 
  
  ##mettre la premiere lettre seulement en majuscule
  name <- paste0(toupper(substr(name,1, 1)), substr(name, 2, nchar(name)))
         
  
  name
}
