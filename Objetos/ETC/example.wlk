/* object pepita {
  var energy = 100

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
  }
} */

object camionVerduras {
  var property cantidadCajones = 0
  const pesoCajones = 50  
  const velocidadBase = 80
  var kilometraje = 700000 

  method pesoCamion() = cantidadCajones * pesoCajones
  method velocidadMaxima() = (velocidadBase - self.pesoCamion()/500).max(0)
}

object camionScanion {
  const capacidadMaxima = 5000
  var property densidadLiquido = 0
  const property velocidadMaxima = 140
  method pesoCamion() =  (densidadLiquido * capacidadMaxima).max(0)
}

object camionCerealero {
  const velocidadBase = 60
  var property nivelDeterioro = 0
  var property pesoCamion = 0
  method velocidadMaxima() = (velocidadBase - nivelDeterioro).max(0)
}

/* object puestoRutatlantica{
  const cobraBase = 7000 
  const adicional = 100
  const velocidadPermitida= 75
  const tramoRecorrido = 400

  method cobro(camion) = cobraBase + adicional * (camion.pesoCamion()/1000)
  method pasarPorPuesto(camion) {
        var costo = self(camion)
        var limiteVelocidadPermitida = camion.velocidadMaxima().min(velocidadPermitida)
        
        if (camion == camionCerealero) {
          var excesoVelocidad = (camion.velocidadMaxima() - 45).max(0)
          camion.nivelDeterioro += excesoVelocidad * distanciaRecorrida / 1000
        }
        
        if (camion == camionVerduras) {
          camion.kilometraje += distanciaRecorrida
        }
        return costo
    }
}

 */
