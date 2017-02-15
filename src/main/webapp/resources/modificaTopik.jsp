
<%@page import="java.sql.*"%>
<%@page import="classes.Topik"%>
<%@page import="classes.Funciones"%>

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
  String insercion = "UPDATE topic SET categoria_idCategoria=?, titulo=?, contenido=?, clave=?, ip=?  WHERE idTopic=" + request.getParameter("id");
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
      response.sendRedirect("../topic.jsp?topic="+request.getParameter("id")+"&msg=OK");
%>
