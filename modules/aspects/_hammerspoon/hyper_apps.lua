local ok, hostName = pcall(require, "host")
if not ok then
	print("host.lua not found; using fenrir hyper app bindings")
	hostName = "fenrir"
end

return require("hyper_apps_" .. hostName)
