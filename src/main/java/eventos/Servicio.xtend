package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Servicio {
	String descripcion
	TipoDeTarifa tipoDeTarifa
	double costoFijo
	double costoMinimo
	double costoPorHora
	double porcentajeCostoMinimo
	double costoPorPersona
	double costoPorKm
	Point ubicacion

	def setTarifaFija() { 
		tipoDeTarifa = new TarifaFija()

	}
	def double costoTotal(Evento unEvento){
		tipoDeTarifa.costo(this,  unEvento) + costoTraslado(unEvento )
	}

	def double costoTraslado(Evento unEvento){
		costoPorKm * unEvento.locacion.distancia(ubicacion)
	}
	def void setTarifaPorHora(){ 
		tipoDeTarifa = new TarifaPorHora
	}

	def void setTarifaPorPersona() { 
		tipoDeTarifa = new TarifaPorPersona
	}

}

interface TipoDeTarifa {
	def double costo(Servicio unServicio, Evento unEvento)
}

class TarifaFija implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
	  unServicio.costoFijo
	}}

class TarifaPorHora implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
		unServicio.costoPorHora * unEvento.duracion + unServicio.costoMinimo
	
	}
}
class TarifaPorPersona implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
	Math.max((costoBasePorCapacidad(unServicio, unEvento)),(unEvento.cantidadAsistentes() * unServicio.costoPorPersona ))
	}
	
	def double costoBasePorCapacidad(Servicio unServicio, Evento unEvento){
		Math.round(unEvento.capacidadMaxima() * unServicio.porcentajeCostoMinimo/100) *unServicio.costoPorPersona
}	
	
}
