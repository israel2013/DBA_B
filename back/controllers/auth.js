const pool = require('../database/keys');
const bcrypt = require('bcrypt');

const authentication = {};
//registrar usuario alumno
authentication.signUp = async (req, res) => {
    const { name, email, password, rol } = req.body;
    if (rol == 'professor') {
        try {
            await pool.query(
                "INSERT INTO profesor (p_nombre, p_email, p_password) VALUES ($1, $2,$3)"
                , [name, email, password]
            );
            res.status(200).json({
                message: 'Successful registed professor',
                professor: { name, email, password },
            });
        } catch (error) {
            if (error.constraint == 'professor_p_email_key') {
                res.status(500).json({
                    message: 'Someone is already using than email',
                    error
                });
            } else {
                res.status(500).json({
                    message: 'An error has ocurred',
                    error
                });
            }
        }

    } else {
        try {
            await pool.query(
                "INSERT INTO student (s_name, s_email, s_password) VALUES ($1, $2,$3)"
                , [name, email, password]
            );
            res.status(200).json({
                message: 'Successful registed studet',
                student: { name, email, password },
            });
        } catch (error) {
            if (error.constraint == 'student_s_email_key') {
                res.status(500).json({
                    message: 'Someone is already using than email',
                    error,
                });
            } else {
                res.status(500).json({
                    message: 'An error has ocurred',
                    error,
                });
            }

        }



        // res.send('student');
    }


};





authentication.signIn = async (req, res) => {
    const { control, password, rol } = req.body;
    console.log(req)
    // Compara la contraseña proporcionada con el hash almacenado
    if (rol == 'personal') {

        const per_info = await(await pool.query(
            'SELECT * FROM personal WHERE cve_per =$1',
            [control])).rows;
            const has=per_info[0].password_per
          // console.log(password)

        bcrypt.compare(password,has, (error, resultado) => {
            if (error) {            
             // Ocurrió un error durante la comparación
                res.status(500).json({
                message: 'Error al comprar hashes',
                error,
            });

            } else {
                if (resultado) {
                    // La contraseña proporcionada es correcta
                    res.status(200).json({
                    ncontrol:per_info[0].cve_per,
                    nombre:per_info[0].nombre_per,
                    email:per_info[0].email_per,    
                    rol: 'personal'
                    });
                } else {
                    // La contraseña proporcionada es incorrecta
                    res.status(500).json({
                        message: 'La contrasena es incorrecta',
                        error,
                    });
                }
            }
        });

        //alumno
    } else {
        const alum_has = await(await pool.query(
            'SELECT control_a,nombre_a,carrera_a,password_a,email_a FROM alumnos WHERE control_a =$1',
            [control])).rows;
            const has=alum_has[0].password_a
            console.log(has)

          // console.log(password)

        bcrypt.compare(password,has, (error, resultado) => {
            if (error) {            
             // Ocurrió un error durante la comparación
                res.status(500).json({
                message: 'Error al comprar hashes',
                error,
            });

            } else {
                if (resultado) {
                    // La contraseña proporcionada es correcta
                    res.status(200).json({
                    ncontrol:alum_has[0].control_a,
                    nombre:alum_has[0].nombre_a,
                    email:alum_has[0].email_a,    
                    rol: 'alumno'
                    });
                } else {
                    // La contraseña proporcionada es incorrecta
                    res.status(500).json({
                        message: 'La contrasena es incorrecta',
                        error,
                    });
                }
            }
        });



    }

}

// //iniciar sesion profesor/alumno
// authentication.signIn = async (req, res) => {
//     //comparar las dos 
//     const { ncontrol, password, rol } = req.body;
//     if (rol == 'personal') {
//         try {

//             const professor = await (await pool.query(
//                 'SELECT * FROM personal WHERE cve_per =$1 AND password_per=$2',
//                 [ncontrol,password])).rows;
//             if (professor.length > 0) {
//                 res.status(200).json({
//                     id: professor[0].id_p,
//                     name: professor[0].p_nombre,
//                     rol: 'professor'
//                 });

//             } else {
//                 res.status(200).json({
//                     message: 'The professor does not exist',
//                     NotFound: true,
//                 });

//             }


//         } catch (error) {
//             res.status(500).json({
//                 message: 'An error has ocurred',
//                 error,
//             });

//         }

//     } else {
//         try {
//             const student = await (await pool.query(
//                 'SELECT * FROM alumno WHERE email_a =$1 AND password_a=$2',
//                 [email, password])).rows;
//             if (student.length > 0) {
//                 res.status(200).json({
//                     id: student[0].id_s,
//                     name: student[0].s_name,
//                     email: student[0].s_email,
//                     rol: 'student'
//                 });

//             } else {
//                 res.status(200).json({
//                     message: 'The student does not exist',
//                     NotFound: true,
//                 });

//             } 

//         } catch (error) {
//             res.status(500).json({
//                 message: 'An error has ocurred',
//                 error,
//             });

//         }
//     }


// }
module.exports = authentication;