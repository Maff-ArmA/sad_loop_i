
//	[GhostHawk, [3300,5800,0], 300] execVM "search.sqf";

params ["_grp","_pos","_rad"];

for "_r" from 1 to 3 do
{
	_wp = (group _grp) addWaypoint [_pos, _rad];
	_wp setWaypointType "SAD";
};

	_wp = (group _grp) addWaypoint [_pos, _rad];
	_wp setWaypointType "CYCLE";