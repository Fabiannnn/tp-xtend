package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import excepciones.EventoException

@Accessors
class Locacion implements Entidad {

	String nombreLugar
	Point punto
	double superficie
	val personasPorMetroCuadrado = 0.8
	int id

	def double distancia(Point otroPunto) {
		punto.distance(otroPunto)
	}

	def estaDentroDelRadioDeCercania(Point otroPunto, double radioCercania) {
		distancia(otroPunto) <= radioCercania
	}

	def capacidadMaxima() {
		Math.floor(superficie * personasPorMetroCuadrado) as int
	}

	override validar() { // hacer las validaciones separadas para mandar excepciones independientes con descripcion
		(nombreLugar !== null && punto !== null )
	}

	override getId() {
		return id
	}

	override agregarId(int _nextId) {
		id = _nextId

	}

	override elementoBuscado(String cadena) {
		nombreLugar.contains(cadena)
	}

	override toString() {
		nombreLugar
	}

}
