const express= require ('express');
const student =require ('../controllers/student');
const router =express.Router();

// //obtener los cursos disponibles para un alumno
// router.get('/courses', student.getCourses);

// //obtener los cursos a los que pertenece un alumno 
// router.post('/course/:id_c', student.joinCourses);

// router.post('/my-courses',student.getMyCourses);

// router.get('/assignments/:id_c',student.getAssignments);

// router.post('/delivery',student.addDeliver);

module.exports=router;
 