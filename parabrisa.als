module ParaBrisa

--Parabrisa possui um conjunto de paletas
sig Parabrisa{
	paletas: set Paleta
}

--Paleta pode trabalhar em conjunto com Bico ejetor (ou nao). As paletas possuem,
-- uma velocidade. 
sig Paleta{
	bicoEjetor: set BicoEjetor,	
	velocidade: one Velocidade
}

-- O bico ejetor pode estar ativado ou nao. 
sig BicoEjetor{
	status: one Status
}

abstract sig Status {}

sig Desativado extends Status{}

sig Ativado extends Status{}

--Velocidade abstract, pois so existe um tipo de velocidade. 
abstract sig Velocidade{}

sig Desligada extends Velocidade{}

sig BaixaVelocidade extends Velocidade{}

sig AltaVelocidade extends Velocidade{}

fact{
	all p:Parabrisa | #p.paletas = 2
}

pred show[]{}

run show for 2
