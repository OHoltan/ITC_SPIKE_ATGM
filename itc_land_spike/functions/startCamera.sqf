private _unit = player;
private _uid = getPlayerUID player;
private _myNetworkId = clientOwner;

//if (!hasInterface) exitWith{};
If (_shooter != ACE_Player) exitWith{};
if (!isPlayer _shooter) exitWith {};
If (_unit != ACE_Player) exitWith{};
if (_uid != getPlayerUID player) exitWith {};
//If (!isPlayer Spike1) exitWith{};
if !(local (_this select 7)) exitWith {};
if (player!=(_this select 7)) exitWith {};


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
