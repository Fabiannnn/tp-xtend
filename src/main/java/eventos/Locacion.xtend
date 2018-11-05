package eventos

import excepciones.EventoException
import org.eclipse.xtend.lib.annotations.Accessors
//import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.geodds.Point
import com.fasterxml.jackson.annotation.JsonIgnore

//import org.uqbar.commons.model.annotations.Dependencies

@Accessors
//@TransactionalAndObservable
class Locacion implements Entidad {
	int id
	String nombre
	
	@JsonIgnore public Point punto = new Point(0.0, 0.0)
	@JsonIgnore double superficie
	@JsonIgnore val personasPorMetroCuadrado = 0.8







	def double distancia(Point otroPunto) {
		punto.distance(otroPunto)
	}

	def estaDentroDelRadioDeCercania(Usuario usuario) {
		distancia(usuario.punto) <= usuario.radioDeCercania
	}

	def capacidadMaxima() {
		Math.floor(superficie * personasPorMetroCuadrado) as int
	}

	override esValido() {
		if (nombre.nullOrEmpty) {
			throw new EventoException("Falta el nombre de la locacion")
		}
		if (punto === null) {
			throw new EventoException("Faltan las coordenadas")
		}
	}

	override getId() {
		return id
	}

	override agregarId(int _nextId) {
		id = _nextId
	}

	override filtroPorTexto(String cadena) {
		nombre.contains(cadena)
	}

	override toString() {
		nombre
	}
	
/* 	@Dependencies("ubicacion")
	def double getPuntoX(){punto.latitude}
	def setPuntoX(double unValor){	
		punto.x = unValor.doubleValue
	}
	@Dependencies("ubicacion")
	def double getPuntoY(){punto.longitude}
	def setPuntoY(double unValor){	
		punto.y = unValor.doubleValue
	}*/
}
