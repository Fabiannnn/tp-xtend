package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import excepciones.EventoException
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard

@Accessors

class TarjetaPagos {

	def pagarEntrada( CreditCard tarjeta, double _precio) {
			if (respuestaTarjeta(tarjeta,  _precio).statusCode !== 0) { 
			throw new EventoException(respuestaTarjeta(  tarjeta,  _precio).statusMessage)
		}
	}
def respuestaTarjeta( CreditCard tarjeta, double _precio){
	val CreditCardService creditCardService = new CreditCardService
	return creditCardService.pay(tarjeta, _precio)
}}
