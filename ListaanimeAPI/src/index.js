const express = require('express');
const app = express();

//Setings
app.set('port', process.env.PORT || 4000);

//Middlewares

app.use(express.json());

//Routes

app.use( require('./routes/rutas'));
app.use( '/lista', require('./routes/lista'));

//Public

app.listen(app.get('port'), () => {
    console.log(`Server on port ${app.get('port')}`);
});