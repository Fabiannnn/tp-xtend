package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Locacion {
	String nombreLugar
	Point punto
	double superficie
	val personasPorMetroCuadrado = 0.8

	new(String unNombreLugar, Point unPunto, double unaSuperficie) {
		nombreLugar = unNombreLugar
		punto = unPunto
		superficie = unaSuperficie
	}

	def double distancia(Point otroPunto) {
		punto.distance(otroPunto)
	}

	def capacidadMaxima() {
		Math.floor(superficie * personasPorMetroCuadrado) as int
	}
}
