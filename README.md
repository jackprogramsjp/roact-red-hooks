# roact-red-hooks
Roact Hooks for the networking library, [Red](https://github.com/red-blox/Red)

**NOTE:** This library uses hooks based from Roact17, so you can still use this library with Legacy Roact, but you have to create your own hooks or use hooks from third-party libraries. Here is one good: https://github.com/Kampfkarren/roact-hooks

The documentation below is somewhat unconventional, but that's because this module is very small.

## Documentation

To initialize RedHooks, just require it, which returns function, and call the function:
```lua
local RedHooks = require(Packages.RedHooks)(useStateHook, useEffectHook)
```
The two parameters expect the hook function from Roact.

The first parameter requires a `useState` hook function. With Roact17, you can just put in `Roact.useState` as simple as that.

The second parameter requires a `useEffect` hook function. With Roact17, you can just put in `Roact.useEffect` as simple as that.

-----------

### `useNetOn(RedNamespaceNet, eventName: string) -> ...any`

```lua
local RedHooks = require(Packages.RedHooks)(useStateHook, useEffectHook)
local Net = Red.Client("NamespaceName")

-- In some Roact component
local example1, example2, example3 = RedHooks.useNetOn(Net, "EventName")
```
The first parameter is the namespace that you have created with Red.

The second parameter is the event name of what Red is listening.

The Red documentation say that "an event can only have a single listener." This is true, but we take care of that, so you can call `useNetOn` on the same event name as many times as you want, due to how it may have to be used on multiple components.

-----------

### `useNetOnce(RedNamespaceNet, eventName: string) -> ...any`

```lua
local RedHooks = require(Packages.RedHooks)(useStateHook, useEffectHook)
local Net = Red.Client("NamespaceName")

-- In some Roact component
local example1, example2, example3 = RedHooks.useNetOnce(Net, "EventName")
```
The first parameter is the namespace that you have created with Red.

The second parameter is the event name of what Red is listening.

This uses less memory and has better performance than `useNetOn` because it assumes that you are going to call this function only once with the specific event name, meaning that once you call this function, you are not going to use the same `eventName` when you call a new function of this. 

-----------

## Understanding the difference between `useNetOn` and `useNetOnce`
**Bad:**
```lua
local RedHooks = require(Packages.RedHooks)(useStateHook, useEffectHook)
local Net = Red.Client("NamespaceName")

-- In some Roact component
local example1, example2, example3 = RedHooks.useNetOnce(Net, "Event1")
-- In some other part of the code
local example1, example2, example3 = RedHooks.useNetOnce(Net, "Event1")
-- Can't call `useNetOnce` more than once on the same event name
```
**Good:**
* ```lua
  local RedHooks = require(Packages.RedHooks)(useStateHook, useEffectHook)
  local Net = Red.Client("NamespaceName")
  
  -- In some Roact component
  local example1, example2, example3 = RedHooks.useNetOn(Net, "Event1")
  -- In some other part of the code
  local example1, example2, example3 = RedHooks.useNetOn(Net, "Event1")
  -- Can't call `useNetOnce` more than once on the same event name,
  -- but you can call `useNetOn` more than once on same event name
  ```
* **OR**

* ```lua
  local RedHooks = require(Packages.RedHooks)(useStateHook, useEffectHook)
  local Net = Red.Client("NamespaceName")
  
  -- In some Roact component
  local example1, example2, example3 = RedHooks.useNetOnce(Net, "Event1")
  -- In some other part of the code
  local example1, example2, example3 = RedHooks.useNetOnce(Net, "Event2")
  -- As long as the event names are different, that's fine
  ```
