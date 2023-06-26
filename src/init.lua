local createUseNetOn = require(script.createUseNetOn)
local createUseNetOnce = require(script.createUseNetOnce)

return function(useStateHook, useEffectHook)
	return {
		useNetOn = createUseNetOn(useStateHook, useEffectHook),
		useNetOnce = createUseNetOnce(useStateHook, useEffectHook),
	}
end
