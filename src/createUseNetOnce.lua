--!strict

local function createUseNetOnce(useState, useEffect): (any, string) -> ...any
	return function(redNamespaceNet, eventName)
		local variables, setVariables = useState({})

		useEffect(function()
			redNamespaceNet:On(eventName, function(...)
				setVariables({ ... })
			end)
		end, {})

		return unpack(variables)
	end
end

return createUseNetOnce
