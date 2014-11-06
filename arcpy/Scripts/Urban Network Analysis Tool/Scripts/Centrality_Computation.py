# ------------------------------------------------------------------------------
# Urban Network Analysis Toolbox for ArcGIS10
# Credits: Michael Mekonnen, Andres Sevtsuk
# MIT City Form Research Group
# Usage: Creative Commons Attribution - NonCommercial - ShareAlike 3.0 Unported
#   License
# License: http://creativecommons.org/licenses/by-nc-sa/3.0/
# ------------------------------------------------------------------------------

"""
Script for the computation of the five centrality metrics.
"""

from arcpy import AddWarning
from Constants import BETWEENNESS
from Constants import CLOSENESS
from Constants import GRAVITY
from Constants import LOCATION
from Constants import NEIGHBORS
from Constants import NORM_BETWEENNESS
from Constants import NORM_CLOSENESS
from Constants import NORM_GRAVITY
from Constants import NORM_REACH
from Constants import NORM_STRAIGHTNESS
from Constants import PROGRESS_NORMALIZATION
from Constants import REACH
from Constants import STEP_4
from Constants import STRAIGHTNESS
from Constants import WARNING_NO_BETWEENNESS_NORMALIZATION
from Constants import WEIGHT
from heapq import heapify
from heapq import heappop
from heapq import heappush
from math import exp
from operator import add
from Utils import dist
from Utils import eq_tol
from Utils import lt_tol
from Utils import merge_maps
from Utils import Progress_Bar

