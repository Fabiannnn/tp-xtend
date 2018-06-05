package eventos;

import eventos.FixtureTest;

/* @Accessors
 */public class TestValidacionEventosCerrados extends FixtureTest {
  /* @Test
   */public void unEventoCerradoCompletoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field Assert is undefined"
      + "\n== cannot be resolved."
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field organizador is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe method organizarEventoCerrado(EventoCerrado) from the type Usuario refers to the missing type Object"
      + "\nassertTrue cannot be resolved");
  }
  
  /* @Test()
   */public void unEventoCerradoSinNombreNoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field nombre is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field Evento.nombre refers to the missing type String"
      + "\nThe method organizarEventoCerrado(EventoCerrado) from the type Usuario refers to the missing type Object");
  }
  
  /* @Test()
   */public void unEventoAbiertoSinLocacionNoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field reunionAbierta is not visible"
      + "\nThe field locacion is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionAbierta is not visible"
      + "\nThe method organizarEventoAbierto(EventoAbierto) from the type Usuario refers to the missing type Object");
  }
  
  /* @Test()
   */public void unEventoAbiertoSinFechaDeInicioNoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field fechaDeInicio is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe method organizarEventoCerrado(EventoCerrado) from the type Usuario refers to the missing type Object");
  }
  
  /* @Test()
   */public void unEventoAbiertoSinFechaDeFinalizacionNoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe method organizarEventoCerrado(EventoCerrado) from the type Usuario refers to the missing type Object");
  }
  
  /* @Test()
   */public void unEventoAbiertoSinFechaDeConfirmacionNoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field fechaLimiteConfirmacion is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nThe method organizarEventoCerrado(EventoCerrado) from the type Usuario refers to the missing type Object");
  }
  
  /* @Test()
   */public void unEventoAbiertoFinalizacionAnteriorAInicioNoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field LocalDateTime is undefined"
      + "\nThe method or field Period is undefined"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe method organizarEventoCerrado(EventoCerrado) from the type Usuario refers to the missing type Object"
      + "\nnow cannot be resolved"
      + "\nplus cannot be resolved"
      + "\nofDays cannot be resolved");
  }
  
  /* @Test()
   */public void unEventoAbiertoLimiteConfirmacionMayorAInicioNoSeValidaSuOrganizacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field LocalDateTime is undefined"
      + "\nThe method or field Period is undefined"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field fechaDeInicio is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field usuario1 is not visible"
      + "\nThe field reunionGrande is not visible"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe method organizarEventoCerrado(EventoCerrado) from the type Usuario refers to the missing type Object"
      + "\nnow cannot be resolved"
      + "\nplus cannot be resolved"
      + "\nofDays cannot be resolved");
  }
}
