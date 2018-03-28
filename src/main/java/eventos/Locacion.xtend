package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Localizacion {
	String nombreLugar
	Point punto

	// BigDecimal XCoord
	// BigDecimal YCoord
	new(String unNombreLugar, Point unPunto) {
		nombreLugar = unNombreLugar
		punto = unPunto
	}

	def double distancia(Point otroPunto) {
		punto.distance(otroPunto)
	}
}
