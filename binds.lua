local pairs = pairs
local input = input
local hook = hook
local error = error
local isnumber = isnumber
local isfunction = isfunction

module( "bind" )

local Binds = {}
local CurDown = {}

function Add( bind, name, func )
	if !isnumber( bind ) then error( "bind is not a number" ) end
	if !name then error( "no name provided" ) end
	if !isfunction( func ) then error( "function is not a function" ) end
	
	if !Binds[ bind ] then
		Binds[ bind ] = {}
	end
	
	Binds[ bind ][ name ] = func
end

function Remove( bind, name )
	if !isnumber( bind ) then error( "bind is not a number" ) end
	if !name then error( "no name provided" ) end
	
	if Binds[ bind ] then
		Binds[ bind ][ name ] = nil
	end
end

function GetTable()
	return Binds
end

function Caller()
	for k,v in pairs( Binds ) do
		if input.IsButtonDown( k ) then
			if CurDown[ k ] then continue end
			CurDown[ k ] = true
			for _k,func in pairs( v ) do
				func()
			end
		else
			CurDown[ k ] = false
		end
	end
end
hook.Add( "Think", "binds.binder", Caller )