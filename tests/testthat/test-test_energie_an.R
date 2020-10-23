##TODO : ECRIRE AUSSI LES TESTS POUR LA PRODUCTION ET OU LES 
##EPCIS DEPARTEMENTS ET COMMUNES

test_that('ok pour les regions, consommation',
    expect_equal_to_reference(
          get_energie_an_maille(
            annee = 2017,
            maille = 'region',
            nom_maille = 'Bretagne',
            prod = FALSE)
          
    ,'conso_region_2017_bretagne.RDS')
)

test_that('ok pour les departements, production',{
          
          result <-   get_energie_an_maille(
            annee = 2018,
            maille = 'departement',
            nom_maille = 'Doubs',
            prod = TRUE)
          
          expect_equal(ncol(result), 18)
          expect_equal(nrow(result), 3)
          expect_equal(unique(result$nom_departement) 
                       ,'Doubs')
          expect_equal(unique(result$annee), '2018')
})
          

test_that('erreur si maille incorrecte',{
  expect_error(
    get_energie_an_maille(
      annee = 2018,
      maille = 'coucou',
      nom_maille = 'CA Amiens Métropole',
      prod = FALSE)
  )
} ) 



 
test_that("ok si maille en majuscule", {
  ####todo
  expect_equal(2+2,4)
})
