
#--------PLOTS GRAPHS---------

#The subgraph of mathematical subgraphs
mathV = V(thegraph)[grepl("Mathematics", V(thegraph)$name)]
mathgraph = induced_subgraph(thegraph, mathV)

#The subgraph of subjects with at least 100 articles
bigV = V(thegraph)[names(tbl[tbl>100])]
biggraph = induced_subgraph(thegraph, bigV)


#choose a graph to be plotted here
g = mathgraph


#setting vertex sizes
for (v in V(g)){
  vertex_attr(g, "size", v) = sqrt(as.vector(tbl[get.vertex.attribute(g, "name", v)]))/3
}
#vertex_attr(g, "size") = 1 + degree(g, mode="all")


#setting edge thickness
edge_attr(g, "width") = E(g)$weight/20


#set the vertex labels
V(g)$name = sub("Mathematics - ", "", V(g)$name)


#pick a layout
lo = layout_with_fr(g, weights = E(g)$weight)


#pick a clustering method
ceb <- cluster_edge_betweenness(g)
#clp <- cluster_label_prop(g)
#cfg <- cluster_fast_greedy(g)
#clou <- cluster_louvain(g)


#Do the actuall plotting
plot(ceb, g, layout = pos, vertex.label.color="black", edge.color = 'dark gray', vertex.frame.color = "black")


#Use this to manually adjust the layout
#pl = tkplot(g, layout = lo, edge.width = E(g)$width)
#pos = tkplot.getcoords(pl)