<%-- 
    Document   : newjsp1
    Created on : Dec 15, 2025, 5:17:05 PM
    Author     : Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar contraseña - Pastoral Social</title>
    <style>
        :root {
            --color-bg: #F7F4EE;
            --color-primary: #23415A;
            --color-primary-dark: #1B3146;
            --color-accent: #C9A568;
            --color-border: #E5DED0;
            --color-text: #1F2933;
            --color-muted: #6B7280;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
                'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
            background: var(--color-bg);
            display: flex;
            min-height: 100vh;
            justify-content: center;
            align-items: center;
            color: var(--color-text);
            line-height: 1.5;
            padding: 1.5rem;
        }

        .card {
            background: #FFFFFF;
            border-radius: 18px;
            border: 1px solid var(--color-border);
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.1);
            width: 100%;
            max-width: 380px;
            padding: 2.5rem 2rem;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
        }

        h1 {
            font-size: 1.4rem;
            color: #111827;
            margin-bottom: 0.3rem;
        }

        p.subtitle {
            color: var(--color-muted);
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        label {
            font-size: 0.85rem;
            color: #374151;
            margin-bottom: 0.45rem;
            font-weight: 500;
            display: block;
        }

        input {
            width: 100%;
            padding: 0.55rem 0.9rem;
            border-radius: 999px;
            border: 1px solid #D1D5DB;
            font-size: 0.85rem;
            background: #FDFBF7;
            transition: border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease;
        }

        input:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 2px rgba(35, 65, 90, 0.16);
            background: #FFFFFF;
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
            transition: background-color 0.2s ease, box-shadow 0.2s ease, transform 0.1s ease;
        }

        .btn:hover {
            background: var(--color-primary-dark);
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.25);
            transform: translateY(-1px);
        }

        .link-container {
            text-align: center;
            margin-top: 1.5rem;
        }

        .link {
            color: var(--color-primary);
            font-size: 0.85rem;
            text-decoration: none;
        }

        .link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="card">
        <div class="header">
            <h1>Recuperar contraseña</h1>
            <p class="subtitle">Ingrese su correo para recibir un enlace para recuperar su contraseña.</p>
        </div>

        <form id="resetForm">
            <div class="form-group">
                <label for="email">Correo electrónico</label>
                <input type="email" id="email" name="email" placeholder="correo@ejemplo.com" required>
            </div>
            
            <button type="submit" class="btn">Enviar enlace de recuperación</button>
        </form>

        <div class="link-container">
            <a href="index.jsp" class="link">Volver al inicio de sesión</a>
        </div>
    </div>

    <script>
        // Validación y lógica para enviar el formulario (simulado)
        document.getElementById('resetForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const email = document.getElementById('email').value;

            if (email) {
                alert('Un enlace de recuperación ha sido enviado a ' + email);
                // Aquí se podría conectar a un API para enviar el correo real.
                window.location.href = 'index.jsp';  // Redirigir al login
            } else {
                alert('Por favor ingrese un correo válido.');
            }
        });
    </script>

</body>
</html>
