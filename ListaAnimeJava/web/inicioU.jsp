

<%@page import="java.util.List"%>
<%@page import="Control.ConexionAPI"%>
<%@page import="Modelo.listaanime"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true" language="java" %>
<% 
    HttpSession sesion = request.getSession(true);
    if(sesion.getAttribute("id") == null && sesion.getAttribute("nombre") == null){
        response.sendRedirect("index.jsp");
    }
    int id = Integer.valueOf(sesion.getAttribute("id").toString());
    List<listaanime> lista = ConexionAPI.listausuario(id);
    int pendientes = 0;
    int vistos = 0;
    for(listaanime anime:lista){
        if(anime.getEstado() == 0){
            pendientes++;
        }else if(anime.getEstado() == 1){
            vistos++;
        }
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio Usuario</title>
    <link rel="stylesheet" href="CSS/estilos.css">
    <link rel="stylesheet" href="CSS/normalize.css">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="principal"><br>
        <div class="Datos"><br>
            <button type="button" class="botonees" onclick="CerrarSesion()" id="enviar">Cerrar Sesion</button>
            <h3>Lista de Anime</h3>
            <h3>Hola <%=sesion.getAttribute("nombre")%> en este apartado puedes hacer la gestión de los anime de tu lista, puedes agregarlos y quitarlos, marcarlos como completados o pendientes</h3><br>
            <br>
            <br>
            <h2>Animes vistos: <%=vistos %></h2>
            <h2>Animes Pendientes: <%=pendientes%></h2>
            <div class="agre" background="img/horis.png" data-open="modalR">
                <img src="img/add_40px.png">
                <br>
                <br>
                <br>
                <br>
                <br>
            </div>
            <% 
                
                for(listaanime anime:lista){
                    if(anime.getEstado() == 0){
            %>
            <div class="anime1">
                <h5>Pendiente</h5>
                <h5><%=anime.getDes_anime() %></h5>
                <h5><%=anime.getCapitulos() %> Capitulos</h5>
                <h5><%=anime.getDes_gen() %></h5>
                <button type="button" class="botonees1" onclick="visto(<%=anime.getId_dlista() %>)" id="enviar">Visto</button>
                <button type="button" class="botonees" onclick="eliminar(<%=anime.getId_dlista() %>)" id="enviar">Eliminar</button>
                <br>
            </div>
            <% 
                }else if(anime.getEstado() == 1){
            %>
            <div class="anime2">
                <h5>Visto</h5>
                <h5><%=anime.getDes_anime() %></h5>
                <h5><%=anime.getCapitulos() %> Capitulos</h5>
                <h5><%=anime.getDes_gen() %></h5>
                <button type="button" class="botonees2" onclick="pendiente(<%=anime.getId_dlista() %>)" id="enviar">Pendiente</button>
                <button type="button" class="botonees" onclick="eliminar(<%=anime.getId_dlista() %>)" id="enviar">Eliminar</button>
                <br>
            </div>
            <% 
                    }
                }
            %>
        </div>
        <br>
    </div>
    <br>
    <div class="modal" id="modalR">
        <div class="card">
            <form action="AgregarAnime" name="agregara">
                <input type="text"  name="nombre" id="nombre" placeholder="Nombre del anime" class="input">
                <input type="number" name="cap" id="cap" placeholder="Cantidad de Capitulos" class="input">
                <br>
                <label for="" class="article">Genero</label>
                <br>
                <select name="genero" id="Genero" class="select">
                        <option value="1">Comedia</option>
                        <option value="2">Romance</option>
                        <option value="3">Shounen</option>
                        <option value="4">Shoujo</option>
                        <option value="5">Drama</option>
                        <option value="6">Magia</option>
                        <option value="7">Musica</option>
                        <option value="8">Seinen</option>
                        <option value="9">Deportes</option>
                        <option value="10">Fantasia</option>
                </select>
                <br>
                <button type="button" class="submit" onclick="agregar()" >Agregar</button>
            </form>
        </div>
    </div>
    <script src="./JS/validar.js"></script>
    <script src="./JS/funcionModal.js"></script>
</body>
</html>