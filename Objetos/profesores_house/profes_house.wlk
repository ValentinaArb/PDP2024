class Paciente {
    const enfermedades = #{}
    var celulas = 8000000
    var temperatura = 36

    method celulas() = celulas

    method destruirCelulas(cantidad) {
        celulas -= cantidad
    }

    method enfermarse(enfermedad) {
        enfermedades.add(enfermedad)
    }

    method pasarDias(cantidad) {
        cantidad.times { index =>
            enfermedades.forEach{enfermedad => enfermedad.causarEfecto(self)}
        }
    }

    method aumentarTemperatura(cantidad) {
        temperatura += cantidad
    }

    method congelar() {
        temperatura = 0
    }

    method tratar(dosis) {
        enfermedades.forEach{enfermedad => enfermedad.atenuar(self.celulasAAtenuar(dosis))}
    }

    method celulasAAtenuar(dosis) = dosis * 15
    method temperatura() = temperatura
}

class Enfermedad {
    var property celulasAmenazadas

    method atenuar(cantidadCelulas) {
        celulasAmenazadas = (celulasAmenazadas - cantidadCelulas).max(0)
    }

    method estaCurada() = celulasAmenazadas == 0
    method causarEfecto(paciente)
    method esAgresiva(paciente)
}

class EnfermedadAutoinmune inherits Enfermedad {
    var vecesAfectado = 0

    override method causarEfecto(paciente) {
        paciente.destruirCelulas(celulasAmenazadas)
        vecesAfectado += 1
    }

    override method esAgresiva(paciente) = vecesAfectado > 30
}

class EnfermedadInfecciosa inherits Enfermedad {
    override method causarEfecto(paciente) {
        paciente.aumentarTemperatura(celulasAmenazadas / 1000)
    }

    method reproducirse() {
        celulasAmenazadas *= 2
    }

    override method esAgresiva(paciente) = celulasAmenazadas > paciente.celulas() * 0.1
}   


class JefeDeDepartamento inherits Medico {
    const property subordinados = #{}

    method agregarSubordinado(subordinado) {
        subordinados.add(subordinado)
    }

    override method atender(paciente) {
        if(!subordinados.isEmpty()){
            subordinados.anyOne().atender(paciente)
        }
    }
}

class Medico inherits Paciente {
    override method enfermarse(enfermedad) {
        super(enfermedad)
        self.atender(self)
    }
    method atender(paciente)
}

class MedicoDePlanta inherits Medico {    
    const dosis
    method atender(paciente) {
        paciente.tratar(dosis)
    }
}

object muerte inherits Enfermedad(celulasAmenazadas=0) {
    override method atenuar(dosis) {
        "No hacer nada"
    }
    override method causarEfecto(paciente) {
        paciente.congelar()
    }
    override method esAgresiva(paciente) = true
}