<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="edu.ulatina.model.Usuario"%>
<%@page import="edu.ulatina.controller.UsuarioController"%>
<%@page import="java.util.List"%>

<%
    
    UsuarioController controller = new UsuarioController();
    List<Usuario> usuarios = controller.listarTodos();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Pastoral Social</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background: #f5f5f5;
        }
        .header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .content {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #667eea;
            color: white;
        }
        .logout-btn {
            background: #e74c3c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
    </style>
</head>
<body>
    
    
    <div class="content">
        <h2>Usuarios del Sistema</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Nombre Completo</th>
                    <th>Rol</th>
                    <th>Email</th>
                    <th>Activo</th>
                </tr>
            </thead>
            <tbody>
                <% for (Usuario u : usuarios) { %>
                    <tr>
                        <td><%= u.getIdUsuario() %></td>
                        <td><%= u.getNombreUsuario() %></td>
                        <td><%= u.getNombreCompleto() %></td>
                        <td><%= u.getRol() %></td>
                        <td><%= u.getEmail() != null ? u.getEmail() : "N/A" %></td>
                        <td><%= u.getActivo() ? "Sí" : "No" %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>