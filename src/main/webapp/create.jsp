<%@ include file="resources/header.jsp" %>
    <div class="container">
        <h1>Crea un topik y espera la respuesta</h1>

      <form method="post" action="resources/guardaTopik.jsp" class="ws-validate">
        <div class="form-group">
          <label for="inputCategoria">Categoría</label>
          <select class="form-control" name="categoria" id="inputCategoria">
                    <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
            Statement s = conexion.createStatement();
            ResultSet listado = s.executeQuery ("SELECT * FROM categoria");
            while (listado.next()) { %>
            
            <option value="<%= listado.getString("idCategoria") %>">
              <%= listado.getString("nombre") %>
            </option>
            <%  }
              conexion.close();
            %>
          </select>
        </div>
        <div class="form-group">
          <label for="inputTitulo" >Título*</label>
          <input type="text" class="form-control" id="inputTitulo" placeholder="Tu titulo" name="titulo" required>
        </div>
        <div class="form-group">
          <label for="inputContenido" >Contenido*</label>
          <textarea class="form-control" id="inputContenido" placeholder="El contenido de tu topik" name="contenido" rows="10" style="resize:none;" required></textarea>
        </div>
        <div class="form-group">
          <label for="inputClave" required>Clave privada*</label>
          <input type="text" class="form-control" id="inputClave" value="<%out.print(Funciones.clave());%>" name="clave" required>
          <p class="help-block"><small>Esta clave te servirá para poder modificar o eliminar tu topik. Guardala o cambiala si lo deseas para que te sea más facil recordarla.</small></p>
        </div>
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
