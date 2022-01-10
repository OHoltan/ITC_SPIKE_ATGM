/*
 * itc_land_spike_fnc_fired
 */

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner", "_shooter"];
//player addmagazine _magazine;
private _unit = player;
private _uid = getPlayerUID player;
private _myNetworkId = clientOwner;
//private _uid + bob;
_projectile = _this select 6;

//if (!hasInterface) exitWith{};
If (_shooter != ACE_Player) exitWith{};
if (!isPlayer _shooter) exitWith {};
If (_unit != ACE_Player) exitWith{};
if (_uid != getPlayerUID player) exitWith {};
If (_myNetworkId != clientOwner) exitWith{};
//If (!isPlayer Spike1) exitWith{};
if !(local (_this select 7)) exitWith {};
if (player!=(_this select 7)) exitWith {};

itc_land_spike_currentMissile = _projectile;
itc_land_spike_launchTime = cba_missionTime;
itc_land_spike_activationTime = cba_missionTime;
itc_land_spike_wobble = [if (random 1 > 0.5) then [{-1},{1}], 5 + (random 10), (round (random 3)) * 0.25];
private _viewASL = AGLtoASL positionCameraToWorld [0,0,0];
private _intersect = [AGLtoASL positionCameraToWorld [0,0,0], _viewASL vectorFromTo (AGLtoASL positionCameraToWorld [0,0,1])] call itc_land_spike_fnc_intersectScreenToWorld;
if (!isNil "_intersect" && {(_intersect distance _unit) > 500}) then {
	itc_land_spike_targetPos = _intersect;
	itc_land_spike_targetPosCamera = _intersect;
} else {
	private _forward = AGLtoASL (_unit modelToWorld [0,3000,0]);
	itc_land_spike_targetPos = _forward;
	itc_land_spike_targetPosCamera = _forward;
};

//
//call itc_land_spike_fnc_startCamera;
//[] Call [itc_land_spike_fnc_missile];

itc_land_spike_camera = "camera" camCreate (getPos _projectile);
itc_land_spike_camera camSetFov 0.08333;

//_camera camSetTarget (ASLtoAGL itc_exp_spike_targetPosCamera);
private _polarToTarget = ((getPosASL _projectile) vectorFromTo itc_land_spike_targetPosCamera) call cba_fnc_vect2polar;
//systemChat str ["polar", _polarToTarget];
itc_land_spike_camera setDir (_polarToTarget # 1);
[itc_land_spike_camera, (_polarToTarget # 2), 0] call bis_fnc_setpitchbank;
itc_land_spike_camera setVectorUP [0,0.5,0];
//itc_land_spike_camera attachTo [itc_land_spike_currentMissile, [0,1,0]];
itc_land_spike_camera cameraEffect ["internal", "BACK"];
disableserialization;
findDisplay 46 createDisplay  "ITC_Land_SpikeSeeker";
showCinemaBorder false;
