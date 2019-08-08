module BCODMOTools

using DataDeps, NCDatasets
#using Match, StatsBase, Unitful
#using OceanGrids, NearestNeighbors
using Dates


function fallback_download(remotepath, localdir)
    @assert(isdir(localdir))
    filename = basename(remotepath)  # only works for URLs with filename as last part of name
    localpath = joinpath(localdir, filename)
    Base.download(remotepath, localpath)
    return localpath
end

# Not working yet
function register_POM_Martiny_etal_2014()
    register(DataDep(
        "POM_Martiny_etal_2014",
        """
        Martiny, A. C. et al. Concentrations and ratios of particulate organic carbon, nitrogen, and phosphorus in the global ocean. Sci. Data 1:140048 doi: 10.1038/sdata.2014.48 (2014).
        """,
        "https://www.bco-dmo.org/dataset/526747/data/download",
        sha2_256,
        fetch_method = fallback_download
    ))
end


# Working with 2018 data:
function register_POM_Martiny_etal_2018()
    register(DataDep(
        "POM_Martiny_etal_2018",
        """
        Martiny, A., Lomas, M. (2018) Particulate organic matter (PON, POC, POP) concentrations collected on R/V Roger Revelle cruise RR1604 along the hydrographic line IO9 in the Eastern Indian Ocean from March to April 2016. Biological and Chemical Oceanography Data Management Office (BCO-DMO). Dataset version 2018-06-21. doi:10.1575/1912/bco-dmo.734915.2 [retrieved $(Date(now()))].
        """,
        "erddap.bco-dmo.org/erddap/tabledap/bcodmo_dataset_734915.nc",
        "740e4b362b9b0e03fea80f0caaa4c1f59594237bc4ba59b6a63b5b953914e37f",
        fetch_method = fallback_download
    ))
end


function POM_Martiny_etal_2018_Dataset()
    println("Registering POM_Martiny_etal_2018 data with DataDeps")
    foo = register_POM_Martiny_etal_2018()
    @info(
          """
          You are about to use data from BCO-DMO, please cite it!

          Citation:
          $(foo.extra_message)

          Or find the BibTeX entry for the citation in the CITATION.bib file!
          (Raise an issue / make a PR if it is not in there!)
          """
          )
    Dataset(@datadep_str "POM_Martiny_etal_2018/bcodmo_dataset_734915.nc")
end


end # module
