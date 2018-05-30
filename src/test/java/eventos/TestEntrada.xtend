package eventos

import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test
import excepciones.EventoException
import java.time.LocalDate
import java.time.Period

@Accessors
class TestEntrada extends FixtureTest{
	// Test De Compra Entradas Evento Abierto
	@Test
	def void usuario2CompraEntradaEventoAbierto() {
		cumple.comprarEntrada(usuario2)
		Assert.assertEquals(1, cumple.entradas.size(), 0)
		Assert.assertEquals(1, usuario2.entradaComprada.size(), 0)
	}

	@Test(expected=EventoException)
	def void usuario2CompraEntradaEventoAbiertoSeCambiaLimiteFechaParaNoValide() {
		cumple.fechaLimiteConfirmacion = LocalDate.now().plus(Period.ofDays(-7))
		cumple.comprarEntrada(usuario2)
	}
	@Test(expected=EventoException)
	def void usuario2CompraEntradaEventoAbiertoSeCambiaSuperficieParaQueNoValide() {
		salon_SM.superficie=0
		cumple.comprarEntrada(usuario2)
	}
	
	@Test(expected=EventoException)
	def void usuario1CompraEntradaEventoAbiertoNoValidaPorEdad() {
		cumple.comprarEntrada(usuario1)
	}

	@Test
	def void usuario1CompraEntradaEventoAbiertoSeBajaLimiteDeEdadYValida() {
		cumple.edadMinima = 10
		cumple.comprarEntrada(usuario1)
		Assert.assertEquals(1, cumple.entradas.size(), 0)
		Assert.assertEquals(1, usuario1.entradaComprada.size(), 0)

	}
//test devolucion entradas
	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPorcentajeDevolucionIgualA80() {
		Assert.assertEquals(80.0, entradaPrueba.porcentajeDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteIgual160() {
		Assert.assertEquals(160.0, entradaPrueba.getImporteDevolucion(), 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoPImporteDevuel80() {
		entradaPrueba.devolucionEntrada()
		Assert.assertEquals(160.0, usuario1.saldoCuenta , 0)
	}

	@Test
	def void devolverEntradaConMuchosDiasAnticipacionChequeoVigenteFalso() {
		entradaPrueba.devolucionEntrada()
		Assert.assertFalse(entradaPrueba.vigente)
	}

	@Test
	def void devolverEntradaSinAnticipacionNoDebeDevolverDinero() {
		cumple.fechaDeInicio = LocalDateTime.now()
		Assert.assertEquals(0.0, entradaPrueba.getImporteDevolucion(), 0)
	}

}
