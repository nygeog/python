# ------------------------------------------------------------------------------
# Urban Network Analysis Toolbox for ArcGIS10
# Credits: Michael Mekonnen, Andres Sevtsuk
# MIT City Form Research Group
# Usage: Creative Commons Attribution - NonCommercial - ShareAlike 3.0 Unported
#   License
# License: http://creativecommons.org/licenses/by-nc-sa/3.0/
# ------------------------------------------------------------------------------

"""
Unittest for the centrality metric computation.
These are very basic sanity checks, they do not fully test the centrality
  computation algorithm.
"""
# TODO(mikemeko): add more tests

from Centrality_Computation import compute_centrality
from Constants import INFINITE_RADIUS
from Constants import BETWEENNESS
from Constants import CLOSENESS
from Constants import GRAVITY
from Constants import LOCATION
from Constants import REACH
from Constants import STRAIGHTNESS
from math import log
from math import sqrt
from Node import Node
import unittest
from Utils import eq_tol

def construct_graph(node_ids, edges):
  """
  Constructs a weighted, undirected graph.
  """
  graph = {}
  # Nodes
  for id in node_ids:
    graph[id] = Node()
  # Edges
  for (u, v, weight) in edges:
    graph[u].add_neighbor(v, weight)
    graph[v].add_neighbor(u, weight)
  return graph

class TestReach(unittest.TestCase):
  """
  Reach
  A
  |\
  | C--D
  |/
  B
  """
  def setUp(self):
    """
    Setup
    """
    self.nodes = ["A", "B", "C", "D"]
    self.edges = [("A", "B", 1), ("A", "C", 1), ("B", "C", 1), ("C", "D", 1)]
    self.graph = construct_graph(self.nodes, self.edges)
  def test_Infinite_Reach(self):
    """
    Test reach at infinite radius
    """
    compute_centrality(self.graph, self.nodes, True, False, False, False, False,
        INFINITE_RADIUS, 1, [], [])
    assert eq_tol(getattr(self.graph["A"], REACH), 3)
    assert eq_tol(getattr(self.graph["B"], REACH), 3)
    assert eq_tol(getattr(self.graph["C"], REACH), 3)
    assert eq_tol(getattr(self.graph["D"], REACH), 3)
  def test_Degree_Reach(self):
    """
    Test reach at radius 1 - the reach values are no the degrees of the nodes
    """
    compute_centrality(self.graph, self.nodes, True, False, False, False, False,
        1, 1, [], [])
    assert eq_tol(getattr(self.graph["A"], REACH), 2)
    assert eq_tol(getattr(self.graph["B"], REACH), 2)
    assert eq_tol(getattr(self.graph["C"], REACH), 3)
    assert eq_tol(getattr(self.graph["D"], REACH), 1)

class TestGravity(unittest.TestCase):
  """
  Gravity
  A
  |\
  | C--D
  |/
  B
  """
  def setUp(self):
    """
    Setup
    """
    self.nodes = ["A", "B", "C", "D"]
    self.edges = [("A", "B", log(3)), ("A", "C", log(2)), ("B", "C", log(2)),
        ("C", "D", log(3))]
    self.graph = construct_graph(self.nodes, self.edges)
  def test_Gravity(self):
    """
    Test gravity at infinite radius and a beta value of 1
    """
    compute_centrality(self.graph, self.nodes, False, True, False, False, False,
        INFINITE_RADIUS, 1, [], [])
    assert eq_tol(getattr(self.graph["A"], GRAVITY), 1)
    assert eq_tol(getattr(self.graph["B"], GRAVITY), 1)
    assert eq_tol(getattr(self.graph["C"], GRAVITY), 4.0 / 3)
    assert eq_tol(getattr(self.graph["D"], GRAVITY), 2.0 / 3)

class TestBetweenness(unittest.TestCase):
  """
  Betweenness
  A
   \
    C--D
   /
  B
  """
  def setUp(self):
    """
    Setup
    """
    self.nodes = ["A", "B", "C", "D"]
    self.edges = [("A", "C", 1), ("B", "C", 1), ("C", "D", 1)]
    self.graph = construct_graph(self.nodes, self.edges)
  def test_Betweenness(self):
    """
    Test betweenness at infinite radius
    """
    compute_centrality(self.graph, self.nodes, False, False, True, False, False,
        INFINITE_RADIUS, 1, [], [])
    assert eq_tol(getattr(self.graph["A"], BETWEENNESS), 0)
    assert eq_tol(getattr(self.graph["B"], BETWEENNESS), 0)
    assert eq_tol(getattr(self.graph["C"], BETWEENNESS), 6)
    assert eq_tol(getattr(self.graph["D"], BETWEENNESS), 0)

class TestCloseness(unittest.TestCase):
  """
  Closeness
  A
  |\
  | C--D
  |/
  B
  """
  def setUp(self):
    """
    Setup
    """
    self.nodes = ["A", "B", "C", "D"]
    self.edges = [("A", "B", 2), ("A", "C", 1), ("B", "C", 1), ("C", "D", 3)]
    self.graph = construct_graph(self.nodes, self.edges)
  def test_Closeness(self):
    """
    Test closeness at infinite radius
    """
    compute_centrality(self.graph, self.nodes, False, False, False, True, False,
        INFINITE_RADIUS, 1, [], [])
    assert eq_tol(getattr(self.graph["A"], CLOSENESS), 1.0 / 7)
    assert eq_tol(getattr(self.graph["B"], CLOSENESS), 1.0 / 7)
    assert eq_tol(getattr(self.graph["C"], CLOSENESS), 1.0 / 5)
    assert eq_tol(getattr(self.graph["D"], CLOSENESS), 1.0 / 11)

class TestStraightness(unittest.TestCase):
  """
  Straightness
    |
   1| A
    | |\
   0| | C--D
    | |/
  -1| B
     --------
     -1 0  1
  """
  def setUp(self):
    """
    Setup
    """
    self.nodes = ["A", "B", "C", "D"]
    self.edges = [("A", "B", 2), ("A", "C", sqrt(2)), ("B", "C", sqrt(2)),
        ("C", "D", 1)]
    self.graph = construct_graph(self.nodes, self.edges)
    setattr(self.graph["A"], LOCATION, (-1, 1))
    setattr(self.graph["B"], LOCATION, (-1, -1))
    setattr(self.graph["C"], LOCATION, (0, 0))
    setattr(self.graph["D"], LOCATION, (1, 0))
  def test_Straightness(self):
    """
    Test straightness at infinite radius
    """
    compute_centrality(self.graph, self.nodes, False, False, False, False, True,
        INFINITE_RADIUS, 1, [], [])
    assert eq_tol(getattr(self.graph["A"], STRAIGHTNESS),
        2 + sqrt(5) / (1 + sqrt(2)))
    assert eq_tol(getattr(self.graph["B"], STRAIGHTNESS),
        2 + sqrt(5) / (1 + sqrt(2)))
    assert eq_tol(getattr(self.graph["C"], STRAIGHTNESS), 3)
    assert eq_tol(getattr(self.graph["D"], STRAIGHTNESS),
        1 + 2 * sqrt(5) / (1 + sqrt(2)))

if __name__ == "__main__":
  unittest.main()