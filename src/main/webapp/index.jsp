<%-- 
    Document   : index
    Created on : Dec 15, 2025, 5:16:46 PM
    Author     : Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="edu.ulatina.controller.UsuarioController"%>
<%@page import="edu.ulatina.model.Usuario"%>

<%
    String errorMessage = null;
    
    // Procesar login si es POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            // Usar UsuarioController para hacer login
            UsuarioController controller = new UsuarioController();
            Usuario usuario = controller.login(email, password);
            
            if (usuario != null) {
                // Login exitoso - guardar en sesión
                session.setAttribute("usuario", usuario);
                session.setAttribute("nombreUsuario", usuario.getNombreCompleto());
                session.setAttribute("rol", usuario.getRol().toString());
                
                // Redirigir a dashboard
                response.sendRedirect("dashboard.jsp");
                return; // Importante: detener ejecución después de redirect
            } else {
                // Login fallido
                errorMessage = "Correo o contraseña incorrectos";
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "Error del servidor: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Sistema Pastoral Social</title>
        <style>
            :root {
                --color-bg: #F7F4EE;
                --color-primary: #23415A;
                --color-primary-dark: #1B3146;
                --color-accent: #C9A568;
                --color-border: #E5DED0;
                --color-text: #1F2933;
                --color-muted: #6B7280;
                --color-error: #DC2626;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',
                    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans',
                    'Helvetica Neue', sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1.5rem;
                color: var(--color-text);
                background: radial-gradient(circle at top left, rgba(201, 165, 104, 0.24),
                    transparent 55%),
                    radial-gradient(circle at bottom right, rgba(35, 65, 90, 0.18),
                    transparent 55%), var(--color-bg);
            }

            .card {
                background: #FFFFFF;
                border-radius: 18px;
                border: 1px solid var(--color-border);
                box-shadow: 0 18px 45px rgba(15, 23, 42, 0.12);
                width: 100%;
                max-width: 26rem;
                padding: 2.3rem 2.2rem 2rem;
                position: relative;
                overflow: hidden;
            }

            .card::before {
                content: "";
                position: absolute;
                inset: 0;
                border-radius: inherit;
                border-top: 4px solid var(--color-accent);
                pointer-events: none;
                opacity: 0.9;
            }

            .logo {
                width: 48px;
                height: 48px;
                background: linear-gradient(135deg, var(--color-primary),
                    var(--color-accent));
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                color: #FFFFFF;
                font-size: 24px;
                font-weight: bold;
                box-shadow: 0 5px 20px rgba(15, 23, 42, 0.22);
                margin: 0 auto 0.9rem;
            }

            .logo::before, .logo::after {
                content: "";
                position: absolute;
                background: rgba(255, 255, 255, 0.9);
                border-radius: 999px;
            }

            .logo::before {
                width: 4px;
                height: 24px;
            }

            .logo::after {
                width: 20px;
                height: 4px;
            }

            .header {
                text-align: center;
                margin-bottom: 1.8rem;
                position: relative;
                z-index: 1;
            }

            h1 {
                font-size: 1.125rem;
                color: #111827;
                margin-bottom: 0.3rem;
                letter-spacing: 0.02em;
            }

            .subtitle {
                color: var(--color-muted);
                font-size: 0.88rem;
            }

            .form-group {
                margin-bottom: 1.1rem;
                position: relative;
                z-index: 1;
            }

            label {
                display: block;
                font-size: 0.85rem;
                font-weight: 500;
                color: #374151;
                margin-bottom: 0.45rem;
            }

            input {
                width: 100%;
                padding: 0.55rem 0.9rem;
                border: 1px solid #D1D5DB;
                border-radius: 999px;
                font-size: 0.87rem;
                background: #FDFBF7;
                transition: border-color 0.2s ease, box-shadow 0.2s ease,
                    background-color 0.2s ease;
            }

            input:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 2px rgba(35, 65, 90, 0.16);
                background: #FFFFFF;
            }

            input.error {
                border-color: var(--color-error);
            }

            .btn {
                width: 100%;
                padding: 0.7rem 1rem;
                background: var(--color-primary);
                color: #FFFFFF;
                border: none;
                border-radius: 999px;
                font-size: 0.9rem;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease, box-shadow 0.2s ease, transform
                    0.1s ease;
                margin-top: 0.5rem;
                box-shadow: 0 5px 22px rgba(15, 23, 42, 0.25);
            }

            .btn:hover {
                background: var(--color-primary-dark);
                box-shadow: 0 5px 26px rgba(15, 23, 42, 0.3);
                transform: translateY(-1px);
            }

            .btn:active {
                transform: translateY(0);
                box-shadow: 0 8px 18px rgba(15, 23, 42, 0.22);
            }

            .link-container {
                text-align: center;
                margin-top: 1.2rem;
                position: relative;
                z-index: 1;
            }

            .link {
                color: var(--color-primary);
                text-decoration: none;
                font-size: 0.85rem;
            }

            .link:hover {
                text-decoration: underline;
            }

            .error-message {
                background: #FEE2E2;
                border: 1px solid #FECACA;
                color: var(--color-error);
                padding: 0.75rem 1rem;
                border-radius: 12px;
                font-size: 0.85rem;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                animation: slideDown 0.3s ease;
            }

            .error-message::before {
                content: "⚠";
                font-size: 1.2rem;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @media ( max-width : 480px) {
                .card {
                    padding: 2rem 1.5rem 1.7rem;
                }
            }
        </style>

    </head>
    <body>
        <div class="card">
            <div class="header">
                <div class="logo"></div>
                <h1>Pastoral Social</h1>
                <p class="subtitle">Diócesis de Cartago</p>
            </div>

            <% if (errorMessage != null) { %>
                <div class="error-message">
                    <%= errorMessage %>
                </div>
            <% } %>

            <form action="index.jsp" method="POST">
                <div class="form-group">
                    <label for="email">Usuario</label> 
                    <input type="text"
                           id="email" 
                           name="email" 
                           placeholder="usuario o correo electronico" 
                           required
                           class="<%= errorMessage != null ? "error" : "" %>"
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                </div>

                <div class="form-group">
                    <label for="password">Contraseña</label> 
                    <input type="password"
                           id="password" 
                           name="password" 
                           placeholder="••••••••" 
                           required
                           class="<%= errorMessage != null ? "error" : "" %>">
                </div>

                <button type="submit" class="btn">Ingresar al Sistema</button>

                <div class="link-container">
                    <a href="registro.jsp" class="link">¿No tienes cuenta?
                        Regístrate aquí</a>
                </div>

                <div class="link-container">
                    <a href="recuperar-contrasena.jsp" class="link">¿Olvidó su contraseña?</a>
                </div>

            </form>
        </div>
    </body>
</html>