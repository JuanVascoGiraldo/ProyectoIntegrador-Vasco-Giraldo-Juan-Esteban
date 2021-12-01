

<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java" %>
<% 
    HttpSession sesion = request.getSession(true);
    if(sesion.getAttribute("id") != null && sesion.getAttribute("nombre") != null){
        response.sendRedirect("inicioU.jsp");
    }

%>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
    <link rel="stylesheet" href="./CSS/normalize.css">
    <link rel="stylesheet" href="./CSS/estilos.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
    <div class="alinear">
        <div class="grid">
            <div class="form">
                <form action="IniciarSesion" name="iniciar">
                    <input type="text" name="correo" id="IScorreo" class="texto" placeholder="Correo">
                    <input type="password" name="contra" id="IScontra" class="texto" placeholder="Contraseña">
                    <button type="button" id="IniciarSesion" class="submit button" onclick="iniciars()">Iniciar sesión</button>
                </form>
                <hr width="90%">
                <button class="Registro" id="registrar" data-open="modalR">
                    <a href="#">Crear cuenta</a>
                </button>
            </div>
            <div class="main-content">
                <div class="img">
                    <img src="./img/horis.png" alt="">
                </div>
            </div>
            
        </div>
        <div class="modal" id="modalR">
            <div class="card">
                <form action="Registrar" name="registrar">
                    <input type="text" id="nombre" name="nombre" placeholder="Nombre de Usuario" class="input">
                    <input type="text" id="correo" name="correo" placeholder="Correo electronico" class="input">
                    <br>
                    <input type="password" name="contra" name="" id="password" placeholder="Contraseña" class="input">
                    <input type="password" name="" id="confpass" placeholder="Confirmar Contraseña" class="input">
                    <button type="button" class="submit" onclick="registrarr()" id="enviar">Registrarse</button>
                </form>
            </div>
        </div>
    </div>
    <footer class="footer ">
        Vasco Giraldo Juan Esteban - 5IV7 - Listas de Anime
    </footer>
    <script src="./JS/validar.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>
</html>
