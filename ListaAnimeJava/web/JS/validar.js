let expresioncorreo = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
let expresioncontra = /^(?=\w*\d)(?=\w*[A-Z])(?=\w*[a-z])\S{8,16}$/;
let expresiononlytext = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð]+$/u;

function validarcorreo(correo) {
    var validar = expresioncorreo.test(correo);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Ingrese un correo valido'
        });
    }
    return validar;
}

function validarcontrasena(contrasena) {
    var validar = expresioncontra.test(contrasena);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Ingrese una contraseña valida',
            text: 'La contraseña debe tener al entre 8 y 16 caracteres, al menos un dígito, al menos una minúscula y al menos una mayúscula.'
        });
    }
    return validar;
}

function validarnombre(nombre) {
    var validar = expresiononlytext.test(nombre);
    if (!validar) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Ingrese un nombre valido (solo letras)'
        });
        return false;
    } else if (nombre.length > 20 || nombre.length == 0) {
        Swal.fire({
            icon: 'error',
            title: 'El tamaño del nombre no es correcto',
            text: 'El nombre tiene que medir entre 1 y 20 caracteres'
        });
        return false;
    } else {
        return true;
    }
}


function registrarr() {
    var email = document.getElementById('correo').value;
    var nombre = document.getElementById('nombre').value;
    var pass = document.getElementById('password').value;
    var confpas = document.getElementById('confpass').value;
    if (pass != confpas) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Las contraseñas no coinciden'
        });
    } else if (validarnombre(nombre) && validarcorreo(email) && validarcontrasena(pass)) {
        Swal.fire({
            icon: 'success',
            title: 'Felicidades',
            text: 'Has registrado una cuenta'
        });
        document.registrar.submit();
    }
}

function agregar(){
    Swal.fire({
        icon: 'success',
        title: 'Bien hecho',
        text: 'Has agregado un nuevo anime a tu lista'
    });
    setTimeout(function() {
        document.agregara.submit();
    }, 2000);
}

function iniciars() {
    var email = document.getElementById('IScorreo').value;
    var pass = document.getElementById('IScontra').value;
    if (validarcorreo(email) && validarcontrasena(pass)) {
        Swal.fire({
            icon: 'success',
            title: 'Bien hecho',
            text: 'Se ha iniciado Sesión'
        });
        
        setTimeout(function() {
            document.iniciar.submit();
        }, 2000);
    }
}

function visto (id){
    location.href = 'CambiarEstado?id=' + id+'&&estado=1' ;
}

function eliminar(id){
    location.href = 'EliminarAnime?id=' + id ;
}

function pendiente(id){
    location.href = 'CambiarEstado?id=' + id+'&&estado=0' ;
}

function CerrarSesion(){
    location.href = 'CerrarSesion' ;
}