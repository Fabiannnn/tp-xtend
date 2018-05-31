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
			coordenadas = new Point(45, 60)
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

	@Test//(expected=EventoException)
	def void testCompraConTarjetaQueDaRespuestaCodigo1() {
		var TarjetaPagos tarjetaPagos3 = new TarjetaPagos()
			respuesta1 = mockearCCResponse(1, "Transaccion Invalida")
			val CCResponse = mock(typeof(CCResponse))
		tarjetaPagos3.CCResponse = respuesta1
	
		when(tarjetaPagos3.respuestaTarjeta(tarjetaUno, cumple.precioEntrada)).thenReturn(tarjetaPagos3.CCResponse)
				println(tarjetaPagos3.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusCode)
		cumple.comprarConTarjetaDeCredito(usuario2, tarjetaUno, tarjetaPagos3)
		println(tarjetaPagos3.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusMessage)
//			cumple.comprarConTarjetaDeCredito(usuario2, tarjetaUno, tarjetaPagos)
	Assert.assertEquals(1, cumple.entradas.size(), 0)

	}
	
	@Test(expected=EventoException)
	def void testTransaccionInvalida() {
		var TarjetaPagos tar = new TarjetaPagos()
		cumple.comprarConTarjetaDeCredito2(usuario2, tarjetaUno, tar, creditCardService)

	}
	
	@Test(expected=EventoException)
	def void testTransaccionError() {
		var TarjetaPagos tar = new TarjetaPagos()
		cumple.comprarConTarjetaDeCredito2(usuario2, tarjetaUno, tar, creditCardService2)
	}
	
	@Test
	def void testTransaccionExitosa() {
		var TarjetaPagos tar = new TarjetaPagos()
		cumple.comprarConTarjetaDeCredito2(usuario2, tarjetaUno, tar, creditCardService0)
		Assert.assertEquals(1, cumple.entradas.size(), 0)
	}
	

	@Test
	def testCompraConTarjetaQueDaRespuestaCodigo0SeVerificaCompraEntrada() {
		val TarjetaPagos tarjeta = new TarjetaPagos
		// when(tarjetaPagos2.respuestaTarjeta(tarjetaUno, cumple.precioEntrada)).thenReturn(respuesta0)
		// cumple.comprarConTarjetaDeCredito(usuario2, tarjetaUno, tarjetaPagos2)
		tarjeta.pagarEntrada(tarjetaUno, cumple.precioEntrada)
		// println(tarjeta.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusMessage)
		Assert.assertEquals(1, cumple.entradas.size(), 0)

	}

	@Test(expected=EventoException)
	def testaiuuda() {
		val TarjetaPagos tarjeta = new TarjetaPagos()
//		tarjeta.probando()
	}

	@Test
	def testProbandoMocks() {
		println(respuesta2.statusMessage)
		Assert.assertEquals(2, respuesta2.statusCode, 0)
	}

	@Test
	def testCCResponseConStatusCode0() {
		val tarjetapagos = mock(typeof(TarjetaPagos))
		when(tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada)).thenReturn(respuesta2)
		Assert.assertEquals(2, tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusCode, 0)
		Assert.assertEquals("Error", tarjetapagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada).statusMessage)
	}

	// Implementacion de mocks para CreditCard y CCResponse
	def mockearCCResponse(int statusCode, String statusMessage) {
		val ccresponse = mock(typeof(CCResponse))
		when(ccresponse.statusCode).thenReturn(statusCode)
		when(ccresponse.statusMessage).thenReturn(statusMessage)
		ccresponse
	}

	def mockearCreditCard(String unNombre, String unNumero, String unCVV, String unaFechaExpiracion) {
		val creditcard = mock(typeof(CreditCard))
		when(creditcard.name).thenReturn(unNombre)
		when(creditcard.number).thenReturn(unNumero)
		when(creditcard.cvc).thenReturn(unCVV)
		when(creditcard.expirationDate).thenReturn(unaFechaExpiracion)
		creditcard
	}

	def mockearTarjetaPagos(CCResponse ccresponse, CreditCard cc, EventoAbierto cumple) {
		val tarjetapagos = mock(typeof(TarjetaPagos))
		when(tarjetapagos.respuestaTarjeta(cc, cumple.precioEntrada)).thenReturn(ccresponse)
		tarjetapagos
	}
	
	def mockearCreditCardService(CCResponse ccresponse, CreditCard cc, EventoAbierto cumple) {
		val service = mock(typeof(CreditCardService))
		when(service.pay(cc, cumple.precioEntrada)).thenReturn(ccresponse)
		service
	}

}
