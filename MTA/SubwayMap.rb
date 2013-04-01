


# Creates a CONSTANT hash will all lines and stations
SUBWAY = {
"N line" => ["Times Square", "34th", "28th-N", "23rd-N", "Union Square", "8th-N"],
"L line" => ["8th-L", "6th", "Union Square", "3rd", "1st" ],
"6 line" => ["Grand Central", "33rd", "28th-6", "23rd-6", "Union Square", "Astor Place"]
 }

#Creates a CONSTANT with all the stations in the subway with no duplicates
ALLSTATIONS = SUBWAY.values.flatten.uniq