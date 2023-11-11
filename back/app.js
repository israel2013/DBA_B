const express= require('express');
const {urlencoded}= require ('express');
const morgan =require ('morgan');
const cors= require ('cors');
const fileUpload =require ('express-fileupload');
const history =require ('connect-history-api-fallback');
const path =require ('path')

const app = express();
//middlewares
app.use(morgan('tiny'));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended:true}));//
app.use(fileUpload({useTempFiles:true}));//uso de archivos temporales

//routers
app.use('/', require('./routes/auth.routes'));
//app.use('/professor', require('./routes/professor.routes'))
//app.use('/student',require('./routes/student.routes'));

//middlewares for vue
app.use(history());
app.use(express.static(path.join(__dirname, 'public')));


//setings
app.set('port',  3000);

app.listen(app.get('port'), ()=>{
    console.log('Server on port' + app.get('port'));
})