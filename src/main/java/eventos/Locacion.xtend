package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Locacion {
	String nombreLugar
	Point punto

	new(String unNombreLugar, Point unPunto) {
		nombreLugar = unNombreLugar
		punto = unPunto
	}

	def double distancia(Point otroPunto) {
		punto.distance(otroPunto)
	}
}
