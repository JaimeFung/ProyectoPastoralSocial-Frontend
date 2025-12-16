<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="edu.ulatina.controller.UsuarioController"%>
<%@page import="edu.ulatina.model.Usuario"%>

<%
    String mensaje = null;
    String tipoMensaje = "error"; 
    
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        
        
        if (token == null || token.isEmpty()) {
            mensaje = "Token inválido";
        } else if (password == null || password.isEmpty() || confirm == null || confirm.isEmpty()) {
            mensaje = "Todos los campos son obligatorios";
        } else if (password.length() < 8) {
            mensaje = "La contraseña debe tener al menos 8 caracteres";
        } else if (!password.equals(confirm)) {
            mensaje = "Las   contraseñas no coinciden";
        } else {

            try {
                UsuarioController controller = new UsuarioController();
                
                
                if (!controller.validarFortalezaContrasena(password)) {
                    mensaje = "La contraseña debe contener al menos una letra y un número";
                } else {
                    boolean exito = controller.restablecerContrasenaPorToken(token, password);
                    
                    if (exito) {
                        tipoMensaje = "success";
                        mensaje = "✓ Contraseña restablecida exitosamente. Puede iniciar sesión ahora.";
                        
                        
                        response.setHeader("Refresh", "3; URL=index.jsp");
                    } else {
                        mensaje = "No se pudo restablecer la contraseña. Token inválido.";
                    }
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                mensaje = "Error al procesar la solicitud: " + e.getMessage();
            }
        }
    } else {
        
        String token = request.getParameter("token");
        if (token == null || token.isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restablecer contraseña - Pastoral Social</title>
    <style>
        :root {
            --color-bg: #F7F4EE;
            --color-primary: #23415A;
            --color-primary-dark: #1B3146;
            --color-accent: #C9A568;
            --color-border: #E5DED0;
            --color-text: #1F2933;
            --color-muted: #6B7280;
            --color-success: #166534;
            --color-error: #DC2626;
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at top left, rgba(201, 165, 104, 0.24), transparent 55%),
                        radial-gradient(circle at bottom right, rgba(35, 65, 90, 0.18), transparent 55%), 
                        var(--color-bg);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            padding: 1.5rem;
            color: var(--color-text);
        }
        .card {
            background: #FFFFFF;
            width: 100%;
            max-width: 420px;
            padding: 2.3rem 2.2rem;
            border-radius: 18px;
            border: 1px solid var(--color-border);
            box-shadow: 0 20px 45px rgba(15, 23, 42, 0.12);
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
            background: linear-gradient(135deg, var(--color-primary), var(--color-accent));
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin: 0 auto 0.9rem;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.22);
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
        .card h1 {
            font-size: 1.2rem;
            margin-bottom: 0.4rem;
            color: #111827;
            text-align: center;
            letter-spacing: 0.02em;
        }
        .card p {
            font-size: 0.88rem;
            color: var(--color-muted);
            text-align: center;
            margin-bottom: 1.8rem;
        }
        .alert {
            padding: 0.9rem 1rem;
            border-radius: 12px;
            margin-bottom: 1.2rem;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            animation: slideDown 0.3s ease;
        }
        .alert-success {
            background: #DCFCE7;
            border: 1px solid #86EFAC;
            color: var(--color-success);
        }
        .alert-error {
            background: #FEE2E2;
            border: 1px solid #FECACA;
            color: var(--color-error);
        }
        .alert::before {
            font-size: 1.2rem;
        }
        .alert-success::before {
            content: "✓";
        }
        .alert-error::before {
            content: "✗";
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
        .form-group {
            margin-bottom: 1.1rem;
            position: relative;
            z-index: 1;
        }
        label {
            display: block;
            font-size: 0.85rem;
            margin-bottom: 0.45rem;
            color: #374151;
            font-weight: 500;
        }
        input {
            width: 100%;
            padding: 0.55rem 0.9rem;
            border-radius: 999px;
            border: 1px solid #D1D5DB;
            font-size: 0.87rem;
            background: #FDFBF7;
            transition: all 0.2s ease;
        }
        input:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 2px rgba(35, 65, 90, 0.16);
            background: #FFFFFF;
        }
        .help-text {
            font-size: 0.78rem;
            color: var(--color-muted);
            margin-top: 0.3rem;
        }
        .btn {
            width: 100%;
            margin-top: 0.8rem;
            padding: 0.7rem;
            border: none;
            border-radius: 999px;
            background: var(--color-primary);
            color: #FFFFFF;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 5px 22px rgba(15, 23, 42, 0.25);
        }
        .btn:hover {
            background: var(--color-primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 5px 26px rgba(15, 23, 42, 0.3);
        }
        .btn:active {
            transform: translateY(0);
        }
        .link-container {
            text-align: center;
            margin-top: 1.2rem;
        }
        .link {
            color: var(--color-primary);
            text-decoration: none;
            font-size: 0.85rem;
        }
        .link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="card">
    <div class="logo"></div>
    <h1>Nueva contraseña</h1>
    <p>Ingrese una nueva contraseña segura para su cuenta.</p>
    
    <% if (mensaje != null) { %>
        <div class="alert alert-<%= tipoMensaje %>">
            <%= mensaje %>
        </div>
    <% } %>
    
    <% if (mensaje == null || !tipoMensaje.equals("success")) { %>
        <form action="reset.jsp" method="POST" onsubmit="return validarFormulario()">
            <input type="hidden" name="token" value="<%= request.getParameter("token") %>">
            
            <div class="form-group">
                <label for="password">Nueva contraseña</label>
                <input type="password" id="password" name="password" 
                       required minlength="8" 
                       placeholder="Mínimo 8 caracteres">
                <p class="help-text">Use al menos 8 caracteres, combinando letras y números.</p>
            </div>
            
            <div class="form-group">
                <label for="confirm">Confirmar contraseña</label>
                <input type="password" id="confirm" name="confirm" 
                       required minlength="8"
                       placeholder="Repita la contraseña">
            </div>
            
            <button type="submit" class="btn">Guardar contraseña</button>
            
            <div class="link-container">
                <a href="index.jsp" class="link">Volver al inicio de sesión</a>
            </div>
        </form>
    <% } else { %>
        <div class="link-container">
            <p style="margin-bottom: 1rem; color: var(--color-muted); font-size: 0.85rem;">
                Redirigiendo al inicio de sesión...
            </p>
            <a href="index.jsp" class="btn" style="display: inline-block; text-decoration: none;">
                Ir al inicio de sesión
            </a>
        </div>
    <% } %>
</div>

<script>
    function validarFormulario() {
        const password = document.getElementById('password').value;
        const confirm = document.getElementById('confirm').value;
        
        if (password.length < 8) {
            alert('La contraseña debe tener al menos 8 caracteres');
            return false;
        }
        
        if (password !== confirm) {
            alert('Las contraseñas no coinciden');
            return false;
        }
        
        // Validar que tenga letras y números
        const tieneLetra = /[a-zA-Z]/.test(password);
        const tieneNumero = /[0-9]/.test(password);
        
        if (!tieneLetra || !tieneNumero) {
            alert('La contraseña debe contener al menos una letra y un número');
            return false;
        }
        
        return true;
    }
</script>
</body>
</html>