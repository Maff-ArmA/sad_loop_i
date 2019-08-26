
//	_go = [this, [1234,5678,0], 350, "ReinforceCamp"] execVM "helicopterSearch.sqf";
//	Now there's no need to use in a trigger, just paste the above in the helicopters init field.

COMMENT
"
	this			References the helicopter from its init field.
	[1234,5678,0]	Position to search.
	350				Radius from position to create waypoints.
	ReinforceCamp	Wait until condition is true.
					Set up your trigger condition and on that triggers On Activation field, use; ReinforceCamp = true;
";

params ["_grp", "_pos", "_rad", "_con"];

_posArr = [];


COMMENT " Plot waypoint every 45 degrees in a circle. 8 waypoints in total. ";

_stp = 360/8;

for "_dir" from 0 to (360 - _stp) step _stp do 
{
	_posArr pushBack (_pos getPos [_rad, _dir]);
};
	
systemChat "Positions ready. Waiting on condition.";
	
waitUntil { sleep 1; !isNil _con; };

{
	_wp = (group _grp) addWaypoint [_x, 0];
	_wp setWaypointType "MOVE";	//	I know you have your heart set on "SAD", but "MOVE" works best for orbiting helicopters. 
	_wp setWaypointBehaviour "CARELESS";	//	<- Not a typo.
	_wp setWaypointCombatMode "YELLOW";
	_wp setWaypointSpeed "LIMITED";
	
	COMMENT
	"
		Reveals nearEntities to helicopter group at each waypoint.
		Helicopter guns will engage enemies it can see.
	";
	_wp setWaypointStatements
	[
		"true",
		"
			{
				(group this) reveal [_x, 4];
			} count (this nearEntities 1500);
		"
	];	
} count _posArr;

	COMMENT " Add a CYCLE waypoint on the first waypoint. ";
	_wp = (group _grp) addWaypoint [_posArr #0, 0];
	_wp setWaypointType "CYCLE";
	
	systemChat "Reinforcing... Prepare to DIE!";

	
