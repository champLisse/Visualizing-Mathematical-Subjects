
#-----TURNS METADATA INTO AN IGRAPH GRAPH-------

library('dplyr')
library("naniar")
library('igraph')

#get the subjects
rawsubjects = select(recordlist, starts_with("subject"))

#remove MSC old subject system
subjects = replace_with_na_all(rawsubjects, condition = ~grepl("\\d", .x))


#Find the vertices with their size
tbl = sort(table(unlist(subjects)))
vertices = names(tbl)

#find the edges in the form of an adjacency matrix
rawedges = filter(subjects, !is.na(subject.1))

adjmat = matrix(0, nrow=length(vertices), ncol=length(vertices))
dimnames(adjmat) = list(vertices, vertices)

for (i in 1:length(rawedges[[1]])){
  rowi = rawedges[i,]
  rowi = as.vector(rowi[as.vector(!is.na(rowi))])
  pairs = as.matrix(combn(rowi, 2))
  for (j in 1:ncol(pairs)){
    pair = pairs[,j]
    adjmat[pair[[1]], pair[[2]]] = adjmat[pair[[1]], pair[[2]]] + 1
    adjmat[pair[[2]], pair[[1]]] = adjmat[pair[[1]], pair[[2]]] #symmetry
  }
}

#create a graph
thegraph = graph_from_adjacency_matrix(adjmat, mode = "undirected", weighted = TRUE, diag = FALSE)
