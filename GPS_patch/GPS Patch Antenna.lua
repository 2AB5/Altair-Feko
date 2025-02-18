-- Script recorded on Tue Feb 18 11:00:39 2025
application = cf.Application.GetInstance()

-- SetProperties
properties = application.Project.ModelAttributes:GetProperties()
properties.Unit = cf.Enums.ModelUnitEnum.Metres
application.Project.ModelAttributes:SetProperties(properties)

-- SetProperties
properties = application.Project.ModelAttributes:GetProperties()
properties.Unit = cf.Enums.ModelUnitEnum.Millimetres
application.Project.ModelAttributes:SetProperties(properties)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "18.8"
properties1.Label = "patch_size"
patch_size = application.Project.Definitions.Variables:Add(properties1)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "4.3"
properties1.Label = "chamfer_d"
chamfer_d = application.Project.Definitions.Variables:Add(properties1)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "-6.4"
properties1.Label = "feed_pos"
feed_pos = application.Project.Definitions.Variables:Add(properties1)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "45"
properties1.Label = "substrate_w"
substrate_w = application.Project.Definitions.Variables:Add(properties1)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "45"
properties1.Label = "substrate_d"
substrate_d = application.Project.Definitions.Variables:Add(properties1)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "5"
properties1.Label = "substrate_h"
substrate_h = application.Project.Definitions.Variables:Add(properties1)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "5.6"
properties1.Label = "cermaic_epsR"
cermaic_epsR = application.Project.Definitions.Variables:Add(properties1)

-- Add
properties1 = cf.Variable.GetDefaultProperties()
properties1.Expression = "0.0041"
properties1.Label = "cermaic_tanD"
cermaic_tanD = application.Project.Definitions.Variables:Add(properties1)

-- CreateGroup
group1 = application.Project.Definitions.Variables:CreateGroup()

-- MoveIn
group1:MoveIn({patch_size, chamfer_d})

-- Setting Label
group1.Label = "patch"

-- CreateGroup
group11 = application.Project.Definitions.Variables:CreateGroup()

-- MoveIn
group11:MoveIn({substrate_w, substrate_d, substrate_h})

-- Setting Label
group11.Label = "substrate"

-- AddDielectric
properties2 = cf.Dielectric.GetDefaultProperties()
properties2.DielectricModelling.RelativePermittivity = "cermaic_epsR"
properties2.DielectricModelling.LossTangent = "cermaic_tanD"
properties2.Label = "cermaic"
cermaic = application.Project.Definitions.Media.Dielectric:AddDielectric(properties2)

-- AddPolygon
properties3 = cf.Polygon.GetDefaultProperties()
properties3.Corners[1].U = "patch.patch_size"
properties3.Corners[1].V = "patch.patch_size"
properties3.Corners[1].N = "substrate.substrate_h"
properties3.Corners[2].U = "-patch.patch_size+patch.chamfer_d"
properties3.Corners[2].V = "patch.patch_size"
properties3.Corners[2].N = "substrate.substrate_h"
properties3.Corners[3].U = "-Patch.patch_size"
properties3.Corners[3].V = "Patch.patch_size - Patch.chamfer_d"
properties3.Corners[3].N = "Substrate.substrate_h"
properties3.Corners[4] = {}
properties3.Corners[4].U = "-Patch.patch_size"
properties3.Corners[4].V = "-Patch.patch_size"
properties3.Corners[4].N = "Substrate.substrate_h"
properties3.Corners[5] = {}
properties3.Corners[5].U = "Patch.patch_size - Patch.chamfer_d"
properties3.Corners[5].V = "-Patch.patch_size"
properties3.Corners[5].N = "Substrate.substrate_h"
properties3.Corners[6] = {}
properties3.Corners[6].U = "Patch.patch_size"
properties3.Corners[6].V = "-Patch.patch_size + Patch.chamfer_d"
properties3.Corners[6].N = "Substrate.substrate_h"
properties3.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
globalXY = application.Project.Definitions.Workplanes:Item("Global XY")
properties3.LocalWorkplane.ReferencedWorkplane = globalXY
properties3.Label = "patch"
patch = application.Project.Contents.Geometry:AddPolygon(properties3)

-- AddCuboid
properties4 = cf.Cuboid.GetDefaultProperties()
properties4.Origin.U = "-22.5"
properties4.Origin.V = "-22.5"
properties4.Width = "substrate.substrate_w"
properties4.Depth = "substrate.substrate_d"
properties4.Height = "substrate.substrate_h"
properties4.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties4.LocalWorkplane.ReferencedWorkplane = globalXY
properties4.Label = "substrate"
substrate = application.Project.Contents.Geometry:AddCuboid(properties4)

-- SetProperties
properties5 = substrate.Regions:Item("Region1"):GetProperties()
properties5.Medium = cermaic
substrate.Regions:Item("Region1"):SetProperties(properties5)

