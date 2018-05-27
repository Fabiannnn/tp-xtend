package testsJsons

import static org.mockito.Mockito.*

class pruebamock {

 @Test
 public void testLegacyCode(){
 // Creamos un mock para LegacyCode usando Mockito
 LegacyCode mockLegacyCode = mock(LegacyCode.class);
 // Le indicamos lo que debe devolver en este test en concreto
 when(mockLegacyCode.getAnotherMessage()).thenReturn("Lo que diga el mock");
// Instanciamos y comprobamos el mensaje devuelto
 MyClass myClass = new MyClass();
 System.out.println(myClass.methodToTestNotStatic(mockLegacyCode));
 verify(mockLegacyCode, times(1)).getAnotherMessage();
 }
 }}