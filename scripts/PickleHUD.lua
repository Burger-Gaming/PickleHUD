--[[
	PickleHUD by Burger Gaming.

	Hello!
	The top part of this code (before "function onCreate()")
	are settings you can adjust to your liking.
	Sadly, there's no custom mod options I can make yet.
	There is guidance on each variable to be adjusted and how all of it works.
	Enjoy.
]]

-- Change the name that displays on the screen.
local name = 'Anonymous';

-- Copy paste a hexadecimal color (without the #).
local customColor = '000000';

--[[
	If you think the color is good for the border, than keep this enabled.
	Otherwise, change it to false.
	If it does not have color, it will be black by default.
	
	This setting can also be applied to the lane underlay by setting the
	variable after this to true.
]]
local textBorderHasColor = true;
local underlayHasColor = true;

-- Adjust the transparency of the underlay.
local underlayAlpha = 0.5;

--[[
	Path to the icon and border, it can be in any folder in 'mods/images'
	but for the sake of organization you might wanna keep it in this pre-made folder.
	Alternatively, you can just skin the original asset.

	When making a custom one, make sure it is 150 pixels wide by 150 pixels tall.
	Otherwise, you'll have to re-adjust the position of the icon and border.

	There is another template for a circle-shaped icon in the same folder.
]] 
local iconPath = 'PickleHUD/icon';
local iconBorderPath = 'PickleHUD/iconBorder';

--[[
	Sometimes, if you have a long name, the text might move INTO the icon.
	Increase this variable to offset it.
	The variable "ratingOffset" also helps to adjust the offset.
]]
local customWidth = 300;
local ratingOffset = 0;

-- Don't adjust anything beyond this.
local iconY = 560;
local textY = 670;
local scoreTextY = 677;
local ratingTextY = textY - 90;
local versionTextY = iconY - 20;
local thingy = "Sick: 0\nGood: 0\nBad:  0\nShit: 0";
local version = '1.0.0';

function onCreatePost()
	if downscroll == true then
		iconY = 10;
		textY = 20;
		scoreTextY = 43;
		ratingTextY = textY + 40;
		versionTextY = 164;
	end

	-- lane underlay feature
	makeLuaSprite('underlay', null, -200, -100);
	if underlayHasColor == true then
		makeGraphic('underlay', 1920, 1080, customColor);
	else
		makeGraphic('underlay', 1920, 1080, '000000');
	end
	setScrollFactor('underlay', 0, 0);
	setObjectCamera('underlay', 'game');
	addLuaSprite('underlay', true);
	setProperty('underlay.alpha', underlayAlpha);


	-- icon
	makeLuaSprite('icon', iconPath, 10, iconY);
	setScrollFactor('icon', 0, 0);
	setObjectCamera('icon', 'hud');
	addLuaSprite('icon', true);



	-- icon border
	makeLuaSprite('iconBorder', iconBorderPath, 10, iconY);
	setScrollFactor('iconBorder', 0, 0);
	setObjectCamera('iconBorder', 'hud');
	addLuaSprite('iconBorder', true);
	setProperty('iconBorder.color', getColorFromHex(customColor));



	-- name
	makeLuaText('customUIText', name, customWidth, 130, textY);
	setTextSize('customUIText', 36);
	if textBorderHasColor == true then
		setTextBorder('customUIText', 2, customColor);
	else
		setTextBorder('customUIText', 2, '000000');
	end
	
	setTextFont('customUIText', 'vcr.ttf');
	setScrollFactor('customUIText', 0, 0);
	setObjectCamera('customUIText', 'hud');
	addLuaText('customUIText');



	-- ratings
	makeLuaText('ratingCounter', thingy, 300, getProperty('customUIText.x') + 55 + ratingOffset, ratingTextY);
	setTextSize('ratingCounter', 24);
	if textBorderHasColor == true then
		setTextBorder('ratingCounter', 2, customColor);
	else
		setTextBorder('ratingCounter', 2, '000000');
	end
	
	setTextFont('ratingCounter', 'vcr.ttf');
	setScrollFactor('ratingCounter', 0, 0);
	setObjectCamera('ratingCounter', 'hud');
	addLuaText('ratingCounter');
	setTextAlignment('ratingCounter', 'left');



	--[[
		Please don't remove this. I think that should be common sense right now.
	]]
	makeLuaText('version', "PickleHUD v" .. version, 0, 10, versionTextY);
	setTextSize('version', 16);
	if textBorderHasColor == true then
		setTextBorder('version', 2, customColor);
	else
		setTextBorder('version', 2, '000000');
	end
	
	setTextFont('version', 'vcr.ttf');
	setScrollFactor('version', 0, 0);
	setObjectCamera('version', 'hud');
	addLuaText('version');
	setTextAlignment('version', 'left');

	-- adjustment to healthbar and icons

	setProperty('iconP1.visible', false);
	setProperty('iconP2.visible', false);

	setProperty('healthBar.x', 600);
	setProperty('scoreTxt.x', 250);
	setProperty('scoreTxt.y', scoreTextY);

	-- botplay text
	makeLuaText('botplay', "BOTPLAY", 0, 10, versionTextY - 20);
	setTextSize('botplay', 16);
	setTextBorder('botplay', 2, '000000');
	setTextColor('botplay', 'FF0000')
	setTextFont('botplay', 'vcr.ttf');
	setScrollFactor('botplay', 0, 0);
	setObjectCamera('botplay', 'hud');
	addLuaText('botplay');
	setTextAlignment('botplay', 'left');

	-- song name
	local diffName = 'SPOAR';
	if difficulty == 0 then
		diffName = 'EASY';
	elseif difficulty == 1 then
		diffName = 'NORMAL';
	else
		diffName = 'HARD';
	end
	makeLuaText('songNameLol', songName .. " - " .. diffName, 0, getProperty('healthBar.x') - 2, getProperty('healthBar.y') - 30);
	setTextSize('songNameLol', 24);
	setTextBorder('songNameLol', 2, '000000');
	setTextFont('songName', 'vcr.ttf');
	setScrollFactor('songNameLol', 0, 0);
	setObjectCamera('songNameLol', 'hud');
	addLuaText('songNameLol');
	setTextAlignment('songNameLol', 'left');

	setProperty('botplayTxt.text', "");
end

function onUpdate()
	if botPlay == true then
		setProperty('botplay.visible', true);
	else
		setProperty('botplay.visible', false);
	end
	setProperty('botplayTxt.text', "");
end

function goodNoteHit()
	thingy = "Sick: " .. getProperty('sicks') .. "\nGood: " .. getProperty('goods') .. "\nBad:  " .. getProperty('bads') .. "\nShit: " .. getProperty('shits');
	setTextString('ratingCounter', thingy);
end