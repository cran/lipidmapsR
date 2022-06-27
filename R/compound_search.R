#' A function for compound search
#'
#' @param input_item choose input item from the following options: "lm_id", "formula","inchi_key","pubchem_cid","hmdb_id","kegg_id","chebi_id","smiles","abbrev","abbrev_chains"
#' @param input_value input the value you want to search
#' @param output_item select your output from following options:"all","classification","lm_id","name","sys_name","synonyms","core","main_class","sub_class","class_level4","exactmass","formula","inchi","inchi_key","kegg_id","hmdb_id","chebi_id","lipidbank_id","pubchem_cid","smiles","molfile","structure","physchem"
#' @param output_format select your output format from following options: "json (default)","text"
#' @return The search results
#'
#'
#' @examples
#'
#' # Fetch compound name from LM_ID
#' compound_search("lm_id", "LMFA01010001", "name")
#'
#' # Fetch all compound fields from LM_ID
#' compound_search("lm_id", "LMFA01010001", "all")
#'
#' # Fetch all compound fields as text from LM_ID
#' compound_search("lm_id", "LMFA01010001", "all", "txt")
#'
#' # Fetch compound smiles from PubChem CID
#' compound_search("pubchem_cid", "985", "smiles")
#'
#' # Fetch compound sytematic name from inchi key
#' compound_search("inchi_key", "IPCSVZSSVZVIGE-UHFFFAOYSA-N", "sys_name")
#'
#' # Fetch compound physicochemical properties from inchi key
#' compound_search("inchi_key", "IPCSVZSSVZVIGE-UHFFFAOYSA-N", "physchem")
#'
#' # Fetch all compound fields from formula (multiple records)
#' compound_search("formula", "C20H34O", "all")
#'
#' # Fetch compound classification hierarchy from PubChem CID
#' compound_search("pubchem_cid", "985", "classification")
#'
#' # Fetch all compound fields from bulk abbreviation
#' compound_search("abbrev", "PA(38:0)", "all")
#'
#' # Fetch all compound fields from chain abbreviation
#' compound_search("abbrev_chains", "PC(16:0_18:0)", "all")
#'
#'
#' @author Mingzhuo Tian \email{tianmingzhuo@outlook.com}
#' License: GPL (>= 3)
#' @export
compound_search <- function(input_item = "lm_id",
                            input_value,
                            output_item,
                            output_format = "") {


  url <- paste0(
    "https://www.lipidmaps.org/rest/compound/",
    input_item,
    "/",
    input_value,
    "/",
    output_item,
    "/",
    output_format)

  r <- httr::GET(url = url, httr::content_type("application/json"))


  #TODO molfile and structure output are not supported yet
  if (r$status_code == 200) {
    # cat(paste0("Status: ", r$status_code, ", Success!\n"))
    # cat(paste0("Date: ", r$date, "\n"))
    if (output_format == "" | output_format == "json") {
          results <- RJSONIO::fromJSON(httr::content(r, "text", encoding = "UTF-8"))
          return(results)
    } else if (output_format == "txt") {
      results <- httr::content(r, "text", encoding = "UTF-8")
      return(results)
    }

  } else {
    cat(paste0("Status: ", r$status_code, ", Fail to connect the API service!\n"))
    cat(paste0("Date: ", r$date, "\n"))
  }
}