def compute_centrality(nodes, origins, compute_r, compute_g, compute_b,
    compute_c, compute_s, radius, beta, measures_to_normalize,
    accumulator_fields):
  """
  Computes reach, gravity, betweenness, closeness, and straightness on a graph.
  |nodes|: graph representation; dictionary mapping node id's to |Node| objects
  |origins|: subset of nodes that will be used as sources of shortest path trees
  |compute_r|: compute reach?
  |compute_g|: compute gravity type index?
  |compute_b|: compute betweenness?
  |compute_c|: compute closeness?
  |compute_s|: compute straightness?
  |radius|: for each node, only consider other nodes that can be reached within
      this distance
  |beta|: parameter for gravity type index
  |measures_to_normalize|: a list of measures to normalize
  |accumulator_fields|: a list of cost attributes to accumulate
  """

  # Number of nodes in the graph
  N = len(nodes)
  O = len(origins)
  if N == 0 or O == 0:
    return

  # Preprocessing
  have_accumulations = len(accumulator_fields) > 0
  have_locations = hasattr(nodes.values()[0], LOCATION)
  if compute_s and not have_locations:
    # We cannot compute straightness without node locations
    compute_s = False
  if compute_b:
    # Initialize betweenness values
    for id in nodes:
      setattr(nodes[id], BETWEENNESS, 0.0)

  # Initialize the sum of all node weights (normalization)
  sum_weights = 0.0

  # Computation
  progress = Progress_Bar(O, 1, STEP_4)
  for s in origins:
    weight_s = getattr(nodes[s], WEIGHT)
    if have_locations: location_s = getattr(nodes[s], LOCATION)

    sum_weights += weight_s

    # Initialize reach (weighted and unweighted) computation for |s|
    #     (normalization)
    reach_s = -1
    weighted_reach_s = -weight_s

    # Initialize measures
    if compute_g: gravity_s = 0.0
    if compute_b:
      P = {s: []} # Predecessors
      S = [] # Stack containing nodes in the order they are extended
      sigma = {s: 1.0} # Number of shortest paths from |s| to other nodes
      delta = {} # Dependency of |s| on other nodes
    if compute_c: d_sum_s = 0.0
    if compute_s: straightness_s = 0.0
    if have_accumulations:
      empty_accumulations = lambda: dict((field, 0.0) for field in
          accumulator_fields)
      accumulations_s = {s: empty_accumulations()}

    d = {s: 0.0} # Shortest distance from |s| to other nodes
    Q = [(0.0, s)] # Queue for Dijkstra

    # Dijkstra
    while Q:
      # Pop the closest node to |s| from |Q|
      d_sv, v = heappop(Q)
      weight_v = getattr(nodes[v], WEIGHT)
      if have_locations: location_v = getattr(nodes[v], LOCATION)

      reach_s += 1
      weighted_reach_s += weight_v

      if d_sv > 0:
        if compute_g: gravity_s += weight_v * exp(-d_sv * beta)
        if compute_c: d_sum_s += weight_v * d_sv
        if compute_s: straightness_s += (weight_v * dist(location_s, location_v)
            / d_sv)
      if compute_b: S.append(v)

      for w, d_vw, accumulations_vw in getattr(nodes[v], NEIGHBORS):
        # s ~ ... ~ v ~ w
        d_sw = d_sv + d_vw
        if compute_b: b_refresh = False

        if not w in d: # Found a path from |s| to |w| for the first time
          if d_sw <= radius:
            heappush(Q, (d_sw, w)) # Add |w| to |Q|
            if have_accumulations:
              accumulations_s[w] = merge_maps(accumulations_s[v],
                  dict(accumulations_vw), add)
          d[w] = d_sw
          if compute_b: b_refresh = True

        elif lt_tol(d_sw, d[w]): # Found a better path from |s| to |w|
          if d_sw <= radius:
            if d[w] <= radius:
              Q.remove((d[w], w))
              heapify(Q)
            heappush(Q, (d_sw, w)) # Add |w| to |Q|
            if have_accumulations:
              accumulations_s[w] = merge_maps(accumulations_s[v],
                  dict(accumulations_vw), add)
          d[w] = d_sw
          if compute_b: b_refresh = True

        if compute_b:
          if b_refresh:
            sigma[w] = 0.0
            P[w] = []
          if eq_tol(d_sw, d[w]): # Count all shortest paths from |s| to |w|
            sigma[w] += sigma[v] # Update the number of shortest paths
            P[w].append(v) # |v| is a predecessor of |w|
            delta[v] = 0.0 # Recognize |v| as a predecessor

    if compute_r: setattr(nodes[s], REACH, weighted_reach_s)
    if compute_g: setattr(nodes[s], GRAVITY, gravity_s)
    if compute_b:
      while S: # Revisit nodes in reverse order of distance from |s|
        w = S.pop()
        delta_w = delta[w] if w in delta else 0.0 # Dependency of |s| on |w|
        for v in P[w]:
          weight_w = getattr(nodes[w], WEIGHT)
          delta[v] += sigma[v] / sigma[w] * (weight_w + delta_w)
        if w != s:
          between_w = getattr(nodes[w], BETWEENNESS)
          setattr(nodes[w], BETWEENNESS, between_w + delta_w)
    if compute_c: setattr(nodes[s], CLOSENESS, (1.0 / d_sum_s if d_sum_s > 0
        else 0.0))
    if compute_s: setattr(nodes[s], STRAIGHTNESS, straightness_s)

    nodes[s].reach = reach_s
    nodes[s].weighted_reach = weighted_reach_s

    if have_accumulations:
      total_accumulations_s = empty_accumulations()
      for v in accumulations_s:
        total_accumulations_s = merge_maps(total_accumulations_s,
            accumulations_s[v], add)
      for field in accumulator_fields:
        setattr(nodes[s], field, total_accumulations_s[field])

    progress.step()

  # Normalization
  if BETWEENNESS in measures_to_normalize and O < N:
      measures_to_normalize.remove(BETWEENNESS)
      AddWarning(WARNING_NO_BETWEENNESS_NORMALIZATION)
  if measures_to_normalize:
    norm_progress = Progress_Bar(O, 1, PROGRESS_NORMALIZATION)
    for s in origins:
      reach_s = nodes[s].reach
      weighted_reach_s = nodes[s].weighted_reach

      # Normalize reach
      if compute_r and REACH in measures_to_normalize:
        weight_s = getattr(nodes[s], WEIGHT)
        try: setattr(nodes[s], NORM_REACH, reach_s / (sum_weights - weight_s))
        except: setattr(nodes[s], NORM_REACH, 0.0)

      # Normalize gravity
      if compute_g and GRAVITY in measures_to_normalize:
        gravity_s = getattr(nodes[s], GRAVITY)
        try: setattr(nodes[s], NORM_GRAVITY, (exp(beta) * gravity_s /
            weighted_reach_s))
        except: setattr(nodes[s], NORM_GRAVITY, 0.0)

      # Normalize betweenness
      if compute_b and BETWEENNESS in measures_to_normalize:
        betweenness_s = getattr(nodes[s], BETWEENNESS)
        try: setattr(nodes[s], NORM_BETWEENNESS, (betweenness_s /
            (weighted_reach_s * (reach_s - 1))))
        except: setattr(nodes[s], NORM_BETWEENNESS, 0.0)

      # Normalize closeness
      if compute_c and CLOSENESS in measures_to_normalize:
        closeness_s = getattr(nodes[s], CLOSENESS)
        try: setattr(nodes[s], NORM_CLOSENESS, closeness_s * weighted_reach_s)
        except: setattr(nodes[s], NORM_CLOSENESS, 0.0)

      # Normalize straightness
      if compute_s and STRAIGHTNESS in measures_to_normalize:
        straightness_s = getattr(nodes[s], STRAIGHTNESS)
        try: setattr(nodes[s], NORM_STRAIGHTNESS, (straightness_s /
            weighted_reach_s))
        except: setattr(nodes[s], NORM_STRAIGHTNESS, 0.0)

      norm_progress.step()