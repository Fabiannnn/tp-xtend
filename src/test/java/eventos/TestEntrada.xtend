package eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.uqbar.geodds.Point
import java.time.LocalDate
import org.junit.Before
import org.junit.Test
import java.time.Period

class TestEntrada {
	EventoAbierto cumple
	Locacion salon_SM
	Usuario usuario1
	Entrada entradaPrueba

	@Before
	def void init() {
		salon_SM = new Locacion=>[
			nombreLugar = "San Martin"
			punto = new Point(35, 45)
			superficie = 16
		]
		usuario1 = new Usuario=>[
			nombreDeUsuario = "Organizador1"
			fechaDeNacimiento = LocalDate.of(2002, 05, 15)
			coordenadasDireccion = new Point(40, 50)
		]
			
		cumple = new EventoAbierto =>[ 
			organizador = usuario1
			locacion = salon_SM
			fechaDeInicio = LocalDateTime.now().plus(Period.ofDays(25))
			fechaFinalizacion = LocalDateTime.now().plus(Period.ofDays(26))
			fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(7))	
			edadMinima = 17
			precioEntrada = 100
		]

		entradaPrueba = new Entrada(cumple, usuario1)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPorcentajeDevolucionIgualA80() {
		Assert.assertEquals(80.0, entradaPrueba.porcentajeDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteIgual80() {
		Assert.assertEquals(80.0, entradaPrueba.determinacionImporteDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteDevuel80() {
		entradaPrueba.devolucionEntrada()
		Assert.assertEquals(80.0, usuario1.saldoCuenta , 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoVigenteFalso() {
		entradaPrueba.devolucionEntrada()
		Assert.assertFalse(entradaPrueba.vigente)
	}

	@Test
	def void devolverEntradaSinAnticipacionNoDebeDevolverDinero() {
		cumple.fechaDeInicio = LocalDateTime.now()
		Assert.assertEquals(0.0, entradaPrueba.determinacionImporteDevolucion(), 0)
	}

}
