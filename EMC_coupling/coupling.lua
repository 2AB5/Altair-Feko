-- Script recorded on Wed Feb 26 10:56:55 2025
application = cf.Application.GetInstance()

-- AddLine
properties = cf.Line.GetDefaultProperties()
properties.EndPoint.U = "0"
properties.EndPoint.V = "0"
properties.EndPoint.N = "12"
properties.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
globalXY = application.Project.Definitions.Workplanes:Item("Global XY")
properties.LocalWorkplane.ReferencedWorkplane = globalXY
properties.Label = "monopole"
monopole = application.Project.Contents.Geometry:AddLine(properties)

-- ZoomToExtents
application.MainWindow.MdiArea:Item("3D View1").ViewWindow.View:ZoomToExtents()

-- Setting MainVisible
_3DView1 = application.MainWindow.MdiArea:Item("3D View1")
_3DView1.Axes.MainVisible = false

-- AddPolyline
properties1 = cf.Polyline.GetDefaultProperties()
properties1.Corners[1].V = "2"
properties1.Corners[2].U = "0"
properties1.Corners[2].V = "2"
properties1.Corners[2].N = "0.05"
properties1.Corners[3] = {}
properties1.Corners[3].U = "0"
properties1.Corners[3].V = "14"
properties1.Corners[3].N = "0.05"
properties1.Corners[4] = {}
properties1.Corners[4].U = "0"
properties1.Corners[4].V = "14"
properties1.Corners[4].N = "0"
properties1.LocalWorkplane.WorkplaneDefinitionOption = cf.Enums.LocalWorkplaneDefinitionEnum.UsePredefinedWorkplane
properties1.LocalWorkplane.ReferencedWorkplane = globalXY
properties1.Label = "Transmission_line"
transmission_line = application.Project.Contents.Geometry:AddPolyline(properties1)

-- SetProperties
properties2 = application.Project.Contents.SolutionSettings.GroundPlane:GetProperties()
properties2.DefinitionMethod = cf.Enums.GroundPlaneDefinitionMethodEnum.PEC
application.Project.Contents.SolutionSettings.GroundPlane:SetProperties(properties2)

-- ZoomToExtents
_3DView1.ViewWindow.View:ZoomToExtents()

-- AddWirePort
properties3 = cf.WirePort.GetDefaultProperties()
wire1 = monopole.Wires:Item("Wire1")
properties3.Wire = wire1
properties3.Label = "WirePort1"
wirePort1 = application.Project.Contents.Ports:AddWirePort(properties3)

-- SetViewDirection
_3DView1.ViewWindow.View:SetViewDirection(cf.Enums.ViewDirectionEnum.Front)

-- AddWirePort
properties4 = cf.WirePort.GetDefaultProperties()
wire4 = transmission_line.Wires:Item("Wire4")
properties4.Wire = wire4
properties4.Label = "WirePort2"
wirePort2 = application.Project.Contents.Ports:AddWirePort(properties4)

-- AddVoltageSource
properties5 = cf.VoltageSource.GetDefaultProperties()
properties5.Port = wirePort1
properties5.Label = "VoltageSource1"
voltageSource1 = application.Project.Contents.SolutionConfigurations.GlobalSources:AddVoltageSource(properties5)

-- AddLoad
properties6 = cf.Load.GetDefaultProperties()
properties6.Port = wirePort2
properties6.ImpedanceReal = "1000"
properties6.Label = "Load1"
load1 = application.Project.Contents.SolutionConfigurations.GlobalLoads:AddLoad(properties6)

-- SetProperties
properties7 = application.Project.Contents.SolutionConfigurations.GlobalPower:GetProperties()
properties7.ScaleSettings = cf.Enums.PowerScaleSettingsEnum.TotalSourcePower
properties7.SourcePower = "1"
application.Project.Contents.SolutionConfigurations.GlobalPower:SetProperties(properties7)

-- SetProperties
properties8 = application.Project.Contents.SolutionConfigurations.GlobalFrequency:GetProperties()
properties8.Start = "1e6"
properties8.End = "30e6"
properties8.RangeType = cf.Enums.FrequencyRangeTypeEnum.Continuous
application.Project.Contents.SolutionConfigurations.GlobalFrequency:SetProperties(properties8)

-- SetProperties
properties9 = application.Project.Mesher.Settings:GetProperties()
properties9.WireRadius = "0.004"
application.Project.Mesher.Settings:SetProperties(properties9)

-- SetProperties
properties10 = wire1:GetProperties()
properties10.LocalWireRadiusEnabled = true
properties10.LocalWireRadius = "0.015"
wire1:SetProperties(properties10)

-- SaveAs
application:SaveAs("C:/Users/Abinav/Documents/Feko/EMC Coupling/coupling.cfx")

-- RunFEKOAndContinue
application.Launcher:RunFEKOAndContinue()

-- RunPOSTFEKO
application.Launcher:RunPOSTFEKO()

