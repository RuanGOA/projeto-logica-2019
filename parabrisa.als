module ParaBrisa

-- Define um objeto de assinatura Parabrisa, que possui um conjunto de paletas
sig Parabrisa{
	paletas: set Paleta
}

-- Define um objeto de assinatura Paleta, que pode trabalhar em conjunto com Bico ejetor (ou nao). 
-- Cada paleta possue um estado de velocidade. 
sig Paleta{
	bicoEjetor: set BicoEjetor,	
	velocidade: one Velocidade
}

-- Define um objeto de assinatura, BicoEjetor, que possue um status. Este pode ser de dois tipos, ativado ou desativado. 
sig BicoEjetor{
	status: one Status
}

-- Define um objeto de assinatura de Status abstract, pois cada bico ejetor só pode ter um tipo de status por vez. 
abstract sig Status {}

-- Define um objeto de assinatura de Desativado, que extende Status. 
sig Desativado extends Status{}

-- Define um objeto de assinatura de Ativado, que extende Status. 
sig Ativado extends Status{}

-- Define um objeto de assinatura de Velocidade abstract, pois cada paleta só pode ter um tipo de velocidade por vez. 
-- Estes podem ser de três tipos: desligada, velocidade baixa e velocidade alta.
abstract sig Velocidade{}

-- Define um objeto de assinatura de Desligado, que extende Velocidade. 
sig Desligada extends Velocidade{}

-- Define um objeto de assinatura de BaixaVelocidade, que extende Velocidade. 
sig BaixaVelocidade extends Velocidade{}

-- Define um objeto de assinatura de AltaVelocidade, que extende Velocidade. 
sig AltaVelocidade extends Velocidade{}

-- Regras:
-- Para toda Paleta, possui um Parabrisa;
-- Para todo Parabrisa, possui duas paletas;
-- Para toda Paleta, possui a mesma quantidade de BicoEjetor;
-- Para todo BicoEjetor, possui o mesmo Status;
-- Para toda Paleta, possui a mesma Velocidade;
-- Para todo BicoEjetor, possui exatamente uma Paleta;
-- Para toda Velocidade, possui pelo menos uma Paleta;
-- Para todo Status, possui pelo menos um Bicoejetor;
fact{

	all a:Paleta |  #a.QuantidadeParabrisas = 1
	all b:Parabrisa | #b.QuantidadePaletas = 2
	all c,d:Paleta | (#c.QuantidadeBicos = 1 and #d.QuantidadeBicos = 1) or (#c.QuantidadeBicos = 2 and #d.QuantidadeBicos = 2)
	all e,f:BicoEjetor | MesmoStatusBicosEjetores[e,f]
	all g,h:Paleta | MesmaVelocidadeDasPaletas[g,h]
	all i:BicoEjetor | one i.~bicoEjetor
	all j:Velocidade | some j.~velocidade
	all k:Status | some k.~status

}

-- Expressão que retorna a quantidade de Parabrisas.
fun QuantidadeParabrisas[a:Paleta]: set Parabrisa{
	a.~paletas
}

-- Expressão que retorna a quantidade de Paletas.
fun QuantidadePaletas[b:Parabrisa]: set Paleta{
	b.paletas
}

-- Expressão que retorna a quantidade de Bicos Ejetores.
fun QuantidadeBicos[c:Paleta]: set BicoEjetor{
	c.bicoEjetor
}

-- Operação parametrizada usada para restringir que os Bicos Ejetores possuam o mesmo Status.
pred MesmoStatusBicosEjetores[e:BicoEjetor, f:BicoEjetor]{
	e.status = f.status
}

-- Operação parametrizada usada para restringir que as Paletas possuam a mesma Velocidade.
pred MesmaVelocidadeDasPaletas[g:Paleta, h:Paleta]{
	g.velocidade = h.velocidade
}

-- Afirma que todo Parabrisa possui apenas duas paletas.
assert TodoParabrisaTemDuasPaletas{
	all p:Parabrisa | #p.paletas = 2
}
-- Verifica se todo Parabrisa possui apenas duas paletas, em 5 escopos.
check TodoParabrisaTemDuasPaletas for 5

-- Afirma que toda Paleta pertence a somente um Parabrisa.
assert TodaPaletaPertenceASomenteUmParabrisa{
	all p:Paleta | one p.~paletas
}
-- Verifica se toda Paleta pertence a somente um Parabrisa, em 5 escopos.
check TodaPaletaPertenceASomenteUmParabrisa for 5

-- Afirma que toda Paleta tem a mesma Velocidade.
assert TodaPaletaTemVelocidadeIgual{
	all a,b:Paleta | a.velocidade = b.velocidade
}
-- Verifica se toda Paleta tem a mesma Velocidade, em 5 escopos.
check TodaPaletaTemVelocidadeIgual for 5

-- Afirma que todo Bico Ejetor tem o mesmo status.
assert TodoBicoTemEstadoIgual{
	all a,b:BicoEjetor | a.status = b.status
}
-- Verifica se todo Bico Ejetor tem o mesmo status, em 5 escopos.
check TodoBicoTemEstadoIgual for 5

pred show[]{}

-- Encontra uma instância válida para 5 escopos.
run show for 5
