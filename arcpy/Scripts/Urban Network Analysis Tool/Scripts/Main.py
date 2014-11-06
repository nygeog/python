# ------------------------------------------------------------------------------
# Urban Network Analysis Toolbox for ArcGIS10
# Credits: Michael Mekonnen, Andres Sevtsuk
# MIT City Form Research Group
# Usage: Creative Commons Attribution - NonCommercial - ShareAlike 3.0 Unported
#   License
# License: http://creativecommons.org/licenses/by-nc-sa/3.0/
# ------------------------------------------------------------------------------

"""
Script for taking in the inputs to the toolbox and returning its outputs.
"""

from arcgisscripting import ExecuteAbort
from arcpy import AddField_management
from arcpy import AddMessage
from arcpy import AddWarning
from arcpy import ApplySymbologyFromLayer_management
from arcpy import CheckOutExtension
from arcpy import CopyFeatures_management
from arcpy import CreateFeatureclass_management
from arcpy import Describe
from arcpy import env
from arcpy import Exists
from arcpy import GetCount_management
from arcpy import GetMessages
from arcpy import MakeFeatureLayer_management
from arcpy import mapping
from arcpy import SaveToLayerFile_management
from arcpy import SelectLayerByAttribute_management
from arcpy import UpdateCursor
from Adjacency_List_Computation import compute_adjacency_list
from Centrality_Computation import compute_centrality
from Constants import ACCUMULATOR_ATTRIBUTES
from Constants import ADJACENCY_LIST_COMPUTED
from Constants import ADJACENCY_LIST_NAME
from Constants import AUXILIARY_DIR_NAME
from Constants import BETA
from Constants import COMPUTE_BETWEENNESS
from Constants import COMPUTE_CLOSENESS
from Constants import COMPUTE_GRAVITY
from Constants import COMPUTE_REACH
from Constants import COMPUTE_STRAIGHTNESS
from Constants import DESTINATION_ID_FIELD_NAME
from Constants import FAILURE
from Constants import feature_class_name
from Constants import FINAL_ATTRIBUTES
from Constants import ID_ATTRIBUTE
from Constants import IMPEDANCE_ATTRIBUTE
from Constants import index
from Constants import INFINITE_RADIUS
from Constants import INPUT_BUILDINGS
from Constants import INPUT_BUILDINGS_COPY_FAILED
from Constants import INPUT_BUILDINGS_COPY_FINISHED
from Constants import INPUT_BUILDINGS_COPY_STARTED
from Constants import INPUT_COUNT
from Constants import INPUT_NETWORK
from Constants import INPUT_POINTS
from Constants import INPUT_POINTS_LAYER_NAME
from Constants import layer_name
from Constants import LOCATION
from Constants import METRICS
from Constants import NODE_WEIGHT_ATTRIBUTE
from Constants import NORMALIZE_RESULTS
from Constants import OD_COST_MATRIX_LAYER_NAME
from Constants import OD_COST_MATRIX_LINES
from Constants import ORIGIN_ID_FIELD_NAME
from Constants import ORIGINAL_FID
from Constants import OUTPUT_FILE_NAME
from Constants import OUTPUT_LOCATION
from Constants import PARTIAL_ADJACENCY_LIST_NAME
from Constants import POINT_CONVERSION_FINISHED
from Constants import POINT_CONVERSION_STARTED
from Constants import POINT_FEATURE_CLASS_NAME
from Constants import POINT_LOCATION
from Constants import POLYGONS_LAYER_NAME
from Constants import POLYGONS_SHAPEFILE_NAME
from Constants import RASTER_NAME
from Constants import SEARCH_RADIUS
from Constants import STEP_1_FAILED
from Constants import STEP_1_FINISHED
from Constants import STEP_1_STARTED
from Constants import STEP_2
from Constants import STEP_2_FAILED
from Constants import STEP_2_FINISHED
from Constants import STEP_2_STARTED
from Constants import STEP_3
from Constants import STEP_3_FAILED
from Constants import STEP_3_FINISHED
from Constants import STEP_3_STARTED
from Constants import STEP_4_FAILED
from Constants import STEP_4_FINISHED
from Constants import STEP_4_STARTED
from Constants import STEP_5
from Constants import STEP_5_FAILED
from Constants import STEP_5_FINISHED
from Constants import STEP_5_STARTED
from Constants import STEP_6_FAILED
from Constants import STEP_6_FINISHED
from Constants import STEP_6_STARTED
from Constants import SUCCESS
from Constants import SYMBOLOGY_DIR
from Constants import symbology_layer_name
from Constants import WARNING_APPLY_SYMBOLOGY_FAILED
from Constants import WARNING_FAIL_TO_DISPLAY
from Constants import WARNING_NO_NODES
from Constants import WARNING_OUTPUT_ALREADY_EXISTS
from Constants import WARNING_POINTS_NOT_IN_GRAPH
from Constants import WEIGHT
from Node import Node
from os.path import join
from sys import argv
from Utils import all_values_in_column
from Utils import basename
from Utils import delete
from Utils import Invalid_Input_Exception
from Utils import is_accumulator_field
from Utils import Progress_Bar
from Utils import to_point_feature_class
from Utils import trim

env.overwriteOutput = True # Enable overwritting
CheckOutExtension("Network")

# Success of the program through the six steps
success = True

# Inputs to the tool
if len(argv) != INPUT_COUNT + 1:
  raise Exception("Invalid number of inputs")
input_number = index()
input_number.next() # Skip over sys.argv[0]
inputs = {}
inputs[INPUT_BUILDINGS] = argv[input_number.next()]
inputs[POINT_LOCATION] = ("INSIDE" if argv[input_number.next()] == "true" else
    "CENTROID")
inputs[INPUT_NETWORK] = argv[input_number.next()]
inputs[COMPUTE_REACH] = argv[input_number.next()] == "true"
inputs[COMPUTE_GRAVITY] = argv[input_number.next()] == "true"
inputs[COMPUTE_BETWEENNESS] = argv[input_number.next()] == "true"
inputs[COMPUTE_CLOSENESS] = argv[input_number.next()] == "true"
inputs[COMPUTE_STRAIGHTNESS] = argv[input_number.next()] == "true"
inputs[ID_ATTRIBUTE] = argv[input_number.next()]
inputs[NODE_WEIGHT_ATTRIBUTE] = argv[input_number.next()]
inputs[IMPEDANCE_ATTRIBUTE] = argv[input_number.next()]
try: inputs[SEARCH_RADIUS] = float(argv[input_number.next()])
except: inputs[SEARCH_RADIUS] = INFINITE_RADIUS
try: inputs[BETA] = float(argv[input_number.next()])
except: raise Invalid_Input_Exception("Beta")
inputs[NORMALIZE_RESULTS] = [measure for measure in
    argv[input_number.next()].split(";") if measure != "#"]
inputs[OUTPUT_LOCATION] = argv[input_number.next()]
inputs[OUTPUT_FILE_NAME] = argv[input_number.next()]
inputs[ACCUMULATOR_ATTRIBUTES] = argv[input_number.next()]

# Record the origin nodes for centrality measurements
# This is important if the user selects a subset of the features to be origins
selected_features = all_values_in_column(inputs[INPUT_BUILDINGS],
  inputs[ID_ATTRIBUTE])
# Clear selection if we got a layer file
try:
  SelectLayerByAttribute_management(inputs[INPUT_BUILDINGS],
    "CLEAR_SELECTION")
except:
  pass

# Adjacency List table name
adj_dbf_name = ("%s_%s_%s_%s_%s_%s.dbf" % (ADJACENCY_LIST_NAME,
    basename(inputs[INPUT_BUILDINGS]), basename(inputs[INPUT_NETWORK]),
    inputs[ID_ATTRIBUTE], inputs[IMPEDANCE_ATTRIBUTE],
    inputs[ACCUMULATOR_ATTRIBUTES]))
