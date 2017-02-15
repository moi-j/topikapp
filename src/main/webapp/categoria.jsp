
<%@ include file="resources/header.jsp" %>
  <% Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
        Statement s = conexion.createStatement();
        ResultSet listadoCategoria = s.executeQuery ("SELECT nombre FROM categoria WHERE idCategoria="+ request.getParameter("id")); 
        String categoria="";
        while (listadoCategoria.next()){
          categoria = listadoCategoria.getString("nombre");
        }
        ResultSet listadoTopic = s.executeQuery ("SELECT idTopic, titulo, contenido, fecha FROM topic WHERE categoria_idCategoria="+ request.getParameter("id") + " ORDER BY fecha DESC LIMIT 15"); 
             
        ArrayList<Topik> topic = new ArrayList<Topik>();

        while (listadoTopic.next()) {
          Topik topico = new Topik();
          topico.setId(listadoTopic.getString("idTopic"));
          topico.setTitulo(listadoTopic.getString("titulo"));
          topico.setContenido(listadoTopic.getString("contenido"));
          topico.setFecha(Funciones.convierteFecha(listadoTopic.getDate("fecha")));
          topic.add(topico);
        }
        conexion.close();
        int total = topic.size();
    %>
    <div class="container fluid">
      <div class="page-header">
        <h1>Topiks de <%= categoria %></h1>
      </div>
      <% if (total <= 0){ %>
      <h3><small>Aun no hay Topics sobre <%= categoria %>.</small> <span class="text-success">Puedes ser el primero!</span></h3>
      <% }
      else {
        for (Topik topicAux: topic) {%>
          <a class="text-warning" href='topic.jsp?topic=<%= topicAux.getId() %>'><div class="panel panel-warning">
            <div class="panel-heading"><strong>
              <%= topicAux.getTitulo() %>
              </strong>
              <small class="pull-right"><%= topicAux.getFecha() %></small>
            </div>
            <div class="panel-body">
              <%= topicAux.getContenido() %>
            </div>
        
            </div></a>

        <%}
      }
        %>
          
        </div>     
<%@ include file="resources/footer.jsp" %>
