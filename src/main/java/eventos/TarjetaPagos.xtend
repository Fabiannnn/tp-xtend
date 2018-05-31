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
	
	def pagarEntrada( CreditCard tarjetaCredito, double _precio) {
		println("dddddd")
			if ((respuestaTarjeta(tarjetaCredito, _precio).statusCode) > 0) { 				
						println("dooooooooooooo"+respuestaTarjeta(tarjetaCredito, _precio).statusCode)
			throw new EventoException(CCResponse.statusMessage)
		}
	}
	
	def pagarEntrada2(CreditCardService creditcardserv, CreditCard tarjetaCredito, double _precio) {
			if ((respuestaTarjeta2(creditcardserv, tarjetaCredito, _precio).statusCode) > 0) { 				
			throw new EventoException(CCResponse.statusMessage)
		}
	}
	
def CCResponse respuestaTarjeta( CreditCard tarjeta, double _precio){
	val CreditCardService creditCardService = new CreditCardService
	CCResponse = creditCardService.pay(tarjeta, _precio)
	return CCResponse
}

def CCResponse respuestaTarjeta2(CreditCardService creditCardServ, CreditCard tarjeta, double _precio){
	CCResponse = creditCardServ.pay(tarjeta, _precio)
	return CCResponse
}

}
