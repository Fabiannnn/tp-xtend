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
	int idLocacion=0
	
	new(Object object, Locacion locacion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
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

	override toString() {
		nombreLugar
	}
	
	override nextId() {
		idLocacion+=1
		return idLocacion
	}
	
}
 