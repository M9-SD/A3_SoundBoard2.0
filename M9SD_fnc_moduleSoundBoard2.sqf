M9SD_fnc_zeusCompHelipadCleanup = {
	comment "Determine if execution context is composition and delete the helipad.";
	if ((!isNull (findDisplay 312)) && (!isNil 'this')) then {
		if (!isNull this) then {
			if (typeOf this == 'Land_HelipadEmpty_F') then {
				deleteVehicle this;
			};
		};
	};
};
call M9SD_fnc_zeusCompHelipadCleanup;
M9sd_fnc_moduleSoundBoard2 = {
	startLoadingScreen ["Loading Sound Board..."];
	comment "Determine if execution context is composition and delete the helipad.";

	playSound 'click';
	playSound ['border_In', true];
	missionNamespace setVariable ['m9_sndbrdprog', 0];
	progressLoadingScreen 0.1;
	m9sd_fnc_populateSoundboardWithSearch = {
		params ['_treeCtrl', ['_searchStr', ''], ['_onLoad', false]];
		tvClear _treeCtrl;
		private _addEverything = (_searchStr == '');
		private _favorites = profilenamespace getvariable ['JAM_zeus_favoriteSounds', []];
		private _color_favorite = [1,1,1,1];
		private _color_searched = [0.66,1,0.66,1];
		private _color_sound = JAM_zeus_uiColor2;
		private _color_category = JAM_zeus_uiColor3;
		private _icon_config = "a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa";
		private _icon_addon = "a3\3den\data\displays\display3den\toolbar\open_ca.paa";
		'private _progInc = (50/204297) * 0.7777;';
		'0.000190336';'0.0002';
		private _progInc = 0.000440535;
		private _lastSelectedPath = [];
		private _lastSelectedName = profileNamespace getVariable ['JAM_zeus_selectedSoundDisplayName', ''];
		{
			private _categoryName = _x # 0;
			private _categoryName2 = _categoryName trim ['\', 2];
			private _categoryNameLength = count (_categoryName splitString '');
			private _snds = _x # 1;
			private _addCategory = false;
			private _addWholeCategory = false;
			if (_searchStr in [ _categoryName, '']) then {_addCategory = true;_addWholeCategory = true};
			private _matchedSndIdxs = [];
			{
				if (_addEverything) then {
					_matchedSndIdxs pushBack _forEachIndex;
					continue
				};
				private _snd = _x;
				if (_snd isEqualType []) then {_snd = tolower (_snd # 0)};
				if !(_searchStr in _snd) then {continue};
				_matchedSndIdxs pushBack _forEachIndex;
			} forEach _snds;
			if (count _matchedSndIdxs > 0) then {_addCategory = true};
			if !(_addCategory) then {continue};
			private _indexA = _treeCtrl tvAdd [[], _categoryName2];
			private _pathA = [_indexA];
			_treeCtrl tvSetTooltip [_pathA, _categoryName];
			_treeCtrl tvSetColor [_pathA, _color_category];
			if (_categoryName == 'CfgSounds') then {
				_treeCtrl tvSetPicture [_pathA, _icon_config];
			} else {
				_treeCtrl tvSetPicture [_pathA, _icon_addon];
			};
			if (_addWholeCategory) then {
				_treeCtrl tvSetColor [[_indexA], if (_addEverything) then {_color_category} else {_color_searched}];
			};
			{
				if (!(_forEachIndex in _matchedSndIdxs) && !_addWholeCategory) then {continue}; 
				private _snd = _x;
				if (_snd isEqualType []) then {
					private _class = _snd # 0;
					private _name = _snd # 1;
					private _duration = _snd # 2;
					private _sound = _snd # 3;
					private _titles = _snd # 4;
					private _indexC = _treeCtrl tvAdd [[_indexA], _class];
					private _pathC = [_indexA, _indexC];
					if (_class == _lastSelectedName) then {
						_lastSelectedPath = _pathC;
					};
					'_treeCtrl tvSetCurSel _pathC;';
					_treeCtrl tvSetTooltip [_pathC, _class];
					_treeCtrl tvSetData [_pathC, str _snd];
					_treeCtrl tvSetPicture [_pathC, "a3\modules_f_curator\data\portraitSound_ca.paa"];
					if (_class in _favorites) then 
					{
						_treeCtrl tvSetColor [_pathC, _color_favorite];
						_treeCtrl tvSetPictureColor [_pathC, _color_favorite];
						_treeCtrl tvSetPictureRight [_pathC, 'a3\ui_f_curator\data\displays\rscDisplayCurator\modeRecent_ca.paa'];
						_treeCtrl tvSetPictureRightColor [_pathC, _color_favorite];
					} else 
					{
						_treeCtrl tvSetColor [_pathC, if (_addEverything) then {_color_sound} else {_color_searched} ];
						_treeCtrl tvSetPictureColor [_pathC, _color_sound];
						_treeCtrl tvSetPictureRight [_pathC, ''];
					};
				} else {
					private _sndName = _snd select [_categoryNameLength-1, count (_snd splitString '')];
					private _indexC = _treeCtrl tvAdd [[_indexA], _sndName];
					private _pathC = [_indexA, _indexC];
					if (_sndName == _lastSelectedName) then {
						_lastSelectedPath = _pathC;
					};
					'_treeCtrl tvSetCurSel _pathC;';
					_treeCtrl tvSetTooltip [_pathC, _snd];
					_treeCtrl tvSetData [_pathC, str _snd];
					_treeCtrl tvSetPicture [_pathC, "a3\modules_f_curator\data\portraitSound_ca.paa"];
					if (_sndName in _favorites) then 
					{
						_treeCtrl tvSetColor [_pathC, _color_favorite];
						_treeCtrl tvSetPictureColor [_pathC, _color_favorite];
						_treeCtrl tvSetPictureRight [_pathC, 'a3\ui_f_curator\data\displays\rscDisplayCurator\modeRecent_ca.paa'];
						_treeCtrl tvSetPictureRightColor [_pathC, _color_favorite];
					} else 
					{
						_treeCtrl tvSetColor [_pathC, if (_addEverything) then {_color_sound} else {_color_searched}];
						_treeCtrl tvSetPictureColor [_pathC, _color_sound];
						_treeCtrl tvSetPictureRight [_pathC, ''];
					};
				};
				missionNamespace setVariable ['m9_sndbrdprog', (missionNamespace getvariable ['m9_sndbrdprog', 0]) + _progInc];
			} forEach _snds;
		} forEach (missionNamespace getVariable ['M9_soundboard_tree', []]);
		if !(_lastSelectedPath isEqualTo []) then {
			_treeCtrl tvSetCurSel _lastSelectedPath;
		};
		if !(_addEverything) then {
			'tvExpandAll _treeCtrl;'
		} else {
			'tvCollapseall _treectrl;'
		};
	};
	uiNamespace setVariable ['m9sd_fnc_populateSoundboardWithSearch', m9sd_fnc_populateSoundboardWithSearch];
	if (isNil 'JAM_zeus_uiColor') then 
	{
		uiNamespace setVariable ['JAM_zeus_uiColor', [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])]];
		missionNameSpace setVariable ['JAM_zeus_uiColor', [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])]];
	};
	_newcoloa=  (uiNamespace getVariable 'JAM_zeus_uiColor') vectorMultiply 1.5;
	{
		_x setVariable ['JAM_zeus_uiColor2', _newcoloa];
	} forEach [missionNamespace, uiNamespace];
	_olcola=  (uiNamespace getVariable 'JAM_zeus_uiColor');
	_newcola2 = [(_olcola # 0) * 2,(_olcola # 1),(_olcola # 2) * 0.5,(_olcola # 3) * 1.33];
	{
		_x setVariable ['JAM_zeus_uiColor3', _newcola2];
	} forEach [missionNamespace, uiNamespace];
	uiNamespace setVariable ['m9_soundboardSearching', false];
	if (isNil 'M9_soundboard_tree') then {
		missionNamespace setVariable ['M9_soundboard_tree', call {
			'Get first category of sounds from CfgSounds config classes';
			missionNamespace setVariable ['bigboitotal',0];
			private _soundBoardTree = [["CfgSounds", call {
				private _allCfgSounds = [];
				private _subClasses = [configFile >> "CfgSounds"] call BIS_fnc_returnChildren;
				{
					private _class = configName _x;
					private _name = getText (configFile >> "CfgSounds" >> _class >> 'name');
					private _duration = getText (configFile >> "CfgSounds" >> _class >> 'duration');
					private _sound = getArray (configFile >> "CfgSounds" >> _class >> 'sound');
					private _titles = getArray (configFile >> "CfgSounds" >> _class >> 'titles');
					_allCfgSounds pushBack [_class, _name, _duration, _sound, _titles];
					missionNamespace setVariable ['bigboitotal',(missionNamespace getVariable ['bigboitotal',0])+ 1];
				} forEach _subClasses;
				_allCfgSounds;
			}]];
			private _exts = [".wav", ".wss", ".ogg"];
			private _extractRadioDubbing = true;
			private _addonPaths = allAddonsInfo apply { _x select 0 };
			if (!_extractRadioDubbing) then
			{
				_addonPaths = _addonPaths select { !("dubbing_radio" in _x) };
			};
			_addonPaths sort true;
			{
				private _addonPath = _x;
				private _files = [];
				{
					_files append addonFiles [_addonPath, _x];
				} forEach _exts;
				if (_files isEqualTo []) then { continue };
				_files sort true;
				_soundBoardTree append [[_addonPath, _files]];
				missionNamespace setVariable ['bigboitotal',(missionNamespace getVariable ['bigboitotal',0])+ (count _files)];
			} forEach _addonPaths;
			showchat true;
			"systemChat str (missionNamespace getVariable ['bigboitotal',0]);"; "204297";
			_soundBoardTree
		}];
	};
	progressLoadingScreen 0.2;
	findDisplay 49 closeDisplay 0;
	with uiNamespace do 
	{
		disableSerialization;
		createDialog 'RscDisplayEmpty';
		private _display = findDisplay -1;
		_display spawn {
			private _display = _this;
			private _prog = _display ctrlCreate ['RscStructuredText', -1];
			_display setVariable ['prog', _prog];
			_prog ctrlSetBackgroundColor [0,0,0,0];
			_prog ctrlSetPosition [0.484531*0.995 * safezoneW + safezoneX,0.442 * safezoneH + safezoneY,0.0309375*1.25 * safezoneW,0.055 * safezoneH];
			_prog ctrlCommit 0;
			private _prog2 = _display ctrlCreate ['RscPictureKeepAspect', -1];
			_display setVariable ['prog2', _prog2];
			_prog2 ctrlSetBackgroundColor [0,0,0,0];
			_prog2 ctrlSetText "a3\3den\data\cfgwaypoints\cycle_ca.paa";
			_prog2 ctrlSetShadow 2;
			_prog2 ctrlSetPosition [0.484531 * safezoneW + safezoneX,0.388 * safezoneH + safezoneY,0.0309375 * safezoneW,0.055 * safezoneH];
			_prog2 ctrlCommit 0;
			private _rot = 0;
			while {!isNull _prog} do {
				_prog ctrlSetStructuredText parseText format ["<t valign='middle' shadow='2' size='%1' align='center' font='puristaSemiBold'>%2%3</t>", str (1.5 * (safezoneh * 0.5)), round (missionNamespace getVariable ['m9_sndbrdprog', 0]), '%', str (0.8 * (safezoneh * 0.5))];
				_rot = _rot + 32;
				_prog2 ctrlSetAngle [_rot, 0.5, 0.5, false];
				_prog2 ctrlCommit 0.2;
				_prog ctrlCommit 0;
				uiSleep 0.2;
			};
			ctrlDelete _prog;
			ctrlDelete _prog2;
		};
		private _d = _display;
		_d displayAddEventHandler ['unload',{
			params ["_display", "_exitCode"];
			uiNamespace setVariable ['m9_soundboardSearching', false];
			if (false) then {'m9soundboardloadingscreen' cutText ["", "BLACK IN"];};
			saveProfileNamespace;
		}];
		showChat true;
		private _initialFade = 0;
		progressLoadingScreen 0.3;
		_background = _display ctrlCreate ['RscText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0.7];
		_background ctrlSetPosition [0.381406 * safezoneW + safezoneX,0.247 * safezoneH + safezoneY,0.237187 * safezoneW,0.55 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_tightal = _display ctrlCreate ['RscStructuredText', -1];
		_tightal ctrlSetBackgroundColor JAM_zeus_uiColor;
		_tightal ctrlSetPosition [0.381406 * safezoneW + safezoneX,0.203 * safezoneH + safezoneY,0.237187 * safezoneW,0.022 * safezoneH];
		_tightal ctrlSetStructuredText parseText format ["<t size='%1' align='center' font='puristaMedium' shadow='0'>Sound Board 2.0<t/>", str (1.0 * (safezoneh * 0.5))];
		_tightal ctrlSetTooltip format ["Description:\n\nThis utility allows you to view & playback all the sounds in the game.\nIt allows Zeuses to leverage their creativity & enables more immersive experiences.\nThis menu has controls & features to set favorites, preview sounds, broadcast sounds, \ncopy sound info, offset playback, adjust pitch, & more.\n\nDevs can also use this tool for easy testing & debugging of sound scripts."];
		_tightal ctrlSetTooltipColorText [1,1,1,1];
		_tightal ctrlSetTooltipColorShade JAM_zeus_uiColor;
		_tightal ctrlSetTooltipColorBox [1,1,1,1];
		_tightal ctrlSetFade _initialFade;
		_tightal ctrlCommit 0;
		_tightal ctrlEnable false;
		_treeSearchCtrl = _d ctrlCreate ['RscEdit', -1];
		_treeSearchCtrl ctrlSetFade _initialFade;
		_treeSearchCtrl ctrlSetPosition [0.396875 * safezoneW + safezoneX,0.2254 * safezoneH + safezoneY,0.20625 * safezoneW,0.022 * safezoneH];
		_treeSearchCtrl ctrlSetBackgroundColor [0,0,0,0.88];
		_treeSearchCtrl ctrlSetTextColor [1,1,1,0.5];
		_treeSearchCtrl ctrlSetText 'Search...';
		_treeSearchCtrl ctrlSetFont 'RobotoCondensed';
		_treeSearchCtrl ctrlSetTooltip 'Input any query & click the search button.\nThe search will take a minute to scan files.\nResults will appear in realtime.\n';
		_treeSearchCtrl ctrlSetTooltipColorText [1,0.7,1,1];
		_treeSearchCtrl ctrlSetTooltipColorShade [0.1,0.11,0.1,0.88];
		_treeSearchCtrl ctrlSetTooltipColorBox [1,0.7,1,1];
		_treeSearchCtrl ctrlSetFontHeight ((0.77 * (safeZoneH * 0.5)) / 10 / 2);
		_treeSearchCtrl ctrlAddEventHandler ['SetFocus',{
			params ["_control"];
			if (ctrlText _control == 'Search...') then {
				_control ctrlSetText '';
				_control ctrlSetTextColor [0.22*4,0.11*5,0.22*6,1];
				_control ctrlCommit 0;
			};
		}];
		_treeSearchCtrl ctrlCommit 0;
		'use search button instead '; 
		' doesnt run fast enough for searching on each key press (editChanged/keydown)';
		_treeSearchButtonCtrl_b  = _d ctrlCreate ['RscFrame', -1];
		_treeSearchButtonCtrl_b ctrlSetPosition [0.603124 * safezoneW + safezoneX,0.225 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_treeSearchButtonCtrl_b ctrlSetFade _initialFade;
		_treeSearchButtonCtrl_b ctrlCommit 0;
		_treeSearchButtonCtrl = _d ctrlCreate ['RscButtonMenu', -1];
		_treeSearchButtonCtrl ctrlEnable false;
		_treeSearchButtonCtrl ctrlSetPosition [0.603124 * safezoneW + safezoneX,0.2255 * safezoneH + safezoneY,0.0154 * safezoneW,0.021 * safezoneH];
		_treeSearchButtonCtrl setVariable ['ctrlSearch', _treeSearchCtrl];
		_treeSearchButtonCtrl ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\3den\data\displays\display3den\search_start_ca.paa'></img>"];
		_treeSearchButtonCtrl ctrlSetTooltip 'Search';
		_treeSearchButtonCtrl ctrlSetTooltipColorText [1,1,1,1];
		_treeSearchButtonCtrl ctrlSetTooltipColorShade [0.22,0.11,0.22,0.88];
		_treeSearchButtonCtrl ctrlSetTooltipColorBox [1,1,1,1];
		_treeSearchButtonCtrl ctrlSetFade _initialFade;
		_treeSearchButtonCtrl ctrlAddEventHandler ['buttonclick', {_this spawn {with uiNamespace do {
			params ["_control"];
			private _Favbtn = (_control getVariable 'btnFav');
			_control ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\ui_f\data\igui\cfg\simpletasks\types\wait_ca.paa'></img>"];
			_Favbtn ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\ui_f\data\igui\cfg\simpletasks\types\wait_ca.paa'></img>"];
			_Favbtn ctrlEnable false;
			_Favbtn ctrlSetFade 0.66;
			_control ctrlEnable false;
			_control ctrlSetFade 0.66;
			if (uiNamespace getVariable ['m9_soundboardSearching', false]) exitWith {};
			uiNamespace setVariable ['m9_soundboardSearching', true];
			private _ctrlTree = _control getVariable 'ctrlTree';
			private _treeCtrl = _ctrlTree;
			private _ctrlSearch = _control getVariable 'ctrlSearch';
			private _newText = ctrlText _ctrlSearch;
			if ((false) or (_newText == 'Search...')) exitWith {};
			with uiNamespace do {
				[_treeCtrl, _newText] call m9sd_fnc_populateSoundboardWithSearch;
			};
			"systemChat 'done';";
			uiNamespace setVariable ['m9_soundboardSearching', false];
			_control ctrlEnable true;
			_control ctrlSetFade 0;
			_control ctrlCommit 0;
			_Favbtn ctrlEnable true;
			_Favbtn ctrlSetFade 0;
			_Favbtn ctrlCommit 0;
			_Favbtn ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\ui_f_curator\data\displays\rscDisplayCurator\modeRecent_ca.paa'></img>"];
			_control ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\3den\data\displays\display3den\search_start_ca.paa'></img>"];
		}}}];
		_treeSearchButtonCtrl ctrlSetBackgroundColor [0.22,0.11,0.22,0.88];
		_treeSearchButtonCtrl ctrlCommit 0;
		progressLoadingScreen 0.4;
		_treeFavoritesFilterButtonCtrl_b  = _d ctrlCreate ['RscFrame', -1];
		_treeFavoritesFilterButtonCtrl_b ctrlSetPosition [0.381406 * safezoneW + safezoneX,0.225 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_treeFavoritesFilterButtonCtrl_b ctrlSetFade _initialFade;
		_treeFavoritesFilterButtonCtrl_b ctrlCommit 0;
		_treeFavoritesFilterButtonCtrl = _d ctrlCreate ['RscButtonMenu', -1];
		_treeFavoritesFilterButtonCtrl ctrlEnable false;
		_treeFavoritesFilterButtonCtrl ctrlSetPosition [0.38135 * safezoneW + safezoneX,0.225 * safezoneH + safezoneY,0.01542 * safezoneW,0.0215 * safezoneH];
		_treeFavoritesFilterButtonCtrl ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\ui_f_curator\data\displays\rscDisplayCurator\modeRecent_ca.paa'></img>"];
		_treeFavoritesFilterButtonCtrl ctrlSetTooltip 'Filter the list to only show favorites.';
		_treeFavoritesFilterButtonCtrl ctrlSetTooltipColorText [1,1,1,1];
		_treeFavoritesFilterButtonCtrl ctrlSetTooltipColorShade [0.22,0.11,0.22,0.88];
		_treeFavoritesFilterButtonCtrl ctrlSetTooltipColorBox [1,1,1,1];
		_treeFavoritesFilterButtonCtrl ctrlSetFade _initialFade;
		_treeFavoritesFilterButtonCtrl setVariable ['btnSrch', _treeSearchButtonCtrl];
		_treeSearchButtonCtrl setVariable ['btnFav', _treeFavoritesFilterButtonCtrl];
		_treeFavoritesFilterButtonCtrl ctrlAddEventHandler ['buttonclick', {_this spawn {with uiNamespace do {
			params ["_control"];
			private _Searchbtn = (_control getVariable 'btnSrch');
			_control ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\ui_f\data\igui\cfg\simpletasks\types\wait_ca.paa'></img>"];
			_Searchbtn ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\ui_f\data\igui\cfg\simpletasks\types\wait_ca.paa'></img>"];
			_Searchbtn ctrlEnable false;
			_Searchbtn ctrlSetFade 0.66;
			_control ctrlEnable false;
			_control ctrlSetFade 0.66;
			private _ctrlTree = _control getVariable 'ctrlTree';
			tvExpandall _ctrlTree;
			private _favorites = profileNameSpace getVariable ['JAM_zeus_favoriteSounds', []];
			private _nonFavoritesFountInIteration = -1;
			while {_nonFavoritesFountInIteration != 0} do {
				_nonFavoritesFountInIteration = 0;
				private _categoryCount = _ctrlTree tvCount [];
				private _categoryLastIdx = _categoryCount - 1;
				for '_catIdx' from 0 to _categoryLastIdx do {
					private _sndCount = _ctrlTree tvCount [_catIdx];
					private _sndLastIdx2 = _sndCount - 1;
					for '_sndIdx' from 0 to _sndLastIdx2 do {
						private _ppath = [_catIdx, _sndIdx];
						if !((_ctrlTree tvText _ppath) in _favorites) then {
							_nonFavoritesFountInIteration = _nonFavoritesFountInIteration + 1;
							_ctrlTree tvDelete _ppath;
						} else {
						};
					};
				};
			};
			'remove empty categories now';
			private _emptyCatCount = -1;
			while {_emptyCatCount != 0} do {
				_emptyCatCount = 0;
				private _categoryCount = _ctrlTree tvCount [];
				private _categoryLastIdx = _categoryCount - 1;
				for '_catIdx' from 0 to _categoryLastIdx do {
					private _cPath = [_catIdx];
					private _sndCount = _ctrlTree tvCount _cPath;
					if (_sndCount == 0) then {
						_emptyCatCount = _emptyCatCount + 1;
						_ctrlTree tvDelete _cPath;
					};
				};
			};
			_Searchbtn ctrlEnable true;
			_Searchbtn ctrlSetFade 0;
			_control ctrlEnable true;
			_control ctrlSetFade 0;
			_control ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\ui_f_curator\data\displays\rscDisplayCurator\modeRecent_ca.paa'></img>"];
			_Searchbtn ctrlSetStructuredText parseText format ["<t align='left' shadow='1' size='%1'>%2</t>", 0.83 * (safeZoneH * 0.5), "<img image='a3\3den\data\displays\display3den\search_start_ca.paa'></img>"];
		}}}];
		progressLoadingScreen 0.5;
		_treeFavoritesFilterButtonCtrl ctrlSetBackgroundColor [0.22,0.11,0.22,0.88];
		_treeFavoritesFilterButtonCtrl ctrlCommit 0;
		_cancelCtrl = _display ctrlCreate ['RscButtonMenu',-1];
		_cancelCtrl ctrlSetPosition [0.603125 * safezoneW + safezoneX,0.203 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_cancelCtrl ctrlSetTooltip 'EXIT';
		_cancelCtrl ctrlSetTooltipColorText [1,0.1,0.1,1];
		_cancelCtrl ctrlSetTooltipColorShade [1,1,1,1];
		_cancelCtrl ctrlSetTooltipColorBox [0,0,0,1];
		_cancelCtrl ctrlSetBackgroundColor [0,0,0,0];
		_cancelCtrl ctrlSetStructuredText parseText ("<t valign='middle' align='center' font='PuristaSemiBold' shadow='0' size='" + (str ((safeZoneH * 0.5) * 1)) + "'>X</t>");
		_cancelCtrl ctrladdEventHandler ["ButtonClick", 
		{
			params ["_control"];
			[_control] spawn 
			{
				params ["_control"];
				disableSerialization;
				with uiNamespace do 
				{
					_parentDisplay = ctrlParent _control;
					_parentDisplay closeDisplay 0;
					"playSound 'click';";
					playSound ['border_Out', true];
				};
			};
		}];
		_cancelCtrl ctrlSetFade _initialFade;
		_cancelCtrl ctrlCommit 0;
		_cancelCtrl = _display ctrlCreate ['RscButtonMenu',-1];
		_cancelCtrl ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.764 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_cancelCtrl ctrlSetTooltip 'Stop all sounds started from this menu.\n\n*Warning: Will NOT stop 3D sounds!';
		_cancelCtrl ctrlSetBackgroundColor [0.6,0,0,0.8];
		_cancelCtrl ctrlSetStructuredText parseText ("<t valign='middle' align='center' font='PuristaSemiBold' shadow='2' size='" + (str ((safeZoneH * 0.5) * 1)) + "'>STOP SOUNDS</t>");
		_cancelCtrl ctrladdEventHandler ["ButtonClick", 
		{
			params ["_control"];
			[[],
			{
				{
					deleteVehicle _x;
				} forEach (missionNameSpace getVariable ['JAM_zeus_playedSounds', []]);
				private _playedSounds = [];
				{
					if !(isNull _x) then 
					{
						_playedSounds pushBack _x;
					};
				} forEach (missionNameSpace getVariable ['JAM_zeus_playedSounds', []]);
				missionNameSpace setVariable ['JAM_zeus_playedSounds', _playedSounds];
			}] remoteExec ['spawn'];
		}];
		_cancelCtrl ctrlSetFade _initialFade;
		_cancelCtrl ctrlCommit 0;
		_background = _display ctrlCreate ['RscText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0.7];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.665 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.665 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.665 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='right'>isSpeech<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_backgroundeditframe = _display ctrlCreate ['RscEdit', -1];
		_backgroundeditframe ctrlSetBackgroundColor [0,0,0,0];
		_backgroundeditframe ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.665 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_backgroundeditframe ctrlSetFade _initialFade;
		_backgroundeditframe ctrlCommit 0;
		_backgroundeditframe ctrlEnable false;
		_checkbox = _display ctrlCreate ["RscCheckbox", -1];
		_checkbox ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.665 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_checkbox ctrladdEventHandler ["ButtonClick", 
		{
			params ["_control"];
			with uiNamespace do 
			{
				if (cbChecked _control) then 
				{
					profileNamespace setVariable ['JAM_zeus_sB_isSpeech', true];
				} else 
				{
					profileNamespace setVariable ['JAM_zeus_sB_isSpeech', false];
				};
			};
		}];
		progressLoadingScreen 0.6;
		_checkbox ctrlSetTooltip 'Boolean - \ntrue to play it as speech, fadeSpeech applies.\nFalse to play it as sound, fadeSound applies';
		_checkbox ctrlSetFade _initialFade;
		_checkbox ctrlCommit 0;
		_display setVariable ['cbSpeech', _checkbox];
		if (profileNamespace getVariable ['JAM_zeus_sB_isSpeech', false]) then 
		{
			_checkbox cbSetChecked true;
		} else 
		{
			_checkbox cbSetChecked false;
		};
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0.7];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.687 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='right'>Offset<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.687 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_offset = _display ctrlCreate ['RscEdit', -1];
		_offset ctrlSetFont 'RobotoCondensed';
		_offset ctrlSetFontHeight ((0.64 * (safeZoneH * 0.5)) / 10 / 2);
		_offset ctrlSetBackgroundColor [0,0,0,0];
		_offset ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.687 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_offset ctrlSetTooltip "Number - \nstart, in seconds.\nCan be negative.";
		_offset ctrlSetText '0';
		_offset ctrlSetFade _initialFade;
		_offset ctrlCommit 0;
		_display setVariable ['offset', _offset];
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0.7];
		_background ctrlSetPosition[0.546406 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='right'>3D Sound<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_checkbox = _display ctrlCreate ["RscCheckbox", -1];
		_checkbox ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.709 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_checkbox ctrladdEventHandler ["ButtonClick", 
		{
			params ["_control"];
			with uiNamespace do 
			{
				if (cbChecked _control) then 
				{
					profileNamespace setVariable ['JAM_zeus_sB_playSound3D', true];
				} else 
				{
					profileNamespace setVariable ['JAM_zeus_sB_playSound3D', false];
				};
			};
			saveprofilenamespace;
		}];
		_checkbox ctrlSetTooltip 'Use playSound3D to hear it in the 3D environment.\n\n*Warning:\n It is not possible to stop 3D sounds.';
		_checkbox ctrlSetFade _initialFade;
		_checkbox ctrlCommit 0;
		_display setVariable ['cb3D', _checkbox];
		if (profileNamespace getVariable ['JAM_zeus_sB_playSound3D', false]) then 
		{
			_checkbox cbSetChecked true;
		} else 
		{
			_checkbox cbSetChecked false;
		};
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0.7];
		_background ctrlSetPosition[0.546406 * safezoneW + safezoneX,0.731 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='right'>Pitch<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.731 * safezoneH + safezoneY,0.0670312 * safezoneW,0.022 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background ctrlEnable false;
		_pitch = _display ctrlCreate ['RscEdit', -1];
		_pitch ctrlSetFont 'RobotoCondensed';
		_pitch ctrlSetFontHeight ((0.64 * (safeZoneH * 0.5)) / 10 / 2);
		_pitch ctrlSetBackgroundColor [0,0,0,0];
		_pitch ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.731 * safezoneH + safezoneY,0.0154688 * safezoneW,0.022 * safezoneH];
		_pitch ctrlSetTooltip (
			"soundPitch: Number - (Optional, default 1)\n" + 
			"• 1.0 → normal\n" + 
			"• 0.5 → Darth Vader\n" + 
			"• 2.0 → Chipmunks\n\n*Warning:\n Only works with 3D sound (playSound3D)."
		);
		_pitch ctrlSetText '1';
		_pitch ctrlSetFade _initialFade;
		_pitch ctrlCommit 0;
		_display setVariable ['pitch', _pitch];
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.0309375 * safezoneW,0.044 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_preview = _display ctrlCreate ['RscButtonMenu',-1];
		_preview ctrlSetPosition [0.546406 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.0309375 * safezoneW,0.044 * safezoneH];
		_preview ctrlSetTooltip 'Preview the selected sound.\nThe audio will only play on your computer.';
		_preview ctrlSetBackgroundColor [0,0,0.6,0.2];
		_preview ctrlSetStructuredText parseText ("<t valign='middle' align='center' color='#ffffff' font='PuristaLight' shadow='2' size='" + (str ((safeZoneH * 0.5) * 2)) + "'><img image='\a3\3den\data\displays\display3den\entitymenu\playFromHere_ca.paa'></img></t>");
		_preview ctrladdEventHandler ["ButtonClick", 
		{
			params ["_control"];
			private _display = ctrlParent _control;
			private _sounds = _display getVariable 'sounds';
    		private _tvSelectionPath = tvCurSel _sounds;
			private _sndpath = _sounds tvData _tvSelectionPath;	
			_sndpath = call compile _sndpath;
			if (_sndpath isEqualType []) then {
				_sndpath = (_sndpath # 3) # 0;
			} else {
				if ( ('.wav' in _sndpath) or ('.wss' in _sndpath) or ('.ogg' in _sndpath) ) then {
					(_display getVariable 'cb3D') cbSetChecked true;
				};
			};
			private _soundName = _sounds tvText _tvSelectionPath;
			private _isSpeech = cbChecked (_display getVariable 'cbSpeech');
			private _is3D = cbChecked (_display getVariable 'cb3D');
			private _offset = parseNumber (ctrlText (_display getVariable 'offset'));
			private _pitch = parseNumber (ctrlText (_display getVariable 'pitch'));
			if (_is3D) then {
				private _source = if (isnull findDisplay 312) then {vehicle player} else {vehicle curatorCamera};
				if ( ('.wav' in _sndpath) or ('.wss' in _sndpath) or ('.ogg' in _sndpath) ) then {
					'is good'
				} else {
					_sndpath = _sndpath + '.wss';
				};
				'systemChat str _sndpath;';
				playSound3D [_sndpath, _source, false, getposasl _source, 1, _pitch, 0, _offset, true];
			} else {
				private _sound = playSound [_soundName, _isSpeech, _offset];
				private _playedSounds = missionNameSpace getVariable ['JAM_zeus_playedSounds', []];
				_playedSounds pushBack _sound;
				missionNameSpace setVariable ['JAM_zeus_playedSounds', _playedSounds];
			};
		}];
		progressLoadingScreen 0.7;
		_preview ctrlSetFade _initialFade;
		_preview ctrlCommit 0;
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.5825 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.0309375 * safezoneW,0.044 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_play = _display ctrlCreate ['RscButtonMenu',-1];
		_play ctrlEnable false;
		_preview ctrlEnable false;
		_play ctrlSetPosition [0.5825 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.0309375 * safezoneW,0.044 * safezoneH];
		_play ctrlSetTooltip 'Play the selected sound.\nThe audio will play on everyone’s computer.';
		_play ctrlSetBackgroundColor [0,0.6,0,0.2];
		_play ctrlSetStructuredText parseText ("<t valign='middle' align='center' color='#FFFFFF' font='PuristaLight' shadow='2' size='" + (str ((safeZoneH * 0.5) * 2)) + "'><img image='\a3\3den\data\displays\display3den\entitymenu\playFromHere_ca.paa'></img></t>");
		_play ctrladdEventHandler ["ButtonClick", 
		{
			params ["_control"];
			private _display = ctrlParent _control;
			private _sounds = _display getVariable 'sounds';
    		private _tvSelectionPath = tvCurSel _sounds;
			private _sndpath = _sounds tvData _tvSelectionPath;	
			_sndpath = call compile _sndpath;
			if (_sndpath isEqualType []) then {
				_sndpath = (_sndpath # 3) # 0;
			};
			private _soundName = _sounds tvText _tvSelectionPath;
			private _isSpeech = cbChecked (_display getVariable 'cbSpeech');
			private _is3D = cbChecked (_display getVariable 'cb3D');
			private _offset = parseNumber (ctrlText (_display getVariable 'offset'));
			private _pitch = parseNumber (ctrlText (_display getVariable 'pitch'));
			if (_is3D) then {
				private _source = if (isnull findDisplay 312) then {vehicle player} else {vehicle curatorCamera};
				if ( ('.wav' in _sndpath) or ('.wss' in _sndpath) or ('.ogg' in _sndpath) ) then {
					'is good'
				} else {
					_sndpath = _sndpath + '.wss';
				};
				'systemChat str _sndpath;';
				playSound3D [_sndpath, _source, false, getposasl _source, 1, _pitch, 0, _offset, false];
			} else {
				[[_soundName, _isSpeech, _offset],
				{
					params ['_soundName', '_isSpeech', '_offset'];
					private _sound = playSound [_soundName, _isSpeech, _offset];
					private _playedSounds = missionNameSpace getVariable ['JAM_zeus_playedSounds', []];
					_playedSounds pushBack _sound;
					missionNameSpace setVariable ['JAM_zeus_playedSounds', _playedSounds];
				}] remoteExec ['spawn'];
			};
		}];
		_play ctrlSetFade _initialFade;
		_play ctrlCommit 0;
		_script = _display ctrlCreate ['RscEdit', -1];
		_script ctrlSetFont 'RobotoCondensed';
		_script ctrlSetFontHeight ((0.72 * (safeZoneH * 0.5)) / 10 / 2);
		_script ctrlSetBackgroundColor [0,0,0,0.9];
		_script ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.731 * safezoneH + safezoneY,0.154687 * safezoneW,0.022 * safezoneH];
		_script ctrlSetText "...";
		_script ctrlSetFade _initialFade;
		_script ctrlCommit 0;
		_display setVariable ['script', _script];
		_script2 = _display ctrlCreate ['RscEdit', -1];
		_script2 ctrlSetFont 'RobotoCondensed';
		_script2 ctrlSetFontHeight ((0.72 * (safeZoneH * 0.5)) / 10 / 2);
		_script2 ctrlSetBackgroundColor [0,0,0,0.9];
		_script2 ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.764 * safezoneH + safezoneY,0.154687 * safezoneW,0.022 * safezoneH];
		_script2 ctrlSetText "...";
		_script2 ctrlSetFade _initialFade;
		_script2 ctrlCommit 0;
		progressLoadingScreen 0.8;
		_display setVariable ['script2', _script2];
		_background = _display ctrlCreate ['RscText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0.7];
		_background ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.154687 * safezoneW,0.11 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background = _display ctrlCreate ['RscFrame', -1];
		_background ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.154687 * safezoneW,0.11 * safezoneH];
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0];
		_background ctrlSetPosition [0.386563 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.154687 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='left'>Class:<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetToolTip 'Classname of the sound if pulled from CfgSounds.';
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0];
		_background ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.632 * safezoneH + safezoneY,0.154687 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='left'>Name:<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetToolTip 'Name of sound, if defined in CfgSounds subclass,\nor file name, if pulled from addons.';
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0];
		_background ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.654 * safezoneH + safezoneY,0.154687 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='left'>Duration:<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetToolTip 'Length of sound, if defined in CfgSounds subclass.';
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0];
		_background ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.676 * safezoneH + safezoneY,0.154687 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='left'>Sound:<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetToolTip 'File path of sound, and other info if defined in CfgSounds subclass.';
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_background = _display ctrlCreate ['RscStructuredText', -1];
		_background ctrlSetBackgroundColor [0,0,0,0];
		_background ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.698 * safezoneH + safezoneY,0.154687 * safezoneW,0.022 * safezoneH];
		_background ctrlSetStructuredText parseText format ["<t size='%1' align='left'>Titles:<t/>", str (1 * (safezoneh * 0.5))];
		_background ctrlSetToolTip 'Attribute defined in config.';
		_background ctrlSetFade _initialFade;
		_background ctrlCommit 0;
		_class = _display ctrlCreate ['RscEdit', -1];
		_class ctrlSetFont 'RobotoCondensed';
		_class ctrlSetFontHeight ((0.72 * (safeZoneH * 0.5)) / 10 / 2);
		_class ctrlSetPosition [0.427812 * safezoneW + safezoneX,0.61 * safezoneH + safezoneY,0.113437 * safezoneW,0.022 * safezoneH];
		_class ctrlSetFade _initialFade;
		_class ctrlCommit 0;
		progressLoadingScreen 0.9;
		_display setVariable ['class', _class];
		_name = _display ctrlCreate ['RscEdit', -1];
		_name ctrlSetFont 'RobotoCondensed';
		_name ctrlSetFontHeight ((0.72 * (safeZoneH * 0.5)) / 10 / 2);
		_name ctrlSetPosition [0.427813 * safezoneW + safezoneX,0.632 * safezoneH + safezoneY,0.113437 * safezoneW,0.022 * safezoneH];
		_name ctrlSetFade _initialFade;
		_name ctrlCommit 0;
		_display setVariable ['name', _name];
		_duration = _display ctrlCreate ['RscEdit', -1];
		_duration ctrlSetFont 'RobotoCondensed';
		_duration ctrlSetFontHeight ((0.72 * (safeZoneH * 0.5)) / 10 / 2);
		_duration ctrlSetPosition [0.427813 * safezoneW + safezoneX,0.654 * safezoneH + safezoneY,0.113437 * safezoneW,0.022 * safezoneH];
		_duration ctrlSetFade _initialFade;
		_duration ctrlCommit 0;
		_display setVariable ['duration', _duration];
		_sound = _display ctrlCreate ['RscEdit', -1];
		_sound ctrlSetFont 'RobotoCondensed';
		_sound ctrlSetFontHeight ((0.72 * (safeZoneH * 0.5)) / 10 / 2);
		_sound ctrlSetPosition [0.427813 * safezoneW + safezoneX,0.676 * safezoneH + safezoneY,0.113437 * safezoneW,0.022 * safezoneH];
		_sound ctrlSetFade _initialFade;
		_sound ctrlCommit 0;
		_display setVariable ['sound', _sound];
		_titles = _display ctrlCreate ['RscEdit', -1];
		_titles ctrlSetFont 'RobotoCondensed';
		_titles ctrlSetFontHeight ((0.72 * (safeZoneH * 0.5)) / 10 / 2);
		_titles ctrlSetPosition [0.427813 * safezoneW + safezoneX,0.698 * safezoneH + safezoneY,0.113437 * safezoneW,0.022 * safezoneH];
		_titles ctrlSetFade _initialFade;
		_titles ctrlCommit 0;
		_display setVariable ['titles', _titles];
		_treeCtrl_f = _display ctrlCreate ['RscFrame', -1];
		_treeCtrl_f ctrlSetText 'File Browser';
		_treeCtrl_f ctrlSetFont 'EtelkaMonospaceProBold';
		_treeCtrl_f ctrlSetFontHeight ((0.44 * (safeZoneH * 0.5)) / 10 / 2);
		_treeCtrl_f ctrlSetTextColor [1,1,1,0.8];
		_adjmnt = 0.008;
		_treeCtrl_f ctrlSetPosition [0.386562 * safezoneW + safezoneX,(0.258 - _adjmnt) * safezoneH + safezoneY,0.226875 * safezoneW,(0.341 + _adjmnt) * safezoneH];
		_treeCtrl_f ctrlSetFade _initialFade;
		_treeCtrl_f ctrlEnable false;
		_treeCtrl_f ctrlCommit 0;
		progressLoadingScreen 1;
		_treeCtrl = _display ctrlCreate ["RscTree", -1];
		_display setVariable ['sounds', _treeCtrl];
		_treeCtrl setVariable ['ctrlSearch', _treeSearchCtrl];
		_treeSearchCtrl setVariable ['ctrlTree', _treeCtrl];
		_treeFavoritesFilterButtonCtrl setVariable ['ctrlTree', _treeCtrl];
		_treeSearchButtonCtrl setVariable ['ctrlTree', _treeCtrl];
		_treeCtrl ctrlSetFont 'RobotoCondensed';
		_treeCtrl ctrlSetFontHeight ((0.77 * (safeZoneH * 0.5)) / 10 / 2);
		_treeCtrl ctrlSetPosition [0.386562 * safezoneW + safezoneX,0.258 * safezoneH + safezoneY,0.226875 * safezoneW,0.341 * safezoneH];
		_treeCtrl ctrlCommit 0;
		_treeCtrl ctrlSetFade 0.69;
		_treeCtrl ctrlCommit 0;
		_treeCtrl ctrlEnable true;
		endLoadingScreen;
		private _yes = [format ["<t align='center' font='PuristaMedium' size='1.4'>Skip initial loading?<br/><br/><t size='0.77'>Sound browser will be empty;<br/>ready for search query<br/><br/>"], "Sound Board", 'Yes', 'No', _display, false, true] call BIS_fnc_guiMessage;
		if _yes then {
		} else {
			[_treeCtrl, '', true] call m9sd_fnc_populateSoundboardWithSearch;
		};
		_treeCtrl ctrladdEventHandler ["TreeSelChanged", 
		{
			params ["_control", "_selectionPath"];
			with uiNamespace do 
			{
				_display = ctrlParent _control;
				profileNamespace setVariable ['JAM_zeus_selectedSoundPath', _selectionPath];
				profileNamespace setVariable ['JAM_zeus_selectedSoundDisplayName', _control tvText _selectionPath];
				private _data = call (compile (_control tvData _selectionPath));
				private _class = 'N/A';
				private _name = 'N/A';
				private _duration = 'N/A';
				private _sound = 'N/A';
				private _titles = 'N/A';
				_sound2 = '';
				if (_data isEqualType []) then {
					_class = (_data # 0);
					_name = (_data # 1);
					_duration = (_data # 2);
					_sound = str (_data # 3);
					_sound2 = (_data # 3) # 0;
					_titles = str (_data # 4);
				} else {
					_sndPathSplit = (_data splitstring '\');
					_name = _sndPathSplit select (count _sndPathSplit - 1);
					_sound2 = _data;
				};
				private _classCtrl = _display getVariable 'class';
				private _nameCtrl = _display getVariable 'name';
				private _durationCtrl = _display getVariable 'duration';
				private _soundCtrl = _display getVariable 'sound';
				private _titlesCtrl = _display getVariable 'titles';
				_classCtrl ctrlSetText _class;
				_nameCtrl ctrlSetText _name;
				_durationCtrl ctrlSetText _duration;
				_soundCtrl ctrlSetText _sound;
				_titlesCtrl ctrlSetText _titles;
				_classCtrl ctrlSetTooltip _class;
				_nameCtrl ctrlSetTooltip _name;
				_durationCtrl ctrlSetTooltip _duration;
				_soundCtrl ctrlSetTooltip _sound;
				_titlesCtrl ctrlSetTooltip _titles;
				_classCtrl ctrlCommit 0;
				_nameCtrl ctrlCommit 0;
				_durationCtrl ctrlCommit 0;
				_soundCtrl ctrlCommit 0;
				_titlesCtrl ctrlCommit 0;
				private _speechCtrl = _display getVariable 'cbSpeech';
				private _play3Dctrl = _display getVariable 'cb3D';
				private _offsetCtrl = _display getVariable 'offset';
				private _pitchCtrl = _display getVariable 'pitch';
				private _scriptCtrl = _display getVariable 'script';
				private _script2Ctrl = _display getVariable 'script2';
				private _offset = parseNumber (ctrlText _offsetCtrl);
				private _scriptTxt = format ["playSound '%1';", _class];
				if ( ('.wav' in _sound2) or ('.wss' in _sound2) or ('.ogg' in _sound2) ) then {
					'is good'
				} else {
					_sound2 = _sound2 + '.wss';
				};
				private _scriptTxt2 = format ["playSound3D ['%1', player, false, getposasl player, 2, 1, 0, 0, false];", _sound2];
				if (cbChecked _speechCtrl) then 
				{
					_scriptTxt = format ["playSound ['%1', true, 0];", _class];
				} else 
				{
					_scriptTxt = format ["playSound ['%1', false, 0];", _class];
				};
				_scriptCtrl ctrlSetText _scriptTxt;
				_scriptCtrl ctrlSetTooltip _scriptTxt;
				_scriptCtrl ctrlCommit 0;
				_script2Ctrl ctrlSetText _scriptTxt2;
				_script2Ctrl ctrlSetTooltip _scriptTxt2;
				_script2Ctrl ctrlCommit 0;
			};
		}];
		_treeCtrl ctrladdEventHandler ["TreeDblClick", 
		{
			params ["_control", "_selectionPath"];
			profileNamespace setVariable ['JAM_zeus_selectedSoundPath', _selectionPath];
			_display = ctrlParent _control;
			_favorites = profilenamespace getvariable ['JAM_zeus_favoriteSounds', []];
			_sound = _control tvText _selectionPath;
			_index = _favorites find _sound;
			if (_index != -1) then 
			{
				_favorites deleteAt _index;
				_control tvSetColor [_selectionPath, JAM_zeus_uiColor];
				_control tvSetPictureColor [_selectionPath, JAM_zeus_uiColor];
				_control tvSetPictureRight [_selectionPath, 'a3\ui_f_curator\data\CfgCurator\waypoint_ca.paa'];
				_control tvSetPictureRightColor [_selectionPath, [1,1,1,0]];
				profilenamespace setvariable ['JAM_zeus_favoriteSounds', _favorites];
				playSound 'click';
				playSound ['addItemOk', true];
				_control ctrlCommit 0;
			} else 
			{
				_favorites pushBackUnique _sound;
				_control tvSetColor [_selectionPath, [1,1,1,1]];
				_control tvSetPictureColor [_selectionPath, [1,1,1,1]];
				_control tvSetPictureRight [_selectionPath, 'a3\ui_f_curator\data\displays\rscDisplayCurator\modeRecent_ca.paa'];
				_control tvSetPictureRightColor [_selectionPath, [1,1,1,1]];
				profilenamespace setvariable ['JAM_zeus_favoriteSounds', _favorites];
				playSound 'addItemOk';
				playSound ['click', true];
				_control ctrlCommit 0;
			};
		}];
		_treeCtrl ctrlSetFade _initialFade;
		_treeCtrl ctrlCommit 0;
		_play ctrlEnable true;
		_preview ctrlEnable true;
		_treeFavoritesFilterButtonCtrl ctrlEnable true;
		_treeSearchButtonCtrl ctrlEnable true;
		missionNamespace setVariable ['m9_sndbrdprog', 100];
		private _goob = _display getVariable ['prog', objnull];
		if (!isnull _goob) then {ctrlDelete _goob};
		if (false) then {'m9soundboardloadingscreen' cutText ["", "BLACK IN"];};
		{
			_x ctrlSetFade 0;
			_x ctrlCommit 3;
		} forEach allControls _display;
		playSound 'click';
		playSound ['border_Out', true];
		_treeCtrl ctrlEnable true;
	};
};
[] spawn M9sd_fnc_moduleSoundBoard2;