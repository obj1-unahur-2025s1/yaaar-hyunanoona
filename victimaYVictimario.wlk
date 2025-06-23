class Barco{
  var mision
  const capacidad
  const property tripulacion

  method reclutar(unPirata){if (mision.sirve(unPirata) and capacidad >= tripulacion.size()) tripulacion.add(unPirata)}
  
  method piratasInutiles() = tripulacion.filter{p => not mision.sirve(p)}
  
  method cambiarDeMision(unaMision){
    mision = unaMision
    tripulacion.removeAll(self.piratasInutiles())
  }
  
  method tieneSuficienteTripulacion() = (tripulacion*100)/capacidad >= (capacidad*90)/100

  method seCumpleElRequerimiento(unVictimario) = unVictimario.estaPasadoEnGrogXd()
  
  method esVulnerable(unBarco) =  tripulacion.size() < unBarco.tripulacion().size()*0.5

  method masBorracho() = tripulacion.max{p => p.nivelDeEbriedad()}
  
  method anclarEn(unaCiudad){
    tripulacion.forEach{p => p.tomarTragoDeGrogXD()}
    tripulacion.remove(self.masBorracho())
    unaCiudad.agregarHabitante()
  }

  method esTemible() = mision.puedeSerCompletadaPor(self)

  method tripulantesPasadosEnGrogXD() = tripulacion.filter{p => p.estaPasadoEnGrogXd()}.size()

  method itemsDePiratasPasadosEnGrogXD() = self.tripulantesPasadosEnGrogXD().map{p => p.items()}.asSet()

  method pirataPasadoEnGrogXDMasRico() = self.tripulantesPasadosEnGrogXD().max{p => p.cantidadDeDinero()}
}


class Pirata{
  var property items
  var property nivelDeEbriedad
  var property cantidadDeDinero

  method estaPasadoEnGrogXd() = nivelDeEbriedad > 90

  method seAnimaASaquear(unaVictima) = unaVictima.seCumpleElRequerimiento(self)

  method tomarTragoDeGrogXD(){
    nivelDeEbriedad = nivelDeEbriedad + 5
    cantidadDeDinero = cantidadDeDinero - 1
  }
}


class Espia inherits Pirata{
  override method estaPasadoEnGrogXd() = false

  override method seAnimaASaquear(unaVictima) = super(unaVictima) and items.contains("permiso de la corona")
}

class ciudadCostera{
  var cantidadDeHabitantes
  method seCumpleElRequerimiento(unVictimario) = unVictimario.nivelDeEbriedad() >= 50

  method esVulnerable(unBarco) = (unBarco.tripulacion()*100)/cantidadDeHabitantes >= 40 or unBarco.all{p => p.estaPasadoEnGrogXd()}

  method agregarHabitante(){cantidadDeHabitantes = cantidadDeHabitantes + 1}
}