const {Router} = require('express');
const router = Router();
const mysql = require('mysql');

function conectar(){
    const mysqlConnection = mysql.createConnection({
        host: '192.168.0.4',
        user: 'JuanVasco',
        password: '03042021',
        database: 'listaanime',
        multipleStatements: true
        });
    mysqlConnection.connect(function (err) {
        if (err) {
          console.error(err);
          return;
        } 
      });
    return mysqlConnection;
}

router.post('/', (req, res)=>{
    const{id}= req.body;
    var mysqlConnection = conectar();
    const query = 'select dlistaanime.id_dlista, dlistaanime.des_anime,  dlistaanime.cap , dlistaanime.estado, cgeneroanime.des_gen  from dlistaanime INNER JOIN cgeneroanime ON dlistaanime.id_gen = cgeneroanime.id_gen  where dlistaanime.id_lista = ? order by dlistaanime.estado ASC';
    mysqlConnection.query(query, id, (err, rows)=>{
        if(!err){
            mysqlConnection.destroy();
            res.json({
                'status': 'encontradas',
                'Datos': rows
        });
        }else{
            console.error(err)
            mysqlConnection.destroy();
            res.json({'status': '¡ERROR!'});
        }
    })
});

router.post('/Agregar', (req, res)=>{
    const{nom_anime, gen, cap, id_usu} = req.body;
    var mysqlConnection = conectar();
    const query = 'insert into dlistaanime (des_anime, id_gen, cap, id_lista, estado) values (?, ?, ?, ?, ?) '
    mysqlConnection.query(query, [nom_anime, gen, cap, id_usu, 0], (err, rows)=>{
        if(!err){
            mysqlConnection.destroy();
            res.json({'status': 'Guardado'});
        }else{
            console.error(err)
            mysqlConnection.destroy();
            res.json({'status': '¡ERROR!'});
        }
    })
})

router.post('/Cambiar', (req, res)=>{
    const{id_usu, id, estado} = req.body
    var mysqlConnection = conectar();
    const query = 'update dlistaanime set estado = ? where id_dlista = ? and id_lista = ? '
    mysqlConnection.query(query, [estado, id, id_usu], (err, rows)=>{
        if(!err){
            mysqlConnection.destroy();
            res.json({'status': 'Actualizado'});
        }else{
            console.error(err)
            mysqlConnection.destroy();
            res.json({'status': '¡ERROR!'});
        }
    });
});

router.post('/Eliminar', (req, res)=>{
    const{id_usu, id} = req.body
    var mysqlConnection = conectar();
    const query = 'delete from dlistaanime where id_dlista = ? and id_lista = ?';
    mysqlConnection.query(query, [id, id_usu], (err, rows)=>{
        if(!err){
            mysqlConnection.destroy();
            res.json({'status': 'Eliminado'});
        }else{
            console.error(err)
            mysqlConnection.destroy();
            res.json({'status': '¡ERROR!'});
        }
    });
})
module.exports = router;