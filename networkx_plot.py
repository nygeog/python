import matplotlib.pyplot as plt
%matplotlib inline
#nx.draw(G, node_size = 900, node_color='cyan')
pos=nx.spring_layout(G) 
nx.draw(G,pos,node_color='#A0CBE2',edge_color='#BB0000',width=2,edge_cmap=plt.cm.Blues,with_labels=True)
#plt.show()
#plt.savefig( "h2.png" )
plt.savefig("img/graph.png", dpi=1000)
#print read_edges(homer)