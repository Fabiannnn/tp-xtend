package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import excepciones.EventoException

@Accessors
class Servicio implements Entidad {
	String descripcion
	TipoDeTarifa tipoDeTarifa
	double costoFijo = 0
	double costoMinimo = 0
	double costoPorHora = 0
	double porcentajeCostoMinimo = 0
	double costoPorPersona = 0
	double costoPorKm = 0
	Point ubicacion
	int id

	def setTarifaFija() {
		tipoDeTarifa = new TarifaFija()
	}

	def double costoTotal(Evento unEvento) {
		tipoDeTarifa.costo(this, unEvento) + costoTraslado(unEvento)
	}

	def double costoTraslado(Evento unEvento) {
		costoPorKm * unEvento.locacion.distancia(ubicacion)
	}

	def void setTarifaPorHora() {
		tipoDeTarifa = new TarifaPorHora
	}

	def void setTarifaPorPersona() {
		tipoDeTarifa = new TarifaPorPersona
	}

	override def  esValido() {
			validarUbicacion()
			validarDescripcion()
			validarTarifa()
		
	}
	def	validarUbicacion(){
			if (ubicacion === null){
				throw new EventoException("Faltan Datos de Ubicacion")
				
			}
			
		}
	def	validarDescripcion(){
			if (descripcion.nullOrEmpty){
				throw new EventoException("Faltan Datos de descripcion")
				
			}
			
		}
	
	def validarTarifa() {
		if (tipoDeTarifa !== null) {
			tipoDeTarifa.validarTipoTarifa(this)
		} else {
			throw new EventoException("Faltan Datos de tarifas")
		}
	}

	override int getId() {
		return id
	}

	override void agregarId(int _nextId) {
		id = _nextId
	}

	override boolean filtroPorTexto(String cadena) {
		descripcion.startsWith(cadena)
	}
}

interface TipoDeTarifa {
	def double costo(Servicio unServicio, Evento unEvento)

	def boolean validarTipoTarifa(Servicio unservicio)
}

class TarifaFija implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
		unServicio.costoFijo
	}

	override boolean validarTipoTarifa(Servicio unServicio) {
		if (!(unServicio.costoFijo > 0)) {
			throw new EventoException("Falta establecer costo fijo")
		}
		return true
	}
}

class TarifaPorHora implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
		unServicio.costoPorHora * unEvento.duracion + unServicio.costoMinimo
	}

	override boolean validarTipoTarifa(Servicio unServicio) {
		if (!(unServicio.costoPorHora > 0)) {
			throw new EventoException("Falta establecer costo por hora")
		}
		return true
	}
}

class TarifaPorPersona implements TipoDeTarifa {
	override double costo(Servicio unServicio, Evento unEvento) {
		Math.max((costoBasePorCapacidad(unServicio, unEvento)), (unEvento.cantidadAsistentes() *
			unServicio.costoPorPersona ))
	}

	override boolean validarTipoTarifa(Servicio unServicio) {
		if (!(unServicio.costoPorPersona > 0)) {
			throw new EventoException("Falta establecer costo por persona")
		}
		return true
	}

	def double costoBasePorCapacidad(Servicio unServicio, Evento unEvento) {
		Math.round(unEvento.capacidadMaxima() * unServicio.porcentajeCostoMinimo / 100) * unServicio.costoPorPersona
	}
}
