
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
  
  Topik topic = new Topik(
        Integer.valueOf(request.getParameter("categoria")),
        request.getParameter("titulo"),
        request.getParameter("contenido"),
        request.getRemoteAddr(),
        request.getParameter("clave")
  );
%>

<% 
  Class.forName("com.mysql.jdbc.Driver");
  Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
  Statement s = conexion.createStatement();
  String insercion = "INSERT INTO topic(categoria_idCategoria, titulo, contenido, clave, ip) VALUES (?,?,?,?,?);";
// create the mysql insert preparedstatement
      PreparedStatement preparedStmt = conexion.prepareStatement(insercion);
      preparedStmt.setInt (1, Integer.valueOf(topic.getCategoria()));
      preparedStmt.setString (2, topic.getTitulo());
      preparedStmt.setString (3, topic.getContenido());
      preparedStmt.setString (4, topic.getClave());
      preparedStmt.setString (5, topic.getIp());
 
      // execute the preparedstatement
      preparedStmt.execute();  
      conexion.close();
      response.sendRedirect("../index.jsp?msg=1");
%>

