# ------------------------------------------------------------------------------
# Urban Network Analysis Toolbox for ArcGIS10
# Credits: Michael Mekonnen, Andres Sevtsuk
# MIT City Form Research Group
# Usage: Creative Commons Attribution - NonCommercial - ShareAlike 3.0 Unported
#   License
# License: http://creativecommons.org/licenses/by-nc-sa/3.0/
# ------------------------------------------------------------------------------

"""
Script for representation of a weighted, undirected graph.
"""

from Constants import NEIGHBORS
from Constants import WEIGHT

class Node:
  """
  Representation for a node in a graph
  A graph is represented by a dictionary mapping node id's to |Node| objects
  """

  def __init__(self):
    # Neighboring nodes
    setattr(self, NEIGHBORS, set())
    # Weight of the node
    setattr(self, WEIGHT, 1.0)

  def add_neighbor(self, neighbor_id, edge_weight=1.0, accumulation_weights={}):
    """
    Add a neighbor to this node
    |neighbor_id|: id of the neighboring node
    |edge_weight|: weight of the edge connecting the two nodes
    |accumulation_weights|: weight of the edge based on other metrics
    """
    getattr(self, NEIGHBORS).add((neighbor_id, edge_weight,
        tuple(accumulation_weights.items())))