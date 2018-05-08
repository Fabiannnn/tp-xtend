package eventos
import org.junit.Test
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Before
import org.junit.Assert

@Accessors
class TestJsonServicio {
	RepositorioServicio repoServicios
	String jsonText

	@Before
	def void init() {
		repoServicios = new RepositorioServicio()
	}

	@Test
	def void jsondeServicio() {
		jsonText = '''
		[
			{
				"descripcion":"Catering Food Party",
				"tarifaServicio":{
					"tipo":"TF",
					"valor":5000.00
				},
				"tarifaTraslado":30.00,
				"ubicacion":{
					"x":-34.572224,
					"y":58.535651
				}
			}
		]
		'''
		repoServicios.actualizarServicios(jsonText)
	Assert.assertEquals("Catering Food Party", repoServicios.searchById(1).descripcion)
	}
//	
//	@Test
//	def void seAgrega2SalonesValidosySeActualizaConJsonYSeotroJsonModificado() {
//		jsonText = '''[{"x":-34.603759,"y":-58.381586, "nombre":"Salón El Abierto"},{ "x":-34.572224,"y":-58.535651, "nombre":"Estadio Obras" }]'''
//		repoLocacion.actualizarLocacion(jsonText)
//		jsonText = '''[{"x":-34.603759,"y":-58.388986, "nombre":"Salón El Abierto Otro Lugar"},{ "x":-34.572224,"y":-58.535651, "nombre":"Estadio Obras Modificado" }]'''
//		repoLocacion.actualizarLocacion(jsonText)
//	Assert.assertEquals("Estadio Obras Modificado", repoLocacion.searchById(2).nombre)
//	Assert.assertEquals(3, repoLocacion.elementos.size(),0)
//	}
}
