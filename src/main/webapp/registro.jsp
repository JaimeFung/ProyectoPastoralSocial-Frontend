<%-- 
    Document   : registro
    Created on : Dec 15, 2025, 5:17:27 PM
    Author     : Jaime
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro - Sistema Pastoral Social</title>
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
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',
                    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans',
                    'Helvetica Neue', sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1.8rem 1.3rem;
                background: radial-gradient(circle at top left, rgba(201, 165, 104, 0.22),
                    transparent 55%),
                    radial-gradient(circle at bottom right, rgba(35, 65, 90, 0.18),
                    transparent 55%), var(--color-bg);
                color: var(--color-text);
            }

            .card {
                background: #FFFFFF;
                border-radius: 18px;
                border: 1px solid var(--color-border);
                box-shadow: 0 20px 50px rgba(15, 23, 42, 0.12);
                width: 100%;
                max-width: 52rem;
                padding: 2.2rem 2.2rem 2rem;
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

            .header {
                text-align: center;
                margin-bottom: 2rem;
                position: relative;
                z-index: 1;
            }

            .logo {
                width: 48px;
                height: 48px;
                background: linear-gradient(135deg, #23415A, #C9A568);
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

            h1 {
                font-size: 1.5rem;
                color: #111827;
                margin-bottom: 0.3rem;
                letter-spacing: 0.02em;
            }

            .subtitle {
                color: var(--color-muted);
                font-size: 0.9rem;
            }

            .form-row {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 1rem;
                margin-bottom: 0.75rem;
                position: relative;
                z-index: 1;
            }

            .form-group {
                margin-bottom: 0.9rem;
            }

            label {
                display: block;
                font-size: 0.85rem;
                font-weight: 500;
                color: #374151;
                margin-bottom: 0.45rem;
            }

            input, select {
                width: 100%;
                padding: 0.55rem 0.9rem;
                border: 1px solid #D1D5DB;
                border-radius: 10px;
                font-size: 0.87rem;
                transition: border-color 0.2s ease, box-shadow 0.2s ease,
                    background-color 0.2s ease;
                background: #FDFBF7;
            }

            input:focus, select:focus {
                outline: none;
                border-color: var(--color-primary);
                box-shadow: 0 0 0 2px rgba(35, 65, 90, 0.16);
                background: #FFFFFF;
            }

            .btn-group {
                display: flex;
                gap: 0.75rem;
                margin-top: 1.8rem;
                position: relative;
                z-index: 1;
            }

            .btn {
                flex: 1;
                padding: 0.7rem 1rem;
                border-radius: 999px;
                font-size: 0.9rem;
                font-weight: 500;
                cursor: pointer;
                border: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.35rem;
                transition: background-color 0.2s ease, color 0.2s ease, box-shadow 0.2s
                    ease, transform 0.1s ease;
            }

            .btn-primary {
                background: var(--color-primary);
                color: #FFFFFF;
                box-shadow: 0 5px 22px rgba(15, 23, 42, 0.25);
            }

            .btn-primary:hover {
                background: var(--color-primary-dark);
                box-shadow: 0 13px 26px rgba(15, 23, 42, 0.3);
                transform: translateY(-1px);
            }

            .btn-secondary {
                background: #FFFFFF;
                color: var(--color-primary);
                border: 1px solid var(--color-border);
            }

            .btn-secondary:hover {
                background: #F3F4F6;
            }

            @media ( max-width : 768px) {
                .card {
                    padding: 2rem 1.5rem 1.8rem;
                }
                .form-row {
                    grid-template-columns: 1fr;
                }
            }
        </style>

    </head>
    <body>
        <div class="card">
            <div class="header">
                <div class="logo"></div>
                <h1>Registro de Usuario</h1>
                <p class="subtitle">Pastoral Social - Diócesis de Cartago</p>
            </div>

            <form action="login.jsp" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="nombre">Nombre</label> <input type="text" id="nombre"
                                                                  name="nombre" placeholder="Nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="apellidos">Apellidos</label> <input type="text"
                                                                        id="apellidos" name="apellidos" placeholder="Apellidos" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Correo Electrónico</label> <input type="email"
                                                                             id="email" name="email" placeholder="usuario@ejemplo.com" required>
                    </div>
                    <div class="form-group">
                        <label for="telefono">Teléfono</label> <input type="tel"
                                                                      id="telefono" name="telefono" placeholder="8888-8888" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="parroquia">Parroquia</label> <select id="parroquia"
                                                                         name="parroquia" required>
                            <option value="">Seleccione una parroquia</option>
                            <option value="santiago-apostol">Parroquia Santiago
                                Apóstol</option>
                            <option value="san-nicolas">Parroquia San Nicolás</option>
                            <option value="inmaculada-concepcion">Parroquia
                                Inmaculada Concepción</option>
                            <option value="nuestra-senora-pilar">Parroquia Nuestra
                                Señora del Pilar</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="rol">Rol</label> <select id="rol" name="rol" required>
                            <option value="">Seleccione un rol</option>
                            <option value="coordinador">Coordinador Pastoral</option>
                            <option value="voluntario">Voluntario</option>
                            <option value="administrador">Administrador</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Contraseña</label> <input type="password"
                                                                        id="password" name="password" placeholder="••••••••" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirmar Contraseña</label> <input
                            type="password" id="confirmPassword" name="confirmPassword"
                            placeholder="••••••••" required>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-secondary"
                            onclick="window.location.href = 'index.jsp'">Volver</button>
                    <button type="submit" class="btn btn-primary">Registrar
                        Usuario</button>
                </div>
            </form>
        </div>
    </body>
</html>