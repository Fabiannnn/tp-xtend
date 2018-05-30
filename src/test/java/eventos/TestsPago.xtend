package eventos

import org.uqbar.ccService.CCResponse
import org.junit.Before
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.ccService.CreditCard
import org.uqbar.ccService.CreditCardService
import org.junit.Test
import excepciones.EventoException
import static org.mockito.Mockito.*

@Accessors
class TestsPago extends FixtureTest {
//	StubCreditCardService stubCreditCardService
	CCResponse mockedCCResponse
	CCResponse respuesta
	CCResponse respuesta1
	CreditCard tarjetaUno
	CreditCardService creditCardService

	int statusCode
	String statusMessage
	String name
	String number
	String cvc
	String expirationDate
	TarjetaPagos tarjetaPagos = new TarjetaPagos

	@Before
	def void initTestPago() {
		init
		respuesta = new CCResponse() => [
			statusCode = 0
			statusMessage = "Transacción Exitosa"

		]
		respuesta1 = new CCResponse() => [
			statusCode = 1
			statusMessage = "Datos Invalidos"

		]

		tarjetaUno = new CreditCard() => [
			name = "ududu"
			number = "tetete"
			cvc = "erwrw"
			expirationDate = "08/34"

		]
	}

	@Test(expected=EventoException)
	def primertesttarjeta() {
		respuesta1 = mock(typeof(CCResponse))
		when(tarjetaPagos.respuestaTarjeta(tarjetaUno, 200)).thenReturn(respuesta1)
		cumple.comprarConTarjetaDeCredito(usuario2, tarjetaUno)
	}

}
