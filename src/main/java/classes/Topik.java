package classes;


public class Topik {
  private String id;
  private int categoria_idCategoria;
  private String titulo;
  private String contenido;
  private String clave;
  private String ip;
  private String fecha;
  private int visitas;
  private int respuestas;

  public Topik(){
    
  }
  public Topik(int categoria, String titulo, String contenido, String ip, String clave){
    this.categoria_idCategoria = categoria;
    this.titulo = titulo;
    this.contenido = contenido;
    this.ip = ip;
    this.clave = clave;
  }
  public Topik(String contenido, String ip, String clave){
    this.contenido = contenido;
    this.ip = ip;
    this.clave = clave;
  }
  public Topik(String id, String titulo, String contenido, String fecha){
    this.id = id;
    this.titulo = titulo;
    this.contenido = contenido;
    this.fecha = fecha;
  }
  
  public int getCategoria(){
    return categoria_idCategoria;
  }
  public String getTitulo(){
    return titulo;
  }
  public String getContenido(){
    return contenido;
  }
  public String getId(){
    return id;
  }
  public String getFecha(){
    return fecha;
  }
  public String getClave(){
    return clave;
  }
  public String getIp(){
    return ip;
  }
  public int getVisitas(){
    return visitas;
  }
  public int getRespuestas(){
    return respuestas;
  }
  
  
  public void setId(String id){
    this.id = id;
  }
  public void setCategoria(int categoria){
    this.categoria_idCategoria = categoria;
  }
  public void setFecha(String fecha){
    this.fecha = fecha;
  }
  public void setTitulo(String nuevoTitulo){
    this.titulo = nuevoTitulo;
  }
  public void setContenido(String nuevoContenido){
    this.contenido = nuevoContenido;
  }
  public void setClave(String nuevaClave){
    this.clave = nuevaClave;
  }
  public void setVisitas(){
    this.visitas = visitas+1;
  }
  public void setRespuestas(int respuestas){
    this.respuestas = respuestas;
  }
}