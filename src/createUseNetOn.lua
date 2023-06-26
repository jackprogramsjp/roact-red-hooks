--!strict

local Events: { [string]: { event: any?, values: { any }, onChanges: { () -> () } } } = {}

local function createUseNetOn(useState, useEffect): (any, string) -> ...any
	return function(redNamespaceNet, eventName)
		local variables, setVariables = useState({})

		useEffect(function()
			if Events[eventName] ~= nil then
				table.insert(Events[eventName].onChanges, function()
					setVariables(Events[eventName].values)
				end)

				return
			end

			Events[eventName] = {
				values = {},
				onChanges = {},
			}

			table.insert(Events[eventName].onChanges, function()
				setVariables(Events[eventName].values)
			end)

			redNamespaceNet:On(eventName, function(...)
				Events[eventName].values = { ... }
				for _, onChange in Events[eventName].onChanges do
					onChange()
				end
			end)
		end, {})

		return unpack(variables)
	end
end

return createUseNetOn
