package servicios

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import excepciones.EventoException
import eventos.Entidad
import eventos.Evento

@Accessors
class Servicio implements Entidad {
	String descripcion
	TipoDeTarifa tipoDeTarifa
	TipoDeServicio tipoDeServicio = new ServicioSimple
	double costoFijo = 0
	double costoMinimo = 0
	double costoPorHora = 0
	double porcentajeCostoMinimo = 0
	double costoPorPersona = 0
	double costoPorKm = 0
	Point ubicacion
	int id

	def double costoTotal(Evento evento) {
		tipoDeServicio.costoTotal(evento, this)
	}

	def double costoBaseServicio(Evento unEvento){
		tipoDeTarifa.costo(this, unEvento)
	}
	
	def double costoTraslado(Evento unEvento) {
		costoPorKm * unEvento.locacion.distancia(ubicacion)
	}
	
	def void agregarServicio(Servicio servicio) {
		tipoDeServicio.agregarServicio(servicio)
	}

	def void setServicioMultiple() {
		tipoDeServicio = new ServicioMultiple()
	}
	
	def void setTarifaFija() {
		tipoDeTarifa = new TarifaFija()
	}

	def void setTarifaPorHora() {
		tipoDeTarifa = new TarifaPorHora
	}

	def void setTarifaPorPersona() {
		tipoDeTarifa = new TarifaPorPersona
	}

	override def esValido() {
		validarUbicacion()
		validarDescripcion()
		validarTarifa()
	}

	def validarUbicacion() {
		if (ubicacion === null) {
			throw new EventoException("Faltan Datos de Ubicacion")
		}
	}

	def validarDescripcion() {
		if (descripcion.nullOrEmpty) {
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


