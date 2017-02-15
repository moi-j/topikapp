
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
  String id = request.getParameter("id");
  String clave = request.getParameter("clave");
  Boolean claveCorrecta = false;
  
   Class.forName("com.mysql.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://"+Funciones.dbAddress()+":3306/topik","root", "");
        Statement s = conexion.createStatement(); %>
        <% ResultSet listadoTopic = s.executeQuery ("SELECT * FROM topic WHERE idTopic= " + id );
        
        while (listadoTopic.next()) {
          if (clave.equals(listadoTopic.getString("clave"))){
            claveCorrecta = true;
          }
        }
        if (claveCorrecta){
          
          if (request.getParameter("opcion").equals("editar")){
            conexion.close();
            response.sendRedirect("../edit.jsp?id=" + id);
          }
          
          if (request.getParameter("opcion").equals("borrar")){
            s.execute ("DELETE FROM respuesta WHERE topic_idTopic=" + id);
            s.execute ("DELETE FROM topic WHERE idTopic=" + id);
            conexion.close();
            response.sendRedirect("../index.jsp?msg=OK");
          }
          
        }
        if (!claveCorrecta){
          conexion.close();
          response.sendRedirect("../topic.jsp?topic="+request.getParameter("id")+"&msg=False");
        }
    %>
