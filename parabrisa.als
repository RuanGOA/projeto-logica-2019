module ParaBrisa

--Parabrisa possui um conjunto de paletas
sig Parabrisa{
	paletas: set Paleta
}

--Paleta pode trabalhar em conjunto com Bico ejetor (ou nao). As paletas possuem,
-- uma velocidade. 
sig Paleta{
	bicoEjetor: some BicoEjetor,	
	limpador: one Velocidade
}

-- O bico ejetor pode estar ativado ou nao. 
sig BicoEjetor{}

sig Ativado extends BicoEjetor{}

sig Desativado extends BicoEjetor{}

--Velocidade abstract, pois so existe um tipo. 
abstract sig Velocidade{}

sig Desligada extends Velocidade{}

sig BaixaVelocidade extends Velocidade{}

sig AltaVelocidade extends Velocidade{}

pred show[]{}

run show for 2
