package eventos

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import repositorio.RepositorioServicio

@Accessors
class TestJsonServicio {
	RepositorioServicio repoServicios
	String jsonText
	String jsonText2
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
					"tipo":"TPH",
					"valor":5000.00,
					"minimo":3500.00
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
		
		
		
Assert.assertEquals(1, repoServicios.elementos.size(),0)

	}

	@Test
	def void jsondeServicioCon2Elementos() {
				jsonText2 = '''
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
			},
			{
							"descripcion":"Food Party",
							"tarifaServicio":{
								"tipo":"TPP",
								"valor":5000.00,
								"porcentajeParaMinimo":70.00
							},
							"tarifaTraslado":30.00,
							"ubicacion":{
								"x":-34.572224,
								"y":58.535651
							}
						}
		]
		'''
		repoServicios.actualizarServicios(jsonText2)
		
		
		
Assert.assertEquals(2, repoServicios.elementos.size(),0)

	}
		@Test
	def void jsondeServicioCon2ElementosDeIgualDescripcion() {
				jsonText2 = '''
		[
			{
				"descripcion":"Food Party",
				"tarifaServicio":{
					"tipo":"TF",
					"valor":3000.00
				},
				"tarifaTraslado":30.00,
				"ubicacion":{
					"x":-34.572224,
					"y":58.535651
				}
			},
			{
					"descripcion":"Food Party",
							"tarifaServicio":{
								"tipo":"TPP",
								"valor":5000.00,
								"porcentajeParaMinimo":70.00
							},
							"tarifaTraslado":30.00,
							"ubicacion":{
								"x":-34.572224,
								"y":58.535651
							}
						}
		]
		'''
		repoServicios.actualizarServicios(jsonText2)
		
		
		
Assert.assertEquals(1, repoServicios.elementos.size(),0)
Assert.assertEquals(5000.00, repoServicios.searchById(1).costoPorPersona,0)
Assert.assertEquals(0.00, repoServicios.searchById(1).costoFijo,0)

	}
}
