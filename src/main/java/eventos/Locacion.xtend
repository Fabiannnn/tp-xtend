package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import excepciones.EventoException
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Locacion implements Entidad {

	String nombre
	public Point punto= new Point(0.0,0.0)
	double superficie
	val personasPorMetroCuadrado = 0.8
	int id


	def double distancia(Point otroPunto) {
		punto.distance(otroPunto)
	}

	def estaDentroDelRadioDeCercania(Usuario usuario) {
		distancia(usuario.coordenadas) <= usuario.radioDeCercania
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
}
