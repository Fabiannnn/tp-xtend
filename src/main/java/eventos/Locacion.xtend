package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Locacion {
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
}
