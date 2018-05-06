package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import excepciones.EventoException

@Accessors
class Locacion implements Entidad {

	String nombre
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

	override validar() { 
		if(nombre === null){
		throw new EventoException("Falta el nombre de la locacion")	
		}
		if(punto === null){
		throw new EventoException("Faltan las coordenadas")	
		}
		return true
		
	}
	

	override getId() {
		return id
	}

	override agregarId(int _nextId) {
		id = _nextId

	}

	override elementoBuscado(String cadena) {
		nombre.contains(cadena)
	}

	override toString() {
		nombre
	}

}
