# ------------------------------------------------------------------------------
# Urban Network Analysis Toolbox for ArcGIS10
# Credits: Michael Mekonnen, Andres Sevtsuk
# MIT City Form Research Group
# Usage: Creative Commons Attribution - NonCommercial - ShareAlike 3.0 Unported
#   License
# License: http://creativecommons.org/licenses/by-nc-sa/3.0/
# ------------------------------------------------------------------------------

"""
Tool validation.
"""

import arcpy

class ToolValidator:
  """
  Validator for the tool's parameters
  Controls the behavior of the tool's dialog
  """

  def __init__(self):
    params = arcpy.GetParameterInfo()

    self.inputs = {}
    self.inputs["input_buildings"] = params[0]
    self.inputs["point_location"] = params[1]
    self.inputs["input_network"] = params[2]
    self.inputs["compute_reach"] = params[3]
    self.inputs["compute_gravity"] = params[4]
    self.inputs["compute_betweenness"] = params[5]
    self.inputs["compute_closeness"] = params[6]
    self.inputs["compute_straightness"] = params[7]
    self.inputs["id_attribute"] = params[8]
    self.inputs["node_weight_attribute"] = params[9]
    self.inputs["impedance_attribute"] = params[10]
    self.inputs["search_radius"] = params[11]
    self.inputs["beta"] = params[12]
    self.inputs["normalize_results"] = params[13]
    self.inputs["output_location"] = params[14]
    self.inputs["output_file_name"] = params[15]
    self.inputs["accumulator_attributes"] = params[16]

  def initializeParameters(self):
    """
    Called when the tool is opened
    """
    self.inputs["accumulator_attributes"].category = "Accumulators"
    self.inputs["normalize_results"].category = "Normalization"
    self.inputs["point_location"].enabled = False

  def updateParameters(self):
    """
    Called whenever a parameter has been changed
    """
    # point_location
    try:
      buildings_type = str(
          arcpy.Describe(self.inputs["input_buildings"].value).shapeType)
      self.inputs["point_location"].enabled = buildings_type == "Polygon"
    except:
      pass

    # impedance_attribute
    network = self.inputs["input_network"]
    if network.altered:
      if network.value and not network.hasBeenValidated:
        try:
          self.get_network_properties(network)
        except:
          self.reset_network_properties()
    else:
      self.reset_network_properties()

    # beta
    self.inputs["beta"].enabled = self.inputs["compute_gravity"].value

    # normalize_results
    metrics_to_compute = []
    norm_results = self.inputs["normalize_results"]
    if self.inputs["compute_reach"].value:
      metrics_to_compute.append("Reach")
    if self.inputs["compute_gravity"].value:
      metrics_to_compute.append("Gravity")
    if self.inputs["compute_betweenness"].value:
      metrics_to_compute.append("Betweenness")
    if self.inputs["compute_closeness"].value:
      metrics_to_compute.append("Closeness")
    if self.inputs["compute_straightness"].value:
      metrics_to_compute.append("Straightness")
    norm_results.filter.list = metrics_to_compute
    norm_results.enabled = bool(metrics_to_compute)

  def updateMessages(self):
    """
    Called after internal validation
    """
    # centrality metrics
    reach = self.inputs["compute_reach"]
    gravity = self.inputs["compute_gravity"]
    betweenness = self.inputs["compute_betweenness"]
    closeness = self.inputs["compute_closeness"]
    straightness = self.inputs["compute_straightness"]
    if not any(metric.value for metric in (reach, gravity, betweenness,
        closeness, straightness)):
      reach.setErrorMessage("Please select at leaste one metric")

    # id_attribute
    id_attribute = self.inputs["id_attribute"]
    input_buildings = self.inputs["input_buildings"]
    if id_attribute.altered or input_buildings.altered:
      if id_attribute.parameterType != "Integer":
        id_attribute.setWarningMessage("Attribute datatype should be Integer")

    # search_radius
    network = self.inputs["input_network"]
    impedance = self.inputs["impedance_attribute"]
    search_radius = self.inputs["search_radius"]
    if network.altered or impedance.altered:
      try:
        for attribute in arcpy.Describe(network.value).attributes:
          if attribute.name == impedance.value:
            search_radius.setWarningMessage("Units: %s" % attribute.units)
            return
        search_radius.setWarningMessage("No units")
      except:
        search_radius.setWarningMessage("No units")

  def get_network_properties(self, network):
    """
    Updates list of cost attributes based on the input network
    """
    impedance = self.inputs["impedance_attribute"]
    accumulators = self.inputs["accumulator_attributes"]
    description = arcpy.Describe(network.value)
    defalut_cost_attribute = ""
    cost_attributes = []
    for attribute in description.attributes:
      if attribute.usageType == "Cost":
        if attribute.useByDefault:
          default_cost_attribute = attribute.name
        cost_attributes.append(attribute.name)
    impedance.filter.list = cost_attributes
    accumulators.filter.list = cost_attributes
    if not impedance.altered:
      if default_cost_attribute == "" and cost_attributes:
        default_cost_attribute = cost_attributes[0]
      impedance.value = default_cost_attribute

  def reset_network_properties(self):
    """
    Reset the list of cost attributes
    """
    impedance = self.inputs["impedance_attribute"]
    impedance.filter.list = []
    impedance.value = ""
    self.inputs["accumulator_attributes"].filter.list = []