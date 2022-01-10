/*
 * itc_land_spike_fnc_selectSpike
 */

params ["_display","_unit"];
private _unit = player;
private _uid = getPlayerUID player;
private _myNetworkId = clientOwner;

//if (!hasInterface) exitWith{};
If (_shooter != ACE_Player) exitWith{};
if (!isPlayer _shooter) exitWith {};
If (_unit != ACE_Player) exitWith{};
if (_uid != getPlayerUID player) exitWith {};

[{
  (_this select 0) params ["_display"];
  if (!alive player || isNull _display || currentWeapon player != "itc_land_spikeLR") exitWith {
    [_this select 1] call CBA_fnc_removePerFrameHandler;
  };

  if (itc_land_spike_cameraMode != cameraView) then {
    [] call itc_land_spike_fnc_sightViewChanged;
    itc_land_spike_cameraMode = cameraView;
  };

  call itc_land_spike_fnc_handleLock;

  if (!isNil "itc_land_spike_currentMissile" && {isNull itc_land_spike_currentMissile}) exitWith {
    (uiNamespace getVariable "itc_land_spike_ui") closeDisplay 2;
    itc_land_spike_camera cameraEffect ["terminate", "back"];
    camDestroy itc_land_spike_camera;
    itc_land_spike_camera = nil;
    itc_land_spike_currentMissile = nil;
    itc_land_spike_lockInformation = [nil, [0,0,0], nil, [0,0,0]];
  };

  if (isNil "itc_land_spike_camera" && cameraView == "GUNNER") then {
    [_display] call itc_land_spike_fnc_updateSightOverlay;
  } else {
    if (!isNil "itc_land_spike_camera") then {
      [] call itc_land_spike_fnc_handleCameraAiming;
      [_display] call itc_land_spike_fnc_cameraUpdate;
    };
  };

  //systemChat str [time, _display, isNull _display, isNil "_display"];
}, 0, [_display]] call CBA_fnc_addPerFrameHandler;
