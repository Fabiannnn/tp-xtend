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

@Accessors
class TestsPago  {
//	StubCreditCardService stubCreditCardService
	CCResponse mockedCCResponse
	CCResponse respuesta0
	CCResponse respuesta1
	CreditCard tarjetaUno
//	CreditCardService creditCardService
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
	def void initTestPago() {
		
		respuesta0 = new CCResponse() => [
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
	}

	@Test
	def testCompraConTarjetaQueDaRespuestaCodigo1() {
	//	val double precioEntrada = 200
		val creditCardService = mock(typeof(CreditCardService))
				 val respuesta0 = mock(typeof(CCResponse))
				 respuesta0.statusMessage="transaccion exitosa"
		when((creditCardService.pay(tarjetaUno, cumple.precioEntrada))).thenReturn(respuesta1)
		cumple.comprarConTarjetaDeCredito(usuario2, tarjetaUno)

	}

	@Test
	def testCompraConTarjetaQueDaRespuestaCodigo0SeVerificaCompraEntrada() {
	//	val TarjetaPagos tarjetaPagos = new TarjetaPagos
	//	val double precioEntrada = 200
		respuesta0 = mock(typeof(CCResponse))
		val tarjetaPagos =mock(typeof(TarjetaPagos))
		println(respuesta0.statusCode)
		when((tarjetaPagos.respuestaTarjeta(tarjetaUno, cumple.precioEntrada))).thenReturn(respuesta0)
		cumple.comprarConTarjetaDeCredito(usuario2, tarjetaUno)
		Assert.assertEquals(1, cumple.entradas.size(), 0)
//		Assert.assertEquals(1, usuario2.entradaComprada.size(), 0)
	}

}
