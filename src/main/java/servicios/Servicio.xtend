package servicios

import eventos.Entidad
import eventos.Evento
import excepciones.EventoException
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.geodds.Point
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@TransactionalAndObservable
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
	public Point punto = new Point(0.0, 0.0)
	int id
	
	@Dependencies("ubicacion")
	def double getPuntoX(){punto.latitude}
	def setPuntoX(double unValor){	
		punto.x = unValor.doubleValue
	}
	@Dependencies("ubicacion")
	def double getPuntoY(){punto.longitude}
	def setPuntoY(double unValor){	
		punto.y = unValor.doubleValue
	}

	def List<TipoDeServicio> getTiposDeServicios() {
		#[new ServicioMultiple, new ServicioSimple]
	}

	def List<TipoDeTarifa> getTiposDeTarifas() {
		#[new TarifaPorHora, new TarifaPorPersona, new TarifaFija]
	}

	def costoCompleto() {
		(costoServicio + " " + costoMinimo)
	}

	def costoServicio() {
		if (tipoDeTarifa instanceof TarifaFija) {
			return (costoFijo + " TF ")
		} else if (tipoDeTarifa instanceof TarifaPorHora) {
			return (costoPorHora + " TH ")
		} else {
			return (costoPorPersona + " TPP ")
		}
	}

	def double costoTotal(Evento evento) {
		tipoDeServicio.costoTotal(evento, this)
	}

	def double costoBaseServicio(Evento unEvento) {
		tipoDeTarifa.costo(this, unEvento)
	}

	def double costoTraslado(Evento unEvento) {
		costoPorKm * unEvento.locacion.distancia(punto)
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

	override esValido() {
		validarUbicacion()
		validarDescripcion()
		validarTarifa()
	}

	def validarUbicacion() {
		if (punto === null) {
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
