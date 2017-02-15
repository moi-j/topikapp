

<%@ include file="resources/header.jsp" %>
  <% Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
        Statement s = conexion.createStatement();
        ResultSet listadoCategoria = s.executeQuery("SELECT * FROM categoria");
        HashMap<Integer, String> categoriaMap = new HashMap<Integer, String>();
        while (listadoCategoria.next()){
          categoriaMap.put(Integer.parseInt(listadoCategoria.getString("idCategoria")), listadoCategoria.getString("nombre"));
        }
        
        ResultSet listadoRespuesta = s.executeQuery("SELECT * FROM respuesta");
        HashMap<Integer, Integer> respuestaMap = new HashMap<Integer, Integer>();
        while (listadoRespuesta.next()){
          if(respuestaMap.containsKey(Integer.parseInt(listadoRespuesta.getString("topic_idTopic")))){
            int valor= respuestaMap.get(Integer.parseInt(listadoRespuesta.getString("topic_idTopic")));
            respuestaMap.put(Integer.parseInt(listadoRespuesta.getString("topic_idTopic")), valor+1);
          }
          else{
            respuestaMap.put(Integer.parseInt(listadoRespuesta.getString("topic_idTopic")),1);
          }
        }
        ResultSet listadoTopic = s.executeQuery ("SELECT idTopic, categoria_idCategoria, titulo, SUBSTRING(contenido, 1, 100) contenidoRecortado, fecha FROM topic ORDER BY fecha DESC LIMIT 15");
        ArrayList<Topik> topic = new ArrayList<Topik>();
        while (listadoTopic.next()) {
          Topik topico = new Topik();
          topico.setId(listadoTopic.getString("idTopic"));
          topico.setTitulo(listadoTopic.getString("titulo"));
          topico.setContenido(listadoTopic.getString("contenidoRecortado"));
          topico.setCategoria(listadoTopic.getInt("categoria_idCategoria"));
          topico.setFecha(Funciones.convierteFecha(listadoTopic.getDate("fecha")));
          topic.add(topico);
        }
        conexion.close();
    %>
    <div class="container fluid">
      <div class="page-header">
        <h1>New Topiks <small>Preguntas más recientes</small></h1>
        <% 
        boolean isSet = (request.getParameter("msg") == null); 
        if(!isSet){ 
          if (request.getParameter("msg").equals("1")){ %>
        <div class="alert alert-success" role="alert"><strong>Enhorabuena!</strong> Se ha publicado tu Topik</div>
        <% } if (request.getParameter("msg").equals("OK")){ %>
        <div class="alert alert-success" role="alert"><strong>Enhorabuena!</strong> Se ha eliminado tu Topik</div>
         <% }
        }%>
      </div>
      <% for (Topik topicAux: topic) {%>
          <a class="text-warning" href='topic.jsp?topic=<%= topicAux.getId() %>'><div class="panel panel-warning">
            <div class="panel-heading"><strong>
              <%= topicAux.getTitulo() %>
              </strong>
              <span class="label label-danger"><%= categoriaMap.get(topicAux.getCategoria()) %></span>
              <small class="pull-right"><%= topicAux.getFecha() %></small>
            </div>
            <div class="panel-body">
              <%= topicAux.getContenido() %>...
              <% 
              Boolean existeRespuesta = respuestaMap.containsKey(Integer.parseInt(topicAux.getId()));
              if (existeRespuesta){ %>
              
                 <small class="pull-right"><%= "Respuestas: "+ respuestaMap.get(Integer.parseInt(topicAux.getId()))%></small>
                 
              <% }
              else { %>
                  
                  <small class="pull-right">Aún no hay respuestas a esta pregunta</small>

              <% }   %>
             
            </div>
        
            </div></a>

        <%}%>
          
        </div>     
<%@ include file="resources/footer.jsp" %>