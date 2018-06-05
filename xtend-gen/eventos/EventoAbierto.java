package eventos;

import eventos.Entrada;
import eventos.Evento;
import eventos.TarjetaPagos;
import eventos.Usuario;

/* @Accessors
 */public class EventoAbierto extends Evento {
  private int edadMinima;
  
  private double precioEntrada;
  
  private /* Set<Entrada> */Object entradas /* Skipped initializer because of errors */;
  
  public void comprarEntrada(final Usuario elComprador) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method generarEntrada(Usuario) from the type EventoAbierto refers to the missing type Object");
  }
  
  public void puedeComprarEntrada(final Usuario elComprador) {
    throw new Error("Unresolved compilation problems:"
      + "\n! cannot be resolved."
      + "\nThe method edadValida(Usuario) from the type EventoAbierto refers to the missing type Object"
      + "\nThe method fechaAnteriorALaLimite() from the type EventoAbierto refers to the missing type Object"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\n! cannot be resolved"
      + "\n|| cannot be resolved"
      + "\n! cannot be resolved"
      + "\n|| cannot be resolved");
  }
  
  public Object edadValida(final Usuario elComprador) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method edad() from the type Usuario refers to the missing type Object"
      + "\n> cannot be resolved");
  }
  
  public void comprarConTarjetaDeCredito(final Usuario elComprador, final /* CreditCard */Object tarjetaCredito, final TarjetaPagos tarjetaPagos) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method pagarEntrada(CreditCard, double) from the type TarjetaPagos refers to the missing type CreditCard"
      + "\nThe method generarEntrada(Usuario) from the type EventoAbierto refers to the missing type Object");
  }
  
  public void comprarConLaTarjetaDeCredito(final Usuario elComprador, final /* CreditCard */Object tarjetaCredito, final TarjetaPagos tarjetaPagos) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method pagarLaEntrada(CreditCard, double) from the type TarjetaPagos refers to the missing type CreditCard"
      + "\nThe method generarEntrada(Usuario) from the type EventoAbierto refers to the missing type Object");
  }
  
  public Object generarEntrada(final Usuario elComprador) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method registrarCompraEnEvento(Entrada) from the type EventoAbierto refers to the missing type Object"
      + "\nThe method registrarCompraEnUsuario(Entrada, Usuario) from the type EventoAbierto refers to the missing type Object");
  }
  
  public Object registrarCompraEnEvento(final Entrada nuevaEntrada) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nadd cannot be resolved");
  }
  
  public Object registrarCompraEnUsuario(final Entrada nuevaEntrada, final Usuario elComprador) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field entradaComprada is not visible"
      + "\nThe field Usuario.entradaComprada refers to the missing type // paraInvitaciones cancelaciones postergaciones\n\tSet"
      + "\nadd cannot be resolved");
  }
  
  public void cancelarElEvento() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field cancelado is not visible"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nforEach cannot be resolved"
      + "\ncancelacionDeEvento cannot be resolved");
  }
  
  public void postergarElEvento(final /* LocalDateTime */Object nuevaFechaHoraInicio) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field fechaDeInicio is not visible"
      + "\nThe field fechaFinalizacion is not visible"
      + "\nThe field fechaLimiteConfirmacion is not visible"
      + "\nThe method postergarElEvento(LocalDateTime) from the type Evento refers to the missing type LocalDateTime"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nThe field Evento.fechaDeInicio refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaFinalizacion refers to the missing type LocalDateTime"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nforall cannot be resolved"
      + "\nmensajesPorPostergacion cannot be resolved");
  }
  
  public int capacidadMaxima() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field locacion is not visible");
  }
  
  public boolean hayEntradasDisponibles() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nsize cannot be resolved"
      + "\n< cannot be resolved");
  }
  
  public Object fechaAnteriorALaLimite() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field LocalDate is undefined"
      + "\nThe method or field LocalDate is undefined"
      + "\nThe field fechaLimiteConfirmacion is not visible"
      + "\nThe field Evento.fechaLimiteConfirmacion refers to the missing type LocalDate"
      + "\nnow cannot be resolved"
      + "\n<= cannot be resolved"
      + "\nfrom cannot be resolved");
  }
  
  public boolean esExitoso() {
    throw new Error("Unresolved compilation problems:"
      + "\n! cannot be resolved."
      + "\n! cannot be resolved."
      + "\n! cannot be resolved."
      + "\n! cannot be resolved."
      + "\nThe field cancelado is not visible"
      + "\nThe field postergado is not visible"
      + "\nThe field cancelado is not visible"
      + "\nThe field postergado is not visible"
      + "\nThe method ventaExitosa() from the type EventoAbierto refers to the missing type Object"
      + "\nThe method ventaExitosa() from the type EventoAbierto refers to the missing type Object"
      + "\n&& cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n&& cannot be resolved");
  }
  
  public Object ventaExitosa() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\nvigente cannot be resolved"
      + "\n=== cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n/ cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n>= cannot be resolved");
  }
  
  public boolean esUnFracaso() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\nvigente cannot be resolved"
      + "\n=== cannot be resolved"
      + "\nsize cannot be resolved"
      + "\n/ cannot be resolved"
      + "\n< cannot be resolved");
  }
  
  public int cantidadAsistentes() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field EventoAbierto.entradas refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\nvigente cannot be resolved"
      + "\n=== cannot be resolved"
      + "\nsize cannot be resolved");
  }
}
