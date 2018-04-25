package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import repositorio.Entidad
import excepciones.EventoException

@Accessors
class Locacion implements Entidad {

	String nombreLugar
	Point punto
	double superficie
	val personasPorMetroCuadrado = 0.8

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

//	def boolean validarNombre() {
//		if (nombreLugar === null) {
//		throw new EventoException("Falta nombre")
//		}
//	}

	override toString() {
		nombreLugar
	}
}
//class locacion implements Entidad {
//	override validar() {
//		if (nombreLugar !== null && punto !== null ){true}
//		
//	}
//} 