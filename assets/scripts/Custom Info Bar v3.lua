local botPlayScore = 0;
local totalNotes = 0;
local calculationDone = false;

--Made by Acap09
--Improved by Superpowers04
--Version 3.0
--Last updated on 4th May 2022 on 5:20 PM (UTC+8)

function onStartCountdown()
	if not calculationDone then
		for i = 0, getProperty('unspawnNotes.length') do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') and not getPropertyFromGroup('unspawnNotes', i, 'ignoreNote') and not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
			    totalNotes = totalNotes + 1;
			end
		end
		calculationDone = true;
	end
	maxScore = totalNotes*350;
	
	makeLuaText('scoreTxtLua', 'Score: 0 | Misses: 0 | Combo: 0 | Health: 50% | Accuracy: N/A (0%)', getTextWidth('scoreTxt'), getProperty('scoreTxt.x'), getProperty('scoreTxt.y'))
	addLuaText('scoreTxtLua')

	setTextSize('scoreTxtLua', getTextSize('scoreTxt'))
	setProperty('scoreTxt.visible', false)
end

function goodNoteHit(noteID, noteDir, noteType, noteSustain)
	if not noteSustain and not getPropertyFromGroup('notes', noteID, 'ignoreNote') then
		botPlayScore = botPlayScore + 350;
	end

end

function onUpdatePost(elapsed)
	health = getProperty('health');
	healthPer = health*50;
	accuracy1 = rating*10000;
	accuracy2 = math.floor(accuracy1);
	accuracyLua = accuracy2/100;

	setProperty('scoreTxtLua.x', getProperty('scoreTxt.x'))
	setProperty('scoreTxtLua.y', getProperty('scoreTxt.y'))
	setProperty('scoreTxtLua.scale.x', getProperty('scoreTxt.scale.x'))
	setProperty('scoreTxtLua.scale.y', getProperty('scoreTxt.scale.y'))

	setTextString('scoreTxtLua', (botPlay and 'Botplay Score: '..botPlayScore or 'Score: '..score)..'/'..maxScore..' |'..(misses == 0 and not botPlay and ' FC |' or botPlay and '' or ' Misses: '..misses..' |')..' Combo: '..getProperty('combo')..' | Health: '..healthPer..'%'..(not botPlay and ' | Accuracy: '..ratingName..' ('..accuracyLua..'%)' or ''))
	
	setProperty('scoreTxtLua.color', getColorFromHex((health > 1.6 and '00FF00' or
		(health > 0.4 and health < 1.6 and (misses == 0 and 'C4FFC4' or 'FFFFFF')
		or 'FF0000'))))
end
