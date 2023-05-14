library (naijR)
library (data.table)

rm (list = ls ())

# Draw plot of all states but colour them by GPZ
# Here we first create a list of data frames, each
# of which has the states of a given GPZ. Then, we
# combine them together by their rows to make one 
# big data frame. We do this so that we can create
# a column that is unique to all members of a particular
# GPZ. Once this is done, we send the data frame to the 
# mapping function; this time, to the `data` parameter and
# the `x` parameter is for defining that column that is 
# unique to each Zone. This is used to fill in the 
# appropriate colours
gpz <- c("ne", "nw", "nc", "ss", "se", "sw")
stateList <-
  lapply (gpz, function(x) {
    data.frame(State = states(gpz = x), GPZ = toupper(x))
  })

gpzData <- Reduce (rbind, stateList)
gpzData <- rbind  (gpzData, c("Federal Capital Territory", "NC"))


# ------------------------------------------------------------------------------

# read file for basic vaccination coverage
vaccine_dt <- fread (file = "nigeria_basic_vaccine_coverage.csv")

# map data table
map_dt <- as.data.table (gpzData)

# add basic vaccination coverage data to corresponding geopolitical zone
vaccine_map_dt <- merge (map_dt, vaccine_dt, by = "GPZ")

# create column Region that combines region and basic vaccination coverage
vaccine_map_dt [, Region := paste0 (GPZ, ' (', basic_vaccine_coverage, '%)')]

# order Region column
vaccine_map_dt$Region <- factor (vaccine_map_dt$Region, levels = c ("NW (19.9%)", "NE (22.9%)", "NC (30.9%)", "SS (41.8%)", "SW (42.6%)", "SE (56.6%)"))

# generate map for basic vaccination coverage
map_ng (data = vaccine_map_dt, x = Region, show.text = TRUE, col = 'green') 

# ------------------------------------------------------------------------------