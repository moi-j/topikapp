
<%@ include file="resources/header.jsp" %>
<% Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
        Statement s = conexion.createStatement();
        ResultSet listadoCategoria = s.executeQuery("SELECT * FROM categoria");
        HashMap<Integer, String> categoriaMap = new HashMap<Integer, String>();
        while (listadoCategoria.next()){
          categoriaMap.put(Integer.parseInt(listadoCategoria.getString("idCategoria")), listadoCategoria.getString("nombre"));
        }
        ResultSet listadoTopic = s.executeQuery ("SELECT * FROM topic WHERE idTopic="+ request.getParameter("id"));
        
        Topik topico = new Topik();
        while (listadoTopic.next()) {
          topico.setClave(listadoTopic.getString("clave"));
          topico.setId(listadoTopic.getString("idTopic"));
          topico.setTitulo(listadoTopic.getString("titulo"));
          topico.setContenido(listadoTopic.getString("contenido"));
          topico.setCategoria(listadoTopic.getInt("categoria_idCategoria"));
          topico.setFecha(Funciones.convierteFecha(listadoTopic.getDate("fecha")));
        }
        conexion.close();
    %>
    <div class="container">
        <h1>Edita tu Topik</h1>

      <form method="post" action="resources/modificaTopik.jsp" class="ws-validate">
        <div class="form-group">
          <label for="inputCategoria">Categoría</label>
          <select class="form-control" name="categoria" id="inputCategoria">
          <% for (Map.Entry pareja: categoriaMap.entrySet()) { %>         
            <option value="<%= pareja.getKey() %>" <% 
            if (pareja.getKey().equals(topico.getCategoria())){
              out.print("selected");
            }
              %>
              >
              <%= pareja.getValue() %>
            </option>
            <%  } %>
          </select>
        </div>
        <div class="form-group">
          <label for="inputTitulo" >Título*</label>
          <input type="text" class="form-control" id="inputTitulo" name="titulo" required value="<%= topico.getTitulo() %>">
        </div>
        <div class="form-group">
          <label for="inputContenido" >Contenido*</label>
          <textarea class="form-control" id="inputContenido" name="contenido" rows="10" style="resize:none;" required>
            <%= topico.getContenido() %>
          </textarea>
        </div>
        <div class="form-group">
          <label for="inputClave" required>Clave privada*</label>
          <input type="text" class="form-control" id="inputClave" value="<%= topico.getClave()%>" name="clave" required>
          <p class="help-block"><small>Esta clave te servirá para poder modificar o eliminar tu topik. Guardala o cambiala si lo deseas para que te sea más facil recordarla.</small></p>
        </div>
        <input type="hidden" id="oculto" name="id" value="<%= topico.getId() %>">
        <button type="submit" class="btn btn-default">Enviar</button>
        
      </form>
    </div>
          <script>
            (function () {
    webshim.setOptions('forms', {
        lazyCustomMessages: true,
        iVal: {
            sel: '.ws-validate',
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
<%@ include file="resources/footer.jsp" %>