adj_dbf = join(inputs[OUTPUT_LOCATION], adj_dbf_name)

# Output file names
output_feature_class_name = feature_class_name(inputs[OUTPUT_FILE_NAME])
output_feature_class = "%s.shp" % join(inputs[OUTPUT_LOCATION],
    output_feature_class_name)
# Create a feature class that is a copy of the input buildings
try:
  AddMessage(INPUT_BUILDINGS_COPY_STARTED)
  CreateFeatureclass_management(out_path=inputs[OUTPUT_LOCATION],
      out_name=output_feature_class_name)
  CopyFeatures_management(in_features=inputs[INPUT_BUILDINGS],
      out_feature_class=output_feature_class)
  AddMessage(INPUT_BUILDINGS_COPY_FINISHED)
except:
  AddWarning(GetMessages(2))
  AddMessage(INPUT_BUILDINGS_COPY_FAILED)
  success = False
output_layer_name = layer_name(inputs[OUTPUT_FILE_NAME])
output_layer = "%s.lyr" % join(inputs[OUTPUT_LOCATION], output_layer_name)

# If output has already been created, don't carry on
if Exists(output_layer):
  AddWarning(WARNING_OUTPUT_ALREADY_EXISTS)
  success = False

# We will convert polygon input buildings to point feature class
buildings_description = Describe(output_feature_class)
if buildings_description.shapeType == "Point":
  # Input buildings are already a point shape file
  inputs[INPUT_POINTS] = output_feature_class
elif buildings_description.shapeType == "Polygon":
  # Input buildings need to be converted to point feature class
  point_feature_class_name = POINT_FEATURE_CLASS_NAME(
      basename(output_feature_class), inputs[POINT_LOCATION])
  inputs[INPUT_POINTS] = "%s.shp" % join(inputs[OUTPUT_LOCATION],
      point_feature_class_name)
  # If FID is used as ID attribute, we need to change it since a point shapefile
  #     will be in use
  if inputs[ID_ATTRIBUTE] == "FID":
    inputs[ID_ATTRIBUTE] = ORIGINAL_FID
else:
  # Input buildings need to be either points or polygons
  raise Invalid_Input_Exception("Input Buildings")

# Find the appropriate symbology layer
for metric_index in range(len(METRICS)):
    if inputs[COMPUTE_REACH + metric_index]:
        first_metric = METRICS[metric_index]
        break
symbology_layer_name = symbology_layer_name(buildings_description.shapeType,
    first_metric)
symbology_layer = join(SYMBOLOGY_DIR, symbology_layer_name)

def clean_up():
  """
  Removes all auxiliary files
  """
  auxiliary_dir = join(inputs[OUTPUT_LOCATION], AUXILIARY_DIR_NAME)
  od_cost_matrix_layer = join(auxiliary_dir, OD_COST_MATRIX_LAYER_NAME)
  od_cost_matrix_lines = join(auxiliary_dir, OD_COST_MATRIX_LINES)
  temp_adj_dbf_name = "%s~.dbf" % adj_dbf_name[-4]
  temp_adj_dbf = join(inputs[OUTPUT_LOCATION], temp_adj_dbf_name)
  partial_adj_dbf = join(auxiliary_dir, PARTIAL_ADJACENCY_LIST_NAME)
  polygons = join(auxiliary_dir, POLYGONS_SHAPEFILE_NAME)
  raster = join(auxiliary_dir, RASTER_NAME)
  polygons_layer = join(auxiliary_dir, POLYGONS_LAYER_NAME)
  input_points_layer = join(auxiliary_dir, INPUT_POINTS_LAYER_NAME)
  for delete_path in [input_points_layer, polygons_layer, raster, polygons,
      partial_adj_dbf, temp_adj_dbf, od_cost_matrix_lines, od_cost_matrix_layer,
      auxiliary_dir]:
    delete(delete_path)

