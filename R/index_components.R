#' Get All components from a specified Index
#'
#' Currently, only the DAX index is supported
#' @param index_name character; Specified Index.
#' @importFrom tibble tribble
#' @export
index_components <- function(index_name = "DAX") {
  index_name <- match.arg(index_name)
  out <- NULL
  if (index_name == "DAX") {
    out <- tribble(
      ~Symbol,                                 ~Company.Name, ~ISIN,
      "DPW.DE",                            "Deutsche Post AG", "DE0005552004",
      "DWNI.DE",                          "Deutsche Wohnen SE", "DE000A0HN5C6",
      "IFX.DE",                    "Infineon Technologies AG", "DE0006231004",
      "ENR.DE",                           "Siemens Energy AG", "DE000ENER6Y0",
      "DTE.DE",                         "Deutsche Telekom AG", "DE0005557508",
      "LIN.DE",                                   "Linde plc", "IE00BZ12WP82",
      "HEI.DE",                         "HeidelbergCement AG", "DE0006047004",
      "SIE.DE",                  "Siemens Aktiengesellschaft", "DE0007236101",
      "ALV.DE",                                  "Allianz SE", "DE0008404005",
      "BMW.DE", "Bayerische Motoren Werke Aktiengesellschaft", "DE0005190003",
      "RWE.DE",                      "RWE Aktiengesellschaft", "DE0007037129",
      "DB1.DE",                          "Deutsche Boerse AG", "DE0005810055",
      "SHL.DE",                     "Siemens Healthineers AG", "DE000SHL1006",
      "FME.DE",        "Fresenius Medical Care AG & Co. KGaA", "DE0005785802",
      "MRK.DE",      "MERCK Kommanditgesellschaft auf Aktien", "DE0006599905",
      "FRE.DE",                     "Fresenius SE & Co. KGaA", "DE0005785604",
      "BAYN.DE",                    "Bayer Aktiengesellschaft", "DE000BAY0017",
      "ZAL.DE",                                  "Zalando SE", "DE000ZAL1111",
      "PUM.DE",                                     "PUMA SE", "DE0006969603",
      "BAS.DE",                                     "BASF SE", "DE000BASF111",
      "AIR.DE",                                   "Airbus SE", "NL0000235190",
      "SY1.DE",                                  "Symrise AG", "DE000SYM9999",
      "CON.DE",              "Continental Aktiengesellschaft", "DE0005439004",
      "MTX.DE",                         "MTU Aero Engines AG", "DE000A0D9PT0",
      "DHER.DE",                            "Delivery Hero SE", "DE000A2E4K43",
      "ADS.DE",                                   "adidas AG", "DE000A1EWWW0",
      "HFG.DE",                               "HelloFresh SE", "DE000A161408",
      "VOW3.DE",                               "Volkswagen AG", "DE0007664039", # or "DE0007664005"?
      "DBK.DE",            "Deutsche Bank Aktiengesellschaft", "DE0005140008",
      "1COV.DE",                                 "Covestro AG", "DE0006062144"
    )

  }

  out
}
