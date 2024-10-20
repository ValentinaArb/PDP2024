class Persona {
  const enfermedades = #{}
  var property temperatura = 36 //agregar property
  var celulas = 1000000
  method celulas() = celulas

  method pasarDias(cantidad) { //faltó
    cantidad.times { index =>
      enfermedades.forEach{enfermedad => enfermedad.causarEfecto(self)}
    }
  }

  method aumentarTemperatura(cantidad){
    temperatura += cantidad
  }

  method congelar(){
    temperatura = 0
  }

  method disminuirCelular(cantidad){
    celulas -= cantidad
  }

  method enfermarse(enfermedad) = enfermedades.add(enfermedad)

  method tratar(dosis) {
      enfermedades.forEach{enfermedad => enfermedad.atenuar(dosis)}
  }
}

class EnfermedadInfecciosa inherits Enfermedad{
  override method efecto(persona) = persona.aumentarTemperatura(celulasAmenazadas/1000)

  method reproducirse(){
    celulasAmenazadas *= 2
  }

  override method esAgresiva(persona)= celulasAmenazadas > 0.1 * persona.celulas()
}

class EnfermedadAutoinmune inherits Enfermedad{
  var afectada = 0 
  override method efecto(persona) {
    persona.disminuirCelulas(celulasAmenazadas)
    afectada += 1 
  }

  override method esAgresiva(persona) = afectada > 30
}

class Enfermedad {
  var celulasAmenazadas

  method curada() = celulasAmenazadas == 0

  method atenuar(dosis){
    celulasAmenazadas = (celulasAmenazadas - (dosis * 15)).max(0)
  }
  method efecto(paciente) //faltó

  method esAgresiva(paciente) //faltó
}

class Medico inherits Persona{
  const dosis
  method atender(persona) {
    persona.tratar(dosis)
  }

  override method enfermarse(enfermedad){
    self.atender(self)
  }
}

class JefeDepartamento inherits Medico{
  const subordinados = #{}

  method agregarSubordinado(subordinado) = subordinados.add(subordinado)

  override method atender(persona){
    if(!subordinados.isEmpty()){
      subordinados.anyOne().atender(persona)
    }
  }
}

object muerte {
  method atenuar(dosis){
    "No hacer nada"
  }

  method efecto(persona){
    persona.congelar()
  }

  method esAgresiva(paciente) = true
}