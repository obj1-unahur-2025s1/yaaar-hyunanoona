class Mision{
  method puedeSerCompletadaPor(unBarco) = unBarco.tieneSuficienteTripulacion()
}

class BusquedaDelTesoro inherits Mision{
  const validos = ["brujula", "mapa", "grogXD"]
  
  method sirve(unPirata) = unPirata.items().any{i => validos.contains(i) and i.cantidadDeMonedas() < 5}

  override method puedeSerCompletadaPor(unBarco) = super(unBarco) and unBarco.tripulacion().any{t => t.items().contains("llave de cofre")}
}

class ConvertirseEnLeyenda inherits Mision{
  const itemObligatorio

  method sirve(unPirata) = unPirata.items().size() > 10 and unPirata.items().contains(itemObligatorio)
}

class Saqueo inherits Mision{
  var cantidadDeMonedasDeterminada
  var victima

  method sirve(unPirata) = unPirata.cantidadDeDinero() < cantidadDeMonedasDeterminada and unPirata.seAnimaASaquear(victima)

  override method puedeSerCompletadaPor(unBarco) = super(unBarco) and victima.esVulnerable(unBarco)
}