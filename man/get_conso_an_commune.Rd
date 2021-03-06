% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_conso_an_commune.R
\name{get_conso_an_commune}
\alias{get_conso_an_commune}
\title{Récupération des données de consommation électrique annuelle
d'une commune}
\usage{
get_conso_an_commune(annee, commune, with_coord = FALSE, verbose = FALSE)
}
\arguments{
\item{annee}{entier, annee a recuperer (si missing, toutes)}

\item{commune}{character, le nom de la commune}

\item{with_coord}{booleen, est ce qu'on doit récupérer les coordonnées}

\item{verbose}{booleen qui indique si on print l'url}
}
\value{
data frame avec en ligne les données de consommation par commune x segment de clientèle
}
\description{
Récupération des données de consommation électrique annuelle
d'une commune
}
\examples{
get_conso_an_commune(annee = 2016, commune = 'Valenciennes')
get_conso_an_commune( commune = 'paris')
}
