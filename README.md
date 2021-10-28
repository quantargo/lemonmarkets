
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
[lemon.markets](https://lemon.markets) trading API. The API docs are
available at [docs.lemon.markets](https://docs.lemon.markets).

## Installation

You can install the development version of lemonmarkets like so:

``` r
remotes::install_github("quantargo/lemonmarkets")
```

## Get Started

Before you can get started with the lemonmarkets API you need to get an
API key from the [web page](https://www.lemon.markets). Currently there
is still a waitlist since the service is not publicly available yet.

After you acquired the API keys we recommend to create a new file
`.Renviron` within your R project directory and enter the keys there:

``` bash
LEMON_MARKETS_CLIENT_ID=<your-client-id>
LEMON_MARKETS_CLIENT_SECRET=<your-client-secret>
```

The `LEMON_MARKETS_CLIENT_ID` and `LEMON_MARKETS_CLIENT_SECRET` are then
available as environment variables within your R session. Alternatively,
you can also set the environment variables directly within the R session
as

``` r
Sys.setenv(LEMON_MARKETS_CLIENT_ID="<your-client-id>",
           LEMON_MARKETS_CLIENT_SECRET="<your-client-secret>")
```

Once you have set the environment variables you can load the
lemonmarkets package and get your access token through the `auth()`
function:

``` r
library(lemonmarkets)

auth()
```

All subsequent calls will use the resulting access token which is stored
in `options("LEMON_MARKETS_TOKEN")`.

Currenly, all trading operations are done through pre-defined
sub-accounts (spaces). These spaces need to be created via the web
fronted to retrieve its ID.

## Searching for an instrument

You can search for an instrument, like Daimler stock, through
`instrument_search()`:

``` r
instruments_search(list(search = "daimler", type = "stock"))
#>           isin    wkn                name      title symbol  type
#> 1 US2338252073 A2DKLU DAIMLER AG ADRS/1/4 DAIMLER AG   DAII stock
#> 2 DE0007100000 710000  DAIMLER AG NA O.N. DAIMLER AG    DAI stock
#>              venues.name venues.title venues.mic venues.is_open venues.tradable
#> 1 Börse München - Gettex       Gettex       XMUN           TRUE            TRUE
#> 2 Börse München - Gettex       Gettex       XMUN           TRUE            TRUE
#>   venues.currency
#> 1             EUR
#> 2             EUR
```

## Retrieving Market Data

To retrieve historical Open-High-Low-Close (OHCL) data for the German
Daimler listing you can use the `ohcl()` function:

``` r
ohcl("DE0007100000", from = Sys.Date() - 7, freq = "daily")
#>                      open  high   low close
#> 2021-10-21 02:00:00 81.25 82.61 80.70 81.64
#> 2021-10-22 02:00:00 81.61 82.91 81.61 81.96
#> 2021-10-25 02:00:00 82.19 83.75 81.99 83.10
#> 2021-10-26 02:00:00 83.00 83.92 82.80 83.01
#> 2021-10-27 02:00:00 82.85 84.05 82.24 83.27
#> 2021-10-28 02:00:00 83.21 83.71 82.68 83.65
```

The example above retrieves daily data for the last week. Also other
frequencies like like `hourly` and `min` (minute) are available.

Alternatively, you can also use `quotes()` to only retrieve the last
market quote for an instrument:

``` r
quotes("DE0007100000")
#>           isin b_v a_v     b     a          t  mic
#> 1 DE0007100000 239 239 83.61 83.63 2021-10-28 XMUN
```

## Get Current Cash Balance

The current cash balance of a specified space can be retrieved as

``` r
space_id <- "e44907b7-d131-4ec9-9647-a2649480003d"
bal <- balance(space_id)
```

## Place an Order

You can place an order with the `create_order()` function. To place a
market order of 5 shares for Daimler stock we can use

``` r
create_order(space_id, "DE0007100000", 5)
```

Note, that orders are immediatly activated per default. You can disable
this features through the parameter `activate=FALSE`.

## Get Current Portfolio

To get a list of the current portfolio we can use

``` r
portfolio(space_id)
#>    quantity average_price latest_total_value instrument.isin
#> 1         3      269.5000            808.500    DE000A1EWWW0
#> 2         8      107.9000            905.600    NL0000235190
#> 3         5      181.7000            908.500    DE000A0D9PT0
#> 4         8      115.1000            920.800    DE000SYM9999
#> 5        18       52.9000            950.400    DE0005552004
#> 6        16       59.7800            956.480    DE0005785802
#> 7         7      138.0800            966.560    DE0007236101
#> 8        24       40.6150            974.760    DE0005785604
#> 9        20       50.9875            984.598    DE000A0HN5C6
#> 10       62       16.5130            998.324    DE0005557508
#>               instrument.title
#> 1                    ADIDAS AG
#> 2                    AIRBUS SE
#> 3          MTU AERO ENGINES AG
#> 4                   SYMRISE AG
#> 5             DEUTSCHE POST AG
#> 6  FRESENIUS MEDICAL CARE KGAA
#> 7                   SIEMENS AG
#> 8      FRESENIUS SE & CO. KGAA
#> 9           DEUTSCHE WOHNEN SE
#> 10         DEUTSCHE TELEKOM AG
```

## Quantargo Workspace Trading Example

The link below contains a fully-functioning Quantargo workspace which
uses the package to daily re-balance a mean-reversion portfolio
strategy:

<https://www.quantargo.com/qbits/qbit-example-lemonmarkets-reversion-dax40?panel=viewer>

## Feedback

Please raise an issue through Github.
