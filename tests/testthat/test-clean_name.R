test_that("ok pour les espaces", {
  expect_equal(clean_name(' il y  a des espaces    en trop! '),
               'Il y a des espaces en trop!')
})


test_that("ok pour les majuscules", {
  expect_equal(clean_name(' paris'),
               'Paris')
})


