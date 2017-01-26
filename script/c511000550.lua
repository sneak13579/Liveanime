--Insect Pheromone
function c511000550.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,37957847))
	--insect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000550,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511000550.intg)
	e3:SetOperation(c511000550.inop)
	c:RegisterEffect(e3)
	--force atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000489,0))
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511000550.atkcon)
	e4:SetTarget(c511000550.atktg)
	e4:SetOperation(c511000550.atkop)
	c:RegisterEffect(e4)
end
function c511000550.infilter(c)
	return c:IsFaceup() and not c:IsRace(RACE_INSECT)
end
function c511000550.intg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000550.infilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000550.infilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000550.inop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(RACE_INSECT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c511000550.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	return e:GetHandler():GetEquipTarget()==eg:GetFirst() and bc:IsReason(REASON_BATTLE)
end
function c511000550.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c511000550.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000550.atkfilter,tp,0,LOCATION_MZONE,1,bc) end
end
function c511000550.atkop(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	local g=Duel.SelectMatchingCard(tp,c511000550.atkfilter,tp,0,LOCATION_MZONE,1,1,bc)
	Duel.CalculateDamage(g:GetFirst(),ec)
end
