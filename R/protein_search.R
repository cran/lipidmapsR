#' A function for Protein search
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
#' # Fetch all protein fields from UniProt id
#' protein_search("uniprot_id", "Q13085", "all")
#' # Fetch all protein fields from Entrez gene id
#' protein_search("gene_id", "19", "all")
#' # Fetch mRNA id from protein Refseq id
#' protein_search("refseq_id", "NP_005493", "mrna_id")
#'
#' @author Mingzhuo Tian \email{tianmingzhuo@outlook.com}
#' License: GPL (>= 3)
#' @export
protein_search <- function(input_item,
                            input_value,
                            output_item,
                            output_format = "") {


  url <- paste0(
    "https://www.lipidmaps.org/rest/protein/",
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
