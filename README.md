
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lemonmarkets

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/lemonmarkets)](https://CRAN.R-project.org/package=lemonmarkets)
[![R-CMD-check](https://github.com/quantargo/lemonmarkets/workflows/R-CMD-check/badge.svg)](https://github.com/quantargo/lemonmarkets/actions)
<!-- badges: end -->

The goal of lemonmarkets is to provide an R interface to the
[lemon.markets](https://lemon.markets) trading API.

## Installation

You can install the development version of lemonmarkets like so:

``` r
remotes::install_github("quantargo/lemonmarkets")
```

## Get Started

This is how you can get started with the lemonmarkets api:

``` r
library(lemonmarkets)
authenticate()
instr <- instruments_search("daimler")
head(instr)
#>           isin    wkn                      name                         title
#> 1 CA40638K1012 A2QNDZ      HALO COLLECTIVE INC.          HALO COLLECTIVE INC.
#> 2 FR0011344076 A1HBA3 AIR LIQUIDE FIN.12/21 MTN           AIR LIQUIDE FINANCE
#> 3 ES0105200002 A1JSBM    ABENGOA S.A.B EO-,0002                  ABENGOA S.A.
#> 4 XS0975256685 A1HRHJ  REPSOL INTL F. 13/21 MTN      REPSOL INTL FINANCE B.V.
#> 5 XS1118029633 A1ZQS4      WESFARMERS 14/21 MTN               WESFARMERS LTD.
#> 6 NL0009690221 A1J01T  VANECK GL.EQUAL W UC.ETF VANECK GL.EQUAL WEIGHT UC.ETF
#>   symbol  type            venues.name venues.title venues.mic venues.is_open
#> 1    A9K stock Börse München - Gettex       Gettex       XMUN           TRUE
#> 2         bond Börse München - Gettex       Gettex       XMUN           TRUE
#> 3   AYO2 stock Börse München - Gettex       Gettex       XMUN           TRUE
#> 4   RPJH  bond Börse München - Gettex       Gettex       XMUN           TRUE
#> 5         bond Börse München - Gettex       Gettex       XMUN           TRUE
#> 6   T6ET   etf Börse München - Gettex       Gettex       XMUN           TRUE
#>   venues.tradable venues.currency
#> 1           FALSE             EUR
#> 2           FALSE             EUR
#> 3           FALSE             EUR
#> 4           FALSE             EUR
#> 5           FALSE             EUR
#> 6           FALSE             EUR
```
