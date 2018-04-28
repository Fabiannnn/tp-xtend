package eventos

import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException

@Accessors
class LocacionBuilder {
	String nombreLugar
	Point punto
	double superficie

	new() {
	}

	def nombreLugar(String _nombreLugar) {
		this.nombreLugar = _nombreLugar
		this
	}

	def punto(Point _punto) {
		this.punto = _punto
		this
	}

	def superficie(double _superficie) {
		this.superficie = _superficie
		this
	}

	def build() {
		if (nombreLugar !== null && punto !== null ) {
			new Locacion() => [
				it.nombreLugar = nombreLugar
				it.punto = punto
				it.superficie = superficie
			]
		} else {
			throw new EventoException("No crear la Locacion")
		}

	}
}
