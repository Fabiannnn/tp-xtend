package eventos

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.Period
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.ccService.CCResponse
import org.uqbar.ccService.CreditCard
import org.uqbar.ccService.CreditCardService
import org.uqbar.geodds.Point
import static org.mockito.Mockito.*
import repositorio.RepositorioUsuarios
import excepciones.EventoException

@Accessors
class TestsPago {
	//
	CCResponse respuesta2
	CCResponse respuesta0
	CCResponse respuesta1
	CreditCard tarjetaUno
	TarjetaPagos tarjetaPagos
	TarjetaPagos tarjetaPagos2
	TarjetaPagos tarjetaPagos3
	//
	CreditCardService creditCardService
	CreditCardService creditCardService2
	CreditCardService creditCardService0
	Entrada entradaPrueba
	int statusCode
	String statusMessage
	String name
	String number
	String cvc
	String expirationDate
	UsuarioFree usuarioFree
	EventoAbierto cumple
	Locacion salon_SM
	Usuario usuario2
	RepositorioUsuarios repoUsuario

	@Before
	def void init() {

		respuesta0 = mockearCCResponse(0, "Transaccion Exitosa")
		respuesta1 = mockearCCResponse(1, "Transaccion Invalida")
		respuesta2 = mockearCCResponse(2, "Error")
		tarjetaUno = mockearCreditCard("Asdasd", "1234", "123", "03/20")

		usuario2 = new Usuario => [
			nombreUsuario = "SegundoUsuario"
			email = "mail2"
			nombreApellido = "Mario Perez"
			fechaNacimiento = LocalDate.of(1900, 04, 02)
			punto = new Point(45, 60)
		]
		salon_SM = new Locacion => [
			nombre = "San Martin"
			punto = new Point(35, 45)
			superficie = 16
		]
		cumple = new EventoAbierto => [
			organizador = usuario2
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(25))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(26))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))
			edadMinima = 17
			precioEntrada = 200
		]
		usuarioFree = new UsuarioFree()
		usuario2.setUsuarioFree()
		tarjetaPagos2 = mockearTarjetaPagos(respuesta0, tarjetaUno, cumple)
		tarjetaPagos = mockearTarjetaPagos(respuesta1, tarjetaUno, cumple)
		creditCardService = mockearCreditCardService(respuesta1, tarjetaUno, cumple)
		creditCardService2 = mockearCreditCardService(respuesta2, tarjetaUno, cumple)
		creditCardService0 = mockearCreditCardService(respuesta0, tarjetaUno, cumple)
	}

	@Test
	def testCompraConTarjetaQueDaRespuestaCodigo0SeVerificaCompraEntrada() {
		val tarjetapagos = mock(typeof(TarjetaPagos))
		when(tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada)).thenReturn(respuesta0)
		Assert.assertEquals(0, tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusCode, 0)
		Assert.assertEquals("Transaccion Exitosa",tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusMessage)
	}

	@Test
	def testCCResponseConStatusCode2() {
		val tarjetapagos = mock(typeof(TarjetaPagos))
		when(tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada)).thenReturn(respuesta2)
		Assert.assertEquals(2, tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusCode, 0)
		Assert.assertEquals("Error", tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusMessage)
	}

	// 2) Test OK mockeando CreditCardService. 
	// Transacciones Invalida (codigo de error 1).
	@Test(expected=EventoException)
	def void testTransaccionInvalida() {
		var TarjetaPagos tarjetaPagos = new TarjetaPagos()
		tarjetaPagos.setCreditCardService(creditCardService)
		cumple.comprarConLaTarjetaDeCredito(usuario2, tarjetaUno, tarjetaPagos)

	}

	// Transacciones Error (codigo de error 2).
	@Test(expected=EventoException)
	def void testTransaccionError() {
		var TarjetaPagos tarjetaPagos = new TarjetaPagos()
		tarjetaPagos.setCreditCardService(creditCardService2)
		cumple.comprarConLaTarjetaDeCredito(usuario2, tarjetaUno, tarjetaPagos)
	}

	// Transacciones Exitosa (codigo de error 0).
	@Test
	def void testTransaccionExitosa() {
		var TarjetaPagos tarjetaPagos = new TarjetaPagos()
		tarjetaPagos.setCreditCardService(creditCardService0)
		cumple.comprarConLaTarjetaDeCredito(usuario2, tarjetaUno, tarjetaPagos)
		Assert.assertEquals(1, cumple.entradas.size(), 0)
	}

	// Implementacion de mocks
	// CCResponse
	def mockearCCResponse(int statusCode, String statusMessage) {
		val ccresponse = mock(typeof(CCResponse))
		when(ccresponse.statusCode).thenReturn(statusCode)
		when(ccresponse.statusMessage).thenReturn(statusMessage)
		ccresponse
	}

	// CreditCard
	def mockearCreditCard(String unNombre, String unNumero, String unCVV, String unaFechaExpiracion) {
		val creditcard = mock(typeof(CreditCard))
		when(creditcard.name).thenReturn(unNombre)
		when(creditcard.number).thenReturn(unNumero)
		when(creditcard.cvc).thenReturn(unCVV)
		when(creditcard.expirationDate).thenReturn(unaFechaExpiracion)
		creditcard
	}

	// TarjetaPagos
	def mockearTarjetaPagos(CCResponse ccresponse, CreditCard cc, EventoAbierto cumple) {
		val tarjetapagos = mock(typeof(TarjetaPagos))
		when(tarjetapagos.respuestaTarjeta(cc, cumple.precioEntrada)).thenReturn(ccresponse)
		tarjetapagos
	}

	// CreditCardService
	def mockearCreditCardService(CCResponse ccresponse, CreditCard cc, EventoAbierto cumple) {
		val service = mock(typeof(CreditCardService))
		when(service.pay(cc, cumple.precioEntrada)).thenReturn(ccresponse)
		service
	}

}