try:
  """
  Here we carry out the six steps of the tool
  """
  # Step 1
  if success:
    AddMessage(STEP_1_STARTED)
    # If necessary, convert input buildings to point feature class
    if buildings_description.shapeType == "Polygon":
      AddMessage(POINT_CONVERSION_STARTED)
      to_point_feature_class(output_feature_class, inputs[INPUT_POINTS],
          inputs[POINT_LOCATION])
      AddMessage(POINT_CONVERSION_FINISHED)
    if Exists(adj_dbf):
      AddMessage(ADJACENCY_LIST_COMPUTED)
      AddMessage(STEP_1_FINISHED)
    else:
      try:
        compute_adjacency_list(inputs[INPUT_POINTS], inputs[INPUT_NETWORK],
            inputs[ID_ATTRIBUTE], inputs[IMPEDANCE_ATTRIBUTE],
            inputs[ACCUMULATOR_ATTRIBUTES], inputs[SEARCH_RADIUS],
            inputs[OUTPUT_LOCATION], adj_dbf_name)
        AddMessage(STEP_1_FINISHED)
      except:
        AddWarning(GetMessages(2))
        AddMessage(STEP_1_FAILED)
        success = False

  # Step 2
  if success:
    AddMessage(STEP_2_STARTED)
    try:
      distance_field = trim("Total_%s" % inputs[IMPEDANCE_ATTRIBUTE])
      accumulator_fields = set([trim("Total_%s" % accumulator_attribute)
          for accumulator_attribute in inputs[ACCUMULATOR_ATTRIBUTES].split(";")
          if accumulator_attribute != "#"])
      # Graph representation: dictionary mapping node id's to Node objects
      nodes = {}
      # The number of rows in |adj_dbf|
      directed_edge_count = int(GetCount_management(adj_dbf).getOutput(0))
      graph_progress = Progress_Bar(directed_edge_count, 1, STEP_2)
      rows = UpdateCursor(adj_dbf)
      for row in rows:
        # Get neighboring nodes, and the distance between them
        origin_id = row.getValue(trim(ORIGIN_ID_FIELD_NAME))
        destination_id = row.getValue(trim(DESTINATION_ID_FIELD_NAME))
        distance = float(row.getValue(distance_field))
        # Make sure the nodes are recorded in the graph
        for id in [origin_id, destination_id]:
          if not id in nodes:
            nodes[id] = Node()
        # Make sure that the nodes are neighbors in the graph
        if origin_id != destination_id and distance >= 0:
          accumulations = {}
          for field in accumulator_fields:
            accumulations[field] = float(row.getValue(field))
          nodes[origin_id].add_neighbor(destination_id, distance, accumulations)
          nodes[destination_id].add_neighbor(origin_id, distance, accumulations)
        graph_progress.step()
      N = len(nodes) # The number of nodes in the graph
      if N == 0:
        AddWarning(WARNING_NO_NODES)
        success = False
      AddMessage(STEP_2_FINISHED)
    except:
      AddWarning(GetMessages(2))
      AddMessage(STEP_2_FAILED)
      success = False

  # Step 3
  if success:
    AddMessage(STEP_3_STARTED)
    try:
      get_weights = inputs[NODE_WEIGHT_ATTRIBUTE] != "#"
      get_locations = inputs[COMPUTE_STRAIGHTNESS]
      # Keep track of number nodes in input points not present in the graph
      point_not_in_graph_count = 0
      input_point_count = int(
          GetCount_management(inputs[INPUT_POINTS]).getOutput(0))
      node_attribute_progress = Progress_Bar(input_point_count, 1, STEP_3)
      rows = UpdateCursor(inputs[INPUT_POINTS])
      for row in rows:
        id = row.getValue(inputs[ID_ATTRIBUTE])
        if not id in nodes:
          point_not_in_graph_count += 1
          continue
        if get_weights:
          setattr(nodes[id], WEIGHT,
              row.getValue(trim(inputs[NODE_WEIGHT_ATTRIBUTE])))
        if get_locations:
          snap_x = row.getValue(trim("SnapX"))
          snap_y = row.getValue(trim("SnapY"))
          setattr(nodes[id], LOCATION, (snap_x, snap_y))
        node_attribute_progress.step()
      if point_not_in_graph_count:
        AddWarning(WARNING_POINTS_NOT_IN_GRAPH(N,
            point_not_in_graph_count))
      AddMessage(STEP_3_FINISHED)
    except:
      AddWarning(GetMessages(2))
      AddMessage(STEP_3_FAILED)
      success = False

  # Step 4
  if success:
    AddMessage(STEP_4_STARTED)
    try:
      # Compute measures
      compute_centrality(nodes, selected_features, inputs[COMPUTE_REACH],
          inputs[COMPUTE_GRAVITY], inputs[COMPUTE_BETWEENNESS],
          inputs[COMPUTE_CLOSENESS], inputs[COMPUTE_STRAIGHTNESS],
          inputs[SEARCH_RADIUS], inputs[BETA], inputs[NORMALIZE_RESULTS],
          accumulator_fields)
      AddMessage(STEP_4_FINISHED)
    except:
      AddWarning(GetMessages(2))
      AddMessage(STEP_4_FAILED)
      success = False

  # Step 5
  if success:
    AddMessage(STEP_5_STARTED)
    try:
      # Make output layer
      MakeFeatureLayer_management(in_features=output_feature_class,
          out_layer=output_layer_name)
      # Save output layer
      SaveToLayerFile_management(output_layer_name, output_layer,
          "ABSOLUTE")
      # Use a test node to figure out which metrics were computed
      test_node = nodes[selected_features.pop()]
      measures = set([measure for measure in dir(test_node) if (measure in
          FINAL_ATTRIBUTES or is_accumulator_field(measure))])
      # Add a field in the output layer for each computed metric
      for measure in measures:
        AddField_management(in_table=output_layer, field_name=trim(measure),
            field_type="DOUBLE", field_is_nullable="NON_NULLABLE")
      # Figure out the id field to use based on the type of the input buildings
      if (buildings_description.shapeType == "Polygon" and
          inputs[ID_ATTRIBUTE] == ORIGINAL_FID):
        id_field = "FID"
      else:
        id_field = inputs[ID_ATTRIBUTE]
      # Fill the layer with the metric values
      write_progress = Progress_Bar(N, 1, STEP_5)
      layer_rows = UpdateCursor(output_layer)
      for row in layer_rows:
          id = row.getValue(id_field)
          for measure in measures:
            # If no value was computed for this node id, set value to 0
            value = 0
            if id in nodes and hasattr(nodes[id], measure):
              value = getattr(nodes[id], measure)
            row.setValue(trim(measure), value)
          layer_rows.updateRow(row)
          write_progress.step()
      AddMessage(STEP_5_FINISHED)
    except:
      AddWarning(GetMessages(2))
      AddMessage(STEP_5_FAILED)
      success = False

  # Step 6
  if success:
    AddMessage(STEP_6_STARTED)
    # Apply symbology
    try:
      ApplySymbologyFromLayer_management(in_layer=output_layer,
          in_symbology_layer=symbology_layer)
    except:
      AddWarning(WARNING_APPLY_SYMBOLOGY_FAILED)
      AddWarning(GetMessages(2))
      AddMessage(STEP_6_FAILED)
    # Display
    try:
      current_map_document = mapping.MapDocument("CURRENT")
      data_frame = mapping.ListDataFrames(current_map_document,
          "Layers")[0]
      add_layer = mapping.Layer(output_layer)
      mapping.AddLayer(data_frame, add_layer, "AUTO_ARRANGE")
      AddMessage(STEP_6_FINISHED)
    except:
      AddWarning(WARNING_FAIL_TO_DISPLAY)
      AddWarning(GetMessages(2))
      AddMessage(STEP_6_FAILED)

  # Clean up
  clean_up()

  if success: AddMessage(SUCCESS)
  else: AddMessage(FAILURE)

except ExecuteAbort:
  clean_up()