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

router.post('/registrar', (req, res)=>{
    const {nombre, correo, contra} = req.body;
    const mysqlConnection = conectar();
    var query = 'select * from musuario where email_usu = ?';
    mysqlConnection.query(query, correo, (err, rows)=>{
        if(!err){
            if(rows.length === 0){
                var query2 = 'insert into musuario (email_usu, contra_usu, nom_usu) values (?, ?, ?)';
                mysqlConnection.query(query2,[correo, contra, nombre], (errr, rowss)=>{
                    if(!errr){
                        mysqlConnection.query(query, correo, (err_, rows_)=>{
                            if(!err_){
                                var id = rows_[0].id_usu;
                                var query3 = 'insert into mlistaanime (id_lista, id_usu) values (?, ? )';
                                mysqlConnection.query(query3, [id, id], (_err, _rows)=>{
                                    if(!_err){
                                        mysqlConnection.destroy();
                                        res.json({'status': 'registrado'});
                                    }else{
                                        console.error(err_)
                                        mysqlConnection.destroy();
                                        res.json({'status': '¡ERROR!'});
                                    }
                                })
                            }else{
                                console.error(err_)
                                res.json({'status': '¡ERROR!'});
                            }
                        })
                    }else{
                        console.error(errr)
                        mysqlConnection.destroy();
                        res.json({'status': '¡ERROR!'});
                    }
                });
            }else{
                mysqlConnection.destroy();
                res.json({'status': '¡ERROR!'});
            }
        }else{
            console.error(err)
            mysqlConnection.destroy();
            res.json({'status': '¡ERROR!'});
        }
    });
});

router.post('/iniciarsesion', (req, res)=>{
    const{correo, contra} = req.body;
    var mysqlConnection = conectar();
    const query = 'select * from musuario where email_usu = ? and contra_usu = ?';
    mysqlConnection.query(query, [correo, contra], (err, rows)=>{
        if(!err){
            if(rows.length > 0){
                mysqlConnection.destroy();
                res.json({
                    'status': 'encontrado',
                    'usuario': rows[0]
            });

            }else{
                mysqlConnection.destroy();
                res.json({'status': '¡ERROR!'});
            }
        }else{
            console.error(err);
            mysqlConnection.destroy();
            res.json({'status': '¡ERROR!'});
        }
    })
});

module.exports = router;