class Persona {
	const property edad
	
	method potencia() = 20
	method inteligencia() = 
		if (edad.between(20, 40)) 12 else 8
		
	method esDestacado() = edad == 25 or edad == 35
	
	method valor() = self.potencia() + self.inteligencia()
	
	method ofrecerTributo(planeta){}
}

class Atleta inherits Persona {
	var masaMuscular = 4
	var tecnica = 2
	
	override method potencia() = super() + masaMuscular * tecnica
	override method esDestacado() = super() or tecnica > 5
	method aprenderUnaTecnica(){ 
		tecnica += 1
	}
	method entrenar(dias){ 
		masaMuscular += dias/5
	}
	
	override method ofrecerTributo(planeta) {
		planeta.construirMuralla(2)
	}
}

class Docente inherits Persona {
	var property cursos = 0
	
	override method inteligencia()= super() + cursos *2
	override method esDestacado() = cursos > 3
	override method valor() = super() + 5
	
	override method ofrecerTributo(planeta) {
		planeta.fundarMuseo()
	}
}

class Soldado inherits Persona {
	const property armas = []
	
	method agregarArma(arma){ 
		armas.add(arma)
	}
	
	method potenciaDeArmas()= armas.sum({a => a.potencia()})
	override method potencia() = super() + self.potenciaDeArmas()
	
	override method ofrecerTributo(planeta) {
		planeta.construirMuralla(5)
	}
}

class Planeta {
	const habitantes = []
	var museos = 0
	var murallas = 0
	
	method nuevoHabitante(hab) {
		habitantes.add(hab)
	}
	
	method museos() = museos
	
	method delegacionDiplomatica() = habitantes.filter({h => h.esDestacado()}).asSet()
	method esCulto() = museos >= 2
	method potenciaReal() = habitantes.sum({h => h.potencia()})
	
	method construirMurallas(cant) {
		murallas += cant
	}
	
	method fundarMuseo() {
		museos += 1
	}
	
	method habitanteMasPotente() = habitantes.max({h => h.potencia()})
	method cantidadDeHAbitantes()= habitantes.size()
	method potenciaAparente() = self.habitanteMasPotente().potencia() * self.cantidadDeHAbitantes()
	method habitantesValiosos() = habitantes.filter({h => h.valor() >= 40 })  
	
	method necesitaReforzarse(){
		if(self.potenciaAparente() * 2 >= self.potenciaReal())
			habitantes.forEach({h => h.ofrecerTributo(self)})
	}
	
	method apaciguarPlaneta(planeta){
		self.habitantesValiosos().forEach({h => h.ofrecerTributo(planeta)})
	}
}

class Pistolete{
	var largo
	
	method potencia(soldado)=
		if(soldado.edad()>30) largo * 3 else largo * 2
}

class Espadon{
	const peso
	
	method potencia(soldado) =
		if (soldado.edad()<40) peso / 2 else  6
}