local FRemap = require("foundation_remapping")
local remapper = FRemap.new()

remapper:remap("rcmd", "f18")
remapper:remap("capslock", "f17")
remapper:register()

hs.loadSpoon("EscapeInputEnglish")
hs.loadSpoon("HyperKeyBindings")

spoon.EscapeInputEnglish:setInputSource("com.apple.keylayout.ABC"):start()

spoon.HyperKeyBindings
	:setHyperKey("f17")
	:onTap(function()
		spoon.EscapeInputEnglish:escape()
	end)
	:bind("r", function()
		hs.reload()
	end)
	:bindApps({
		t = "com.github.wez.wezterm",
		b = "company.thebrowser.Browser",
		a = "com.daymore.Across",
		f = "com.apple.finder",
		k = "com.kakao.KakaoTalkMac",
		l = "ru.keepcoder.Telegram",
		m = "com.apple.mail",
	})

spoon.HyperKeyBindings:start()

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "i", function()
	local app = hs.application.frontmostApplication()

	print("name: " .. app:name())
	print("bundleID: " .. app:bundleID())
	print("path: " .. app:path())

	hs.alert.show(app:name() .. "\n" .. app:bundleID() .. "\n" .. app:path())
end)

hs.alert.show("Hammerspoon loaded")
