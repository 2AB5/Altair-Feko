-- Script recorded on Tue Feb 18 12:35:03 2025
application = cf.Application.GetInstance()

-- DeleteEntities
quadcopter_simple1 = application.Project.Contents.Geometry:Item("Quadcopter_simple1")
application.Project.Contents.Geometry:DeleteEntities({quadcopter_simple1})

--Add component from library to existing model
error("Macro recording is not supported for the Component Library.")

-- AddAlign
properties = cf.Align.GetDefaultProperties()
properties.DestinationWorkplane.LocalDefinedWorkplane.Origin.Z = "-100"
properties.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
globalXY = application.Project.Definitions.Workplanes:Item("Global XY")
properties.LocalWorkplane.ReferencedWorkplane = globalXY
align1 = application.Project.Contents.Geometry:Item("Quadcopter_simple1").Transforms:AddAlign(properties)

-- SetProperties
properties1 = cf.CFXModelImporter.GetDefaultProperties()
application.Project.Importer.CFXModel:SetProperties(properties1)

-- Import
application.Project.Importer.CFXModel:Import("C:/Users/Abinav/Documents/Feko/GPS_Patch/GPS_Patch.cfx")

-- ZoomToExtents
application.MainWindow.MdiArea:Item("3D View1").ViewWindow.View:ZoomToExtents()

-- Setting Label
union1 = application.Project.Contents.Geometry:Item("Union1")
union1.Label = "Patch"

-- SetProperties
properties2 = application.Project.Contents.SolutionConfigurations.GlobalFrequency:GetProperties()
properties2.Start = "1.27e9"
properties2.End = "1.85e9"
properties2.RangeType = cf.Enums.FrequencyRangeTypeEnum.Continuous
application.Project.Contents.SolutionConfigurations.GlobalFrequency:SetProperties(properties2)

-- Setting OverlayModeEnabled
_3DView1 = application.MainWindow.MdiArea:Item("3D View1")
_3DView1.DisplayMode.OverlayModeEnabled = false

-- AddRotate
properties3 = cf.Rotate.GetDefaultProperties()
properties3.Angle = "45"
properties3.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties3.LocalWorkplane.ReferencedWorkplane = globalXY
rotate1 = application.Project.Contents.Geometry:Item("Quadcopter_simple1").Transforms:AddRotate(properties3)

-- Add
properties4 = cf.Workplane.GetDefaultProperties()
properties4.LocalPlane.Origin.U = "0.039745816329"
properties4.LocalPlane.Origin.V = "-0.03974476241"
properties4.LocalPlane.Origin.N = "-25.134114558"
properties4.LocalPlane.UVector.U = "1"
properties4.LocalPlane.UVector.V = "2.5464930389e-24"
properties4.LocalPlane.UVector.N = "-1.5957959953e-12"
properties4.LocalPlane.VVector.U = "0"
properties4.LocalPlane.VVector.V = "1"
properties4.LocalPlane.VVector.N = "1.5957509897e-12"
properties4.Label = "Workplane1"
properties4.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties4.LocalWorkplane.ReferencedWorkplane = globalXY
workplane1 = application.Project.Definitions.Workplanes:Add(properties4)

-- Setting Label
workplane1.Label = "Workplane_quadcopter"

-- Add
properties5 = cf.Workplane.GetDefaultProperties()
properties5.LocalPlane.Origin.U = "0"
properties5.LocalPlane.Origin.V = "-3.5527136788e-15"
properties5.LocalPlane.Origin.N = "5"
properties5.LocalPlane.UVector.U = "1"
properties5.LocalPlane.UVector.V = "0"
properties5.LocalPlane.UVector.N = "0"
properties5.LocalPlane.VVector.U = "0"
properties5.LocalPlane.VVector.V = "1"
properties5.LocalPlane.VVector.N = "0"
properties5.Label = "Workplane_patch"
properties5.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties5.LocalWorkplane.ReferencedWorkplane = globalXY
workplane_patch = application.Project.Definitions.Workplanes:Add(properties5)

-- Setting OverlayModeEnabled
_3DView1.DisplayMode.OverlayModeEnabled = true

-- Setting OverlayModeEnabled
_3DView1.DisplayMode.OverlayModeEnabled = false

-- SetProperties
properties6 = align1:GetProperties()
properties6.SourceWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties6.SourceWorkplane.ReferencedWorkplane = workplane1
align1:SetProperties(properties6)

-- SetProperties
properties7 = align1:GetProperties()
properties7.DestinationWorkplane.LocalDefinedWorkplane.Origin.Z = "-95"
align1:SetProperties(properties7)

-- AddUnion
quadcopter_simple11 = application.Project.Contents.Geometry:Item("Quadcopter_simple1")
union11 = application.Project.Contents.Geometry:Union({quadcopter_simple11, union1})

-- Setting OverlayModeEnabled
_3DView1.DisplayMode.OverlayModeEnabled = true

-- SaveAs
application:SaveAs("C:/Users/Abinav/Documents/Feko/GPS_patch_on_quadcopter/patch_on_drone.cfx")

-- RunFEKOAndContinue
application.Launcher:RunFEKOAndContinue()

-- RunPOSTFEKO
application.Launcher:RunPOSTFEKO()

