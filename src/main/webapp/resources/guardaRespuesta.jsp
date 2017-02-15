
<%@page import="java.sql.*"%>
<%@page import="classes.Topik"%>
<%@page import="classes.Funciones"%>
<%-- 
    Document   : guardaTopik
    Created on : 19-may-2016, 22:03:16
    Author     : Usher
--%>
<%
  request.setCharacterEncoding("UTF-8"); 
  int idForaneo = Integer.valueOf(request.getParameter("foraneo"));
  Topik topic = new Topik(
        request.getParameter("contenido"),
        request.getRemoteAddr(),
        request.getParameter("clave")
  );
%>

<% 
  Class.forName("com.mysql.jdbc.Driver");
  Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
  Statement s = conexion.createStatement();
  String insercion = "INSERT INTO respuesta(topic_idTopic, contenidoRespuesta, claveRespuesta, ipRespuesta) VALUES (?,?,?,?);";
// create the mysql insert preparedstatement
      PreparedStatement preparedStmt = conexion.prepareStatement(insercion);
      preparedStmt.setInt (1, idForaneo);
      preparedStmt.setString (2, topic.getContenido());
      preparedStmt.setString (3, topic.getClave());
      preparedStmt.setString (4, topic.getIp());
 
      // execute the preparedstatement
      preparedStmt.execute();  
      conexion.close();
      response.sendRedirect("../topic.jsp?topic="+idForaneo);
%>


