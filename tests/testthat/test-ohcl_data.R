
test_that("ohcl_data", {
  comp <- head(index_components("DAX"), 5)
  for (i in comp$ISIN) {
    dat <- ohcl(i)
    expect_s3_class(dat, "zoo", exact = FALSE)
    expect_equal(colnames(dat), c("open", "high", "low", "close"))
    expect_true(all(apply(dat, 1, min) == dat[, "low"]))
    expect_true(all(apply(dat, 1, max) == dat[, "high"]))
  }
})