-- AddLine
properties6 = cf.Line.GetDefaultProperties()
properties6.StartPoint.V = "feed_pos"
properties6.EndPoint.U = "0"
properties6.EndPoint.V = "feed_pos"
properties6.EndPoint.N = "substrate.substrate_h"
properties6.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties6.LocalWorkplane.ReferencedWorkplane = globalXY
properties6.Label = "feed_line"
feed_line = application.Project.Contents.Geometry:AddLine(properties6)

-- AddUnion
union1 = application.Project.Contents.Geometry:Union({patch, substrate, feed_line})

-- SetProperties
properties7 = patch.Faces:Item("Face1"):GetProperties()
perfectElectricConductor = application.Project.Definitions.Media.PerfectElectricConductor
properties7.Medium = perfectElectricConductor
patch.Faces:Item("Face1"):SetProperties(properties7)

-- Hide
face2 = substrate.Faces:Item("Face2")
face3 = substrate.Faces:Item("Face3")
face4 = substrate.Faces:Item("Face4")
face7 = substrate.Faces:Item("Face7")
application.Project:Hide({face2, face3, face4, face7})

-- Hide
face5 = substrate.Faces:Item("Face5")
application.Project:Hide({face5})

-- SetProperties
properties8 = union1.Faces:Item("Face6"):GetProperties()
properties8.Medium = perfectElectricConductor
union1.Faces:Item("Face6"):SetProperties(properties8)

-- SetProperties
properties9 = union1.Faces:Item("Face8"):GetProperties()
properties9.Medium = perfectElectricConductor
union1.Faces:Item("Face8"):SetProperties(properties9)

-- SetProperties
properties10 = union1.Faces:Item("Face6"):GetProperties()
union1.Faces:Item("Face6"):SetProperties(properties10)

-- SetProperties
properties11 = union1.Faces:Item("Face8"):GetProperties()
union1.Faces:Item("Face8"):SetProperties(properties11)

-- ShowAll
application.Project:ShowAll()

-- AddWirePort
properties12 = cf.WirePort.GetDefaultProperties()
wire19 = feed_line.Wires:Item("Wire19")
properties12.Wire = wire19
properties12.Label = "Port1"
port1 = application.Project.Contents.Ports:AddWirePort(properties12)

-- AddVoltageSource
properties13 = cf.VoltageSource.GetDefaultProperties()
properties13.Port = port1
properties13.Label = "VoltageSource1"
voltageSource1 = application.Project.Contents.SolutionConfigurations.GlobalSources:AddVoltageSource(properties13)

-- SetProperties
properties14 = application.Project.Contents.SolutionConfigurations.GlobalFrequency:GetProperties()
properties14.Start = "1.27e9"
properties14.End = "1.85e9"
properties14.RangeType = cf.Enums.FrequencyRangeTypeEnum.Continuous
application.Project.Contents.SolutionConfigurations.GlobalFrequency:SetProperties(properties14)

-- SetProperties
properties15 = application.Project.Mesher.Settings:GetProperties()
properties15.MeshSizeOption = cf.Enums.MeshSizeOptionEnum.Fine
properties15.WireRadius = "0.7"
application.Project.Mesher.Settings:SetProperties(properties15)

-- ToggleVisibility
application.Project.Contents.Cutplanes:Item("YZ-Cut"):ToggleVisibility()

-- Show
yZCut = application.Project.Contents.Cutplanes:Item("YZ-Cut")
application.Project:Show({yZCut})

-- Hide
application.Project:Hide({yZCut})

-- SetProperties
properties16 = patch.Edges:Item("Edge3"):GetProperties()
properties16.LocalMeshSizeEnabled = true
properties16.LocalMeshSize = "2"
patch.Edges:Item("Edge3"):SetProperties(properties16)

-- SetProperties
properties17 = patch.Edges:Item("Edge6"):GetProperties()
properties17.LocalMeshSizeEnabled = true
properties17.LocalMeshSize = "2"
patch.Edges:Item("Edge6"):SetProperties(properties17)

-- SetProperties
properties18 = patch.Edges:Item("Edge3"):GetProperties()
patch.Edges:Item("Edge3"):SetProperties(properties18)

-- SetProperties
properties19 = patch.Edges:Item("Edge6"):GetProperties()
patch.Edges:Item("Edge6"):SetProperties(properties19)

-- Add
properties20 = cf.FarField.GetDefaultProperties()
properties20.Theta.End = "180"
properties20.Theta.Increment = "5"
properties20.Phi.End = "360"
properties20.Phi.Increment = "5"
properties20.Label = "FarField1"
properties20.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties20.LocalWorkplane.ReferencedWorkplane = globalXY
farField1 = application.Project.Contents.SolutionConfigurations:Item("StandardConfiguration1").FarFields:Add(properties20)

