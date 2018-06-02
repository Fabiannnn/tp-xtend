package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard
import org.uqbar.ccService.CCResponse

@Accessors
class TarjetaPagos {
	CCResponse CCResponse
	CreditCardService creditCardService

	def setCreditCardService(CreditCardService ccService) {
		creditCardService = ccService
	}

	def pagarEntrada(CreditCard tarjetaCredito, double _precio) {
		if ((respuestaTarjeta(tarjetaCredito, _precio).statusCode) > 0) {
			throw new EventoException(CCResponse.statusMessage)
		}
	}

	def CCResponse respuestaTarjeta(CreditCard tarjeta, double _precio) {
		val CreditCardService creditCardService = new CreditCardService
		CCResponse = creditCardService.pay(tarjeta, _precio)
		return CCResponse
	}

	// Metodo que funciona mockeando solo la respuesta de creditCardService (se lo asignamos al objeto
	// TarjetaPagos de los test antes de llamar este método.
	def pagarLaEntrada(CreditCard tarjetaCredito, double _precio) {
		if ((respuestaDelServicioCC(tarjetaCredito, _precio).statusCode) > 0) {
			throw new EventoException(CCResponse.statusMessage)
		}
	}

	// Devuelve CCRresponse (esto lo mockeamos en el test).
	def CCResponse respuestaDelServicioCC(CreditCard tarjeta, double _precio) {
		CCResponse = creditCardService.pay(tarjeta, _precio)
		return CCResponse
	}

}
