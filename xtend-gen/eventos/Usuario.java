package eventos;

import eventos.Entidad;
import eventos.Entrada;
import eventos.Evento;
import eventos.EventoAbierto;
import eventos.EventoCerrado;
import eventos.Invitacion;
import eventos.TipoDeUsuario;
import eventos.UsuarioAmateur;
import eventos.UsuarioFree;
import eventos.UsuarioProfesional;

/* @Accessors
 */public class Usuario implements Entidad {
  private /* String */Object nombreUsuario;
  
  private /* String */Object nombreApellido;
  
  private /* String */Object email;
  
  private /* LocalDate */Object fechaNacimiento;
  
  private /* Point */Object coordenadas;
  
  private boolean esAntisocial;
  
  private /* Set<Usuario> */Object amigos /* Skipped initializer because of errors */;
  
  private double radioDeCercania;
  
  private double saldoCuenta = 0.0;
  
  private /* Set<Invitacion> */Object invitaciones /* Skipped initializer because of errors */;
  
  private /* Set<String> */Object notificaciones /* Skipped initializer because of errors */;
  
  private /* Set<Entrada> */Object entradaComprada /* Skipped initializer because of errors */;
  
  private TipoDeUsuario tipoDeUsuario;
  
  private /* Set<Evento> */Object eventosOrganizados /* Skipped initializer because of errors */;
  
  private int id;
  
  public Object recibirInvitacion(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field unEventoCerrado is not visible"
      + "\nThe field cantidadDeAcompanantes is not visible"
      + "\nThe field Usuario.invitaciones refers to the missing type // esto se agrego segun issue 8 entrega 1\n\tSet"
      + "\nThe method agregarMensaje(String) from the type Usuario refers to the missing type Object"
      + "\nadd cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved"
      + "\n+ cannot be resolved");
  }
  
  public Object agregarMensaje(final /* String */Object string) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.notificaciones refers to the missing type Set"
      + "\nadd cannot be resolved");
  }
  
  public Boolean rechazarInvitacion(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method equals(Usuario) is undefined"
      + "\nThe field unUsuario is not visible"
      + "\nThe method rechazar() from the type Invitacion refers to the missing type Boolean"
      + "\n&& cannot be resolved");
  }
  
  public int aceptarInvitacion(final Invitacion invitacion, final int cantidadAcompanantes) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method equals(Usuario) is undefined"
      + "\n>= cannot be resolved."
      + "\nThe field unUsuario is not visible"
      + "\nThe field cantidadDeAcompanantes is not visible"
      + "\n&& cannot be resolved"
      + "\n&& cannot be resolved");
  }
  
  public void invitarAUnEventoCerrado(final EventoCerrado unEventoCerrado, final Usuario elInvitado, final int unaCantidadDeAcompanantes) {
    boolean _sePuedeEntregarInvitacion = this.tipoDeUsuario.sePuedeEntregarInvitacion(unEventoCerrado);
    if (_sePuedeEntregarInvitacion) {
      unEventoCerrado.crearInvitacion(elInvitado, unaCantidadDeAcompanantes);
    }
  }
  
  public Object edad() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method or field Period is undefined"
      + "\nThe method or field LocalDate is undefined"
      + "\nThe field Usuario.fechaNacimiento refers to the missing type LocalDate"
      + "\nbetween cannot be resolved"
      + "\nnow cannot be resolved"
      + "\ngetYears cannot be resolved");
  }
  
  public void comprarEntradaAUnEventoAbierto(final EventoAbierto unEventoAbierto) {
    unEventoAbierto.comprarEntrada(this);
  }
  
  public double devolverEntrada(final Entrada entrada) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field unEventoAbierto is not visible"
      + "\nThe method fechaAnteriorALaLimite() from the type EventoAbierto refers to the missing type Object");
  }
  
  public Object organizarEventoAbierto(final EventoAbierto unEventoAbierto) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field organizador is not visible"
      + "\nThe field Usuario.eventosOrganizados refers to the missing type Set"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nadd cannot be resolved");
  }
  
  public Object agregarAmigoALaLista(final Usuario unAmigo) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.amigos refers to the missing type Set"
      + "\nadd cannot be resolved");
  }
  
  public Object organizarEventoCerrado(final EventoCerrado unEventoCerrado) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field organizador is not visible"
      + "\nThe field Usuario.eventosOrganizados refers to the missing type Set"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nadd cannot be resolved");
  }
  
  public void cancelarUnEvento(final Evento unEvento) {
    boolean _puedeCancelarEventos = this.tipoDeUsuario.puedeCancelarEventos();
    if (_puedeCancelarEventos) {
      unEvento.cancelarElEvento();
    }
  }
  
  public void postergarUnEvento(final Evento unEvento, final /* LocalDateTime */Object nuevaFechaHoraInicio) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method postergarElEvento(LocalDateTime) from the type Evento refers to the missing type LocalDateTime");
  }
  
  public Object aceptacionMasiva() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.invitaciones refers to the missing type // esto se agrego segun issue 8 entrega 1\n\tSet"
      + "\nforEach cannot be resolved");
  }
  
  public int noEstaAceptada(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field aceptada is not visible"
      + "\nThe field Invitacion.aceptada refers to the missing type Boolean"
      + "\n=== cannot be resolved");
  }
  
  public int aceptarSiCorresponde(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field cantidadDeAcompanantes is not visible"
      + "\nThe method elOrganizadorEsAmigo(Invitacion) from the type Usuario refers to the missing type Object"
      + "\nThe method esDentroDelRadioDeCercania(Invitacion) from the type Usuario refers to the missing type Object"
      + "\nThe method asistenMasAmigos(Invitacion, int) from the type Usuario refers to the missing type Object"
      + "\n|| cannot be resolved"
      + "\n|| cannot be resolved");
  }
  
  public Object elOrganizadorEsAmigo(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field unEventoCerrado is not visible"
      + "\nThe field organizador is not visible"
      + "\nThe field Usuario.amigos refers to the missing type Set"
      + "\ncontains cannot be resolved");
  }
  
  public Object asistenMasAmigos(final Invitacion invitacion, final int cantidadAmigosParaComparar) {
    throw new Error("Unresolved compilation problems:"
      + "\n> cannot be resolved.");
  }
  
  public int cantidadDeAmigosInvitados(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field unEventoCerrado is not visible"
      + "\nThe field invitados is not visible"
      + "\nThe field Usuario.amigos refers to the missing type Set"
      + "\nThe field EventoCerrado.invitados refers to the missing type Set"
      + "\nfilter cannot be resolved"
      + "\ncontains cannot be resolved"
      + "\nsize cannot be resolved");
  }
  
  public Object esDentroDelRadioDeCercania(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method estaDentroDelRadioDeCercania(Point, double) from the type Locacion refers to the missing type Object"
      + "\nThe field Usuario.coordenadas refers to the missing type Point");
  }
  
  public Object rechazoMasivo() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.invitaciones refers to the missing type // esto se agrego segun issue 8 entrega 1\n\tSet"
      + "\nThe method voyARechazarla(Invitacion) from the type Usuario refers to the missing type Boolean"
      + "\nforEach cannot be resolved"
      + "\naceptada cannot be resolved"
      + "\n=== cannot be resolved");
  }
  
  public Boolean voyARechazarla(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method antisocialRechazaInvitacion(Invitacion) from the type Usuario refers to the missing type Boolean"
      + "\nThe method noAntisocialRechazaInvitacion(Invitacion) from the type Usuario refers to the missing type Boolean");
  }
  
  public Boolean antisocialRechazaInvitacion(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method esDentroDelRadioDeCercania(Invitacion) from the type Usuario refers to the missing type Object"
      + "\nThe method elOrganizadorEsAmigo(Invitacion) from the type Usuario refers to the missing type Object"
      + "\nThe method asistenMasAmigos(Invitacion, int) from the type Usuario refers to the missing type Object"
      + "\nThe method rechazar() from the type Invitacion refers to the missing type Boolean"
      + "\n=== cannot be resolved"
      + "\n|| cannot be resolved"
      + "\n=== cannot be resolved"
      + "\n&& cannot be resolved");
  }
  
  public Boolean noAntisocialRechazaInvitacion(final Invitacion invitacion) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe method esDentroDelRadioDeCercania(Invitacion) from the type Usuario refers to the missing type Object"
      + "\nThe method asistenMasAmigos(Invitacion, int) from the type Usuario refers to the missing type Object"
      + "\nThe method elOrganizadorEsAmigo(Invitacion) from the type Usuario refers to the missing type Object"
      + "\nThe method rechazar() from the type Invitacion refers to the missing type Boolean"
      + "\n=== cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n! cannot be resolved"
      + "\n&& cannot be resolved"
      + "\n=== cannot be resolved");
  }
  
  public void setUsuarioFree() {
    UsuarioFree _usuarioFree = new UsuarioFree();
    this.tipoDeUsuario = _usuarioFree;
  }
  
  public void setUsuarioAmateur() {
    UsuarioAmateur _usuarioAmateur = new UsuarioAmateur();
    this.tipoDeUsuario = _usuarioAmateur;
  }
  
  public void setUsuarioProfesional() {
    UsuarioProfesional _usuarioProfesional = new UsuarioProfesional();
    this.tipoDeUsuario = _usuarioProfesional;
  }
  
  public void esValido() {
    this.validarNombreUsuario();
    this.validarNombreApellido();
    this.validarEMail();
    this.validarFechaNacimiento();
    this.validarUbicacion();
  }
  
  public void validarUbicacion() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.coordenadas refers to the missing type Point"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\n=== cannot be resolved");
  }
  
  public void validarFechaNacimiento() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.fechaNacimiento refers to the missing type LocalDate"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\n=== cannot be resolved");
  }
  
  public void validarEMail() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.email refers to the missing type String"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nnullOrEmpty cannot be resolved");
  }
  
  public void validarNombreApellido() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.nombreApellido refers to the missing type String"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nnullOrEmpty cannot be resolved");
  }
  
  public void validarNombreUsuario() {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.nombreUsuario refers to the missing type String"
      + "\nThe constructor EventoException(String) refers to the missing type String"
      + "\nnullOrEmpty cannot be resolved");
  }
  
  public int getId() {
    return this.id;
  }
  
  public void agregarId(final int _nextId) {
    this.id = _nextId;
  }
  
  public boolean filtroPorTexto(final /* String */Object cadena) {
    throw new Error("Unresolved compilation problems:"
      + "\nThe field Usuario.nombreApellido refers to the missing type String"
      + "\nThe field Usuario.nombreUsuario refers to the missing type String"
      + "\ncontains cannot be resolved"
      + "\n|| cannot be resolved"
      + "\ncontentEquals cannot be resolved");
  }
}
