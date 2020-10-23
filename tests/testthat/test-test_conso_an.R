####TODO: FAIRE EN SORTE QUE LES TESTS DEJA ECRITS PASSENT
##COMPLETER LES TESTS VIDES 
library(stringr)


test_that("fonctionne si arguments ok", {
  expect_equal_to_reference(
    get_conso_an_commune(annee = 2019,
                 commune = 'Paris'),
    'resultat_paris.RDS'
  )
})

test_that("ok si annee non precisee", {
  
  result <- get_conso_an_commune(commune = 'Paris')
  
  annee_max <- as.numeric(max(unique(result$annee)))
  expect_equal(sort(unique(result$annee)),
               as.character(2011:annee_max))
  
  ref <- get_conso_an_commune(commune = 'Paris',annee = 2019)
  expect_equal(sort(colnames(result)), sort(colnames(ref)))
  
  ref <- ref[colnames(result)]
      expect_equivalent(
  ref,
  result %>% filter(annee == 2019)
  )
})

test_that("fonctionne si ville mal spécifiée", {
##TODO
  expect_equal(2+2,4)
})


test_that("warning si rien n'est trouvé", {
  expect_equal(2+2,4)
})




