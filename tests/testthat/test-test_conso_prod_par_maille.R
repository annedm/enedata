##TODO: FAIRE EN SORTE QUE LES TESTS DEJA ECRITS PASSENT
##COMPLETER AVEC DES TESTS POUR LES EPCIS ET LES DEPARTEMENTS

test_that("conso region", {
  expect_equal(
    getConsoAnRegion(annee = 2016, region = 'Bretagne'),
    getEnergieAnMaille(annee = 2016, nom_maille = 'Bretagne',
                          maille = 'region')
  )
    
})

test_that("conso region, sans annee", {
  expect_equal(
    getConsoAnRegion( region = 'Bretagne'),
    getEnergieAnMaille( nom_maille = 'Bretagne',
                          maille = 'region')
  )
  
})


test_that("prod region", {
  ##TODO/ completer
  expect_equal(2+2,4)
  
})
