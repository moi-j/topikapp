
<%@ include file="resources/header.jsp" %>
<script>
  $(function(){

    $('#accion').click(function(){
      $('#myModal').modal('show')
    })

});
</script>
<%
        String clave="";
        
        boolean isSet = (request.getParameter("topic") == null); 
        if(!isSet){ 
          String id= request.getParameter("topic");
          Class.forName("com.mysql.jdbc.Driver");
          Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
          Statement s = conexion.createStatement();
          ResultSet listadoTopic = s.executeQuery ("SELECT * FROM topic t "
                  + " LEFT JOIN categoria c ON t.categoria_idCategoria=c.idCategoria"
                  + " WHERE t.idTopic="
                  + request.getParameter("topic"));  
%>
    <div class="container fluid">
      <div class="page-header">
            
         <% while (listadoTopic.next()) {
           clave = listadoTopic.getString("clave");
         %>
         <h1><%= listadoTopic.getString("titulo") %> <a href="#" id="accion"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
          <a href="categoria.jsp?id=<%= listadoTopic.getString("categoria_idCategoria") %>"><small><span class="label label-default pull-right"><%= listadoTopic.getString("nombre") %></span></small></a>
        </h1>
        <% 
        boolean existeMsg = (request.getParameter("msg") == null); 
        if(!existeMsg){ 
          if (request.getParameter("msg").equals("OK")){ %>
        <div class="alert alert-success" role="alert">Se ha modificado tu topik</div>
        <% }
        if (request.getParameter("msg").equals("False")){ %>
        <div class="alert alert-warning" role="alert">La clave introducida no es correcta, vuelve a intentarlo</div>
        <% }
        }%>
          <h5 class="pull-right"><small>Publicado el día <%= Funciones.convierteFecha(listadoTopic.getDate("fecha")) %></small></h5>
      </div>
          
      <p>
        <%= listadoTopic.getString("contenido") %>
      </p>
      <% } //FIN DE WHILE
         conexion.close();
         
         Class.forName("com.mysql.jdbc.Driver");
          Connection conexionRespuesta = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
          Statement sRespuesta = conexionRespuesta.createStatement();
          ResultSet listadoRespuesta = sRespuesta.executeQuery ("SELECT * FROM respuesta r "
                  + " WHERE r.topic_idTopic="
                  + request.getParameter("topic")
                  +" ORDER BY fechaRespuesta DESC "
          );  
        while (listadoRespuesta.next()) {%>
          <div class="panel panel-warning">
            <div class="panel-body">
              <small><em><%= Funciones.convierteFecha(listadoRespuesta.getDate("fechaRespuesta")) %>:</em></small>
              <%= listadoRespuesta.getString("contenidoRespuesta") %>
            </div>
        
            </div>

        <%}
         conexionRespuesta.close();
        } //FIN DE WHILE
      %>
      <form method="post" action="resources/guardaRespuesta.jsp" class="ws-validate respuesta">

        <div class="form-group">
          <label for="inputContenido">Responder*</label>
          <textarea rows="3" style="resize:none;" type="text" class="form-control" id="inputContenido" placeholder="Escribe tu respuesta" name="contenido" required></textarea>
        </div>
        <div class="form-group">
          <label for="inputClave">Clave privada</label>
          <input type="text" class="form-control" id="inputClave" value="<%out.print(Funciones.clave());%>" name="clave" required>
          <p class="help-block"><small>Esta clave te servirá para poder modificar o eliminar tu respuesta. Guardala o cambiala si lo deseas para que te sea más facil recordarla.</small></p>
        </div>
          <input type="hidden" id="thisField" name="foraneo" value="<%= request.getParameter("topic") %>">
        <button type="submit" class="btn btn-default">Responder</button>
        
      </form>
    </div>
<script>
            (function () {
    webshim.setOptions('forms', {
        lazyCustomMessages: true,
        iVal: {
            sel: '.formularioModal',
            handleBubble: 'hide', // hide error bubble

            //add bootstrap specific classes
            errorMessageClass: 'help-block',
            successWrapperClass: 'has-success',
            errorWrapperClass: 'has-error',

            //add config to find right wrapper
            fieldWrapper: '.form-group'
        }
        
    });

    //load forms polyfill + iVal feature
    webshim.polyfill('forms');
})();

</script>
<!-- Modal -->

<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" id="myModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Elige tu acción</h4>
      </div>
      <div class="modal-body">
        <form action="resources/menuEdicion.jsp" method="post" class="formularioModal" id="formularioModal">
          <div class="form-group">
            <label class="radio-inline">
              <input type="radio" name="opcion" id="inlineRadio1" value="editar"> Editar
            </label>
            <label class="radio-inline">
              <input type="radio" name="opcion" id="inlineRadio2" value="borrar"> Borrar
            </label>
          </div>
          <div class="form-group">
            <label for="inputClave">Clave privada</label>
            <input type="text" class="form-control" id="inputClave" name="clave" placeholder="Indica tu clave privada" required>
          </div>
        </div>
      <div class="modal-footer">
        <input type="hidden" id="oculto" name="id" value="<%= request.getParameter("topic") %>">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-primary">Guardar</button>
      </form>
        </div>
    </div>
  </div>
</div>
<%@ include file="resources/footer.jsp" %>
