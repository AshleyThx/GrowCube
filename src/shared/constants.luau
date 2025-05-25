local runservice = game:GetService("RunService")

return {
	IS_STUDIO = runservice:IsStudio(),
	IS_CLIENT = runservice:IsClient(),
}
