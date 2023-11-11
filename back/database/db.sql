--tabla del plan de estudios
CREATE TABLE planE
(
    cve_pe VARCHAR(15),
    nombre_pe VARCHAR(40) NOT NULL,
    cvees_pe VARCHAR(20),
    nombreespecialidad_pe VARCHAR(55) NOT NULL,
    PRIMARY KEY(cve_pe,cvees_pe)
);
--tabla de alumnos
CREATE TABLE alumnos
(
    control_a VARCHAR(13) PRIMARY KEY,
    apellidop_a VARCHAR(30) NOT NULL,
    apellidop_m VARCHAR(30) NOT NULL,
    nombre_a VARCHAR(40) NOT NULL,
    discapacidad_a BIT NOT NULL,
    ingreso_a SMALLINT NOT NULL,
    periodo_a VARCHAR(15) NOT NULL,
    password_a TEXT NOT NULL,
    telefono_a TEXT NOT NULL,
    email_a VARCHAR(50),
    fkplanE_a VARCHAR(15),
    fkEspecialidad_a VARCHAR(20),
    FOREIGN KEY (fkplanE_a,fkEspecialidad_a) REFERENCES planE(cve_pe,cvees_pe)
);


--tabla de personal
CREATE TABLE personal
(
    cve_per VARCHAR(10) PRIMARY KEY,
    apellidop_per VARCHAR(30) NOT NULL,
    apellidom_per VARCHAR(30) ,
    nombre_per VARCHAR(40) NOT NULL,
    password_per TEXT NOT NULL,
    email_per VARCHAR(50) NOT NULL
);


--tabla kardex
CREATE TABLE kardex
(
                                                                      
    fkAlumno_k VARCHAR(13),
    calificacionR_k FLOAT NOT NULL,
    calificacionP_k FLOAT NOT NULL,       
    promedio_k FLOAT NOT NULL,                                                                              
    fkGrupo_k VARCHAR(5), 
    fkPersonal_k VARCHAR(10),      
    fkMateria_k VARCHAR(10), 
    fkPlanE_k VARCHAR(15),      
    fkEspecialidad_k VARCHAR(20),      
    fkSemestre_k VARCHAR(15),
    PRIMARY KEY(fkAlumno_k,fkPersonal_k,fkMateria_k,fkGrupo_k,fkPlanE_k,fkEspecialidad_k,fkSemestre_k)       ,
    FOREIGN KEY (fkAlumno_k) REFERENCES alumnos(control_a),   
    FOREIGN KEY(fkPersonal_k,fkMateria_k,fkGrupo_k,fkPlanE_k,fkEspecialidad_k,fkSemestre_k) REFERENCES grupo(fkPersonal_g,fkMateria_g,cve_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g));


    --tabla materia plan de estudio
    CREATE TABLE materiaPlanE
    (
        semestre_mpe VARCHAR(22),
        fkMateria_mpe VARCHAR(10),
        fkPlanE_mpe VARCHAR(15),
        fkEspecialidad_mpe VARCHAR(20),
        PRIMARY KEY (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe),
        FOREIGN KEY (fkPlanE_mpe, fkEspecialidad_mpe) REFERENCES planE(cve_pe, cvees_pe),
        FOREIGN KEY (fkMateria_mpe) REFERENCES materia(cve_m)
    );


    -- tabla materia
    CREATE TABLE materia
    (
        cve_m VARCHAR(10) PRIMARY KEY,
        nombre_m VARCHAR(70),
        creditosP_m SMALLINT NOT NULL,
        creditosT_m SMALLINT NOT NULL
    );

    --tabla grupo
    CREATE TABLE grupo
    (
        cve_g VARCHAR(5),
        semestre_g VARCHAR(22),
        fkPersonal_g VARCHAR(10),
        fkMateria_g VARCHAR(10),
        fkPlanE_g VARCHAR(15),
        fkEspecialidad_g VARCHAR(20),
        fksemestre_g VARCHAR(22),
        PRIMARY KEY(cve_g, fkPersonal_g, fkMateria_g, fkPlanE_g, fkEspecialidad_g, fksemestre_g),
        FOREIGN KEY(fkPersonal_g) REFERENCES personal(cve_per),
        FOREIGN KEY(fksemestre_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g) REFERENCES materiaPlanE(semestre_mpe,fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
    );






    --tabla edificio
    CREATE TABLE edificio
    (
        cve_e VARCHAR(10),--preguntar profe
        planta_e CHAR(4),
        cveAula_e VARCHAR(5),
        numBancas_e SMALLINT NOT NULL,
        numPc_e SMALLINT NULL,
        PRIMARY KEY(cve_e,cveAula_e)
    );

    -- Horas
    CREATE TABLE horas
    (
        fkEdificio_h VARCHAR(10),
        fkAula_h VARCHAR(5),
        fkGrupo_h VARCHAR(5),
        fkEspecialidad_h VARCHAR(20),
        fkPlanE_h VARCHAR(15),
        fkMateria_h VARCHAR(10),
        fkSemestre_h VARCHAR(22),
        fkPersonal_h VARCHAR(10),
        hora_h VARCHAR(12) NOT NULL,
        PRIMARY KEY(fkEdificio_h, fkAula_h, fkGrupo_h, fkEspecialidad_h, fkPlanE_h, fkMateria_h, fkSemestre_h,fkPersonal_h),
        FOREIGN KEY(fkEdificio_h,fkAula_h) REFERENCES edificio(cve_e,cveAula_e),
        FOREIGN KEY(fkGrupo_h,fkPlanE_h,fkEspecialidad_h,fkMateria_h,fkSemestre_h,fkPersonal_h) REFERENCES grupo(cve_g,fkPlanE_g,fkEspecialidad_g,fkMateria_g,fksemestre_g,fkPersonal_g)
    );


    -- Prerrequisitos
    CREATE TABLE Prerrequisitos
    (
        cve_pre VARCHAR(5) ,
        fkMateria_pre VARCHAR(10),
        fkPlanE_pre VARCHAR(15),
        fkEspecialidad_pre VARCHAR(20),
        fkSemestre_pre VARCHAR(22)
        --Primary Key
        PRIMARY KEY(cve_pre,fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre),
        -- Foreign keys
        FOREIGN KEY(fkMateria,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
        REFERENCES materiaPlanE(fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
    );

-- valores para la tabla materiaPlanE
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('AGO-DIC', 'SCB-1001','ISIC-2010-224','ISIE-TWM-2020-01');

INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('AGO-DIC', 'TWD-2002','ISIC-2010-224','ISIE-TWM-2020-01');


--valores para la tabla grupo 
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130701','SCB-1001','ISIC-2010-224','ISIE-TWM-2020-01','AGO-DIC');


--valores para la tabla de kardex

-- --tabla del plan de estudios
-- CREATE TABLE planE
-- (   cve_pe VARCHAR(25),
--     nombre_pe VARCHAR(50) NOT NULL,
--     cvees_pe VARCHAR(25),
--     nombreespecialidad_pe VARCHAR(50) NOT NULL,
--     PRIMARY KEY(cve_pe,cvees_pe)
-- );

-- --tabla de alumnos
-- CREATE TABLE alumnos
-- (
--     control_a VARCHAR(50) PRIMARY KEY,
--     apellidop_a VARCHAR(50) NOT NULL,
--     apellidop_m VARCHAR(50) NOT NULL,
--     nombre_a VARCHAR(50) NOT NULL,
--     discapacidad_a INT NOT NULL,
--     carrera_a VARCHAR(50) NOT NULL,
--     ingreso_a INT NOT NULL,
--     periodo_a VARCHAR(50) NOT NULL,
--     password_a TEXT NOT NULL,
--     telefono_a TEXT NOT NULL,
--     email_a VARCHAR(100),
--     fkplanE_a VARCHAR(50) ,
--     fkEspecialidad_a VARCHAR(50),
--     FOREIGN KEY (fkplanE_a,fkEspecialidad_a) REFERENCES planE(cve_pe,cvees_pe)
-- );

-- --tabla de personal
-- CREATE TABLE personal
-- (
--     cve_per VARCHAR(50) PRIMARY KEY,
--     apellidop_per VARCHAR(50) NOT NULL,
--     apellidom_per VARCHAR(50) ,
--     nombre_per VARCHAR(50) NOT NULL,
--     password_per TEXT NOT NULL,
--     email_per TEXT NOT NULL
-- );

-- --tabla kardex 
-- CREATE TABLE kardex
-- (
--     cve_k VARCHAR(10) PRIMARY KEY,
--     fkAlumno_k VARCHAR(50),
--     calificacionR_k FLOAT NOT NULL,
--     calificacionP_k FLOAT NOT NULL,
--     promedio_k FLOAT NOT NULL,
--     fkGrupo_k VARCHAR(5),
--     fkPersonal_k VARCHAR(50),
--     fkMateria_k VARCHAR(10),
--     fkPlanE_k VARCHAR(50),
--     fkEspecialidad_k VARCHAR(50),
--     fkSemestre_k VARCHAR(20),
--     FOREIGN KEY(fkAlumno_k) REFERENCES alumnos(control_a),
--     FOREIGN KEY(fkPersonal_k,fkMateria_k,fkGrupo_k,fkPlanE_k,fkEspecialidad_k,fSkemestre_k) REFERENCES grupo(fkPersonal_g,fkMateria_g,cve_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)

-- );

-- --tabla materia plan de estudio
-- CREATE TABLE materiaPlanE
-- (
--     semestre_mpe VARCHAR(20),
--     fkMateria_mpe VARCHAR(10),
--     fkPlanE_mpe VARCHAR(50),
--     fkEspecialidad_mpe VARCHAR(50),
--     PRIMARY KEY (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe),
--     FOREIGN KEY (fkPlanE_mpe, fkEspecialidad_mpe) REFERENCES planE(cve_pe, cvees_pe),
--     FOREIGN KEY (fkMateria_mpe) REFERENCES materia(cve_m)
-- );
-- -- tabla materia 
-- CREATE TABLE materia
-- (
--     cve_m VARCHAR(10) PRIMARY KEY,
--     nombre_m VARCHAR(50),
--     creditosP_m SMALLINT NOT NULL,
--     creditosT_m SMALLINT NOT NULL
-- );

-- --tabla grupo
-- CREATE TABLE grupo
-- (
--     cve_g VARCHAR(5),
--     semestre_g VARCHAR(20),
--     fkPersonal_g VARCHAR(50),
--     fkMateria_g VARCHAR(10),
--     fkPlanE_g VARCHAR(50),
--     fkEspecialidad_g VARCHAR(50),
--     fksemestre_g VARCHAR(50),
--     PRIMARY KEY(cve_g, fkPersonal_g, fkMateria_g, fkPlanE_g, fkEspecialidad_g, fksemestre_g),
--     FOREIGN KEY(fkPersonal_g) REFERENCES personal(cve_per),
--     FOREIGN KEY(fksemestre_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g) REFERENCES materiaPlanE(semestre_mpe,fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- );

-- --tabla edificio 
-- CREATE TABLE edificio
-- (
--     cve_e VARCHAR(10),
--     planta_e VARCHAR(10),
--     cveAula_e VARCHAR(10),
--     numBancas_e SMALLINT NOT NULL,
--     numPc_e SMALLINT NULL,
--     PRIMARY KEY(cve_e,cveAula_e)
-- );


-- -- Horas
-- CREATE TABLE horas
-- (
--     fkEdificio_h VARCHAR(10),
--     fkAula_h VARCHAR(10),
--     fkGrupo_h VARCHAR(5),
--     fkEspecialidad_h VARCHAR(50),
--     fkPlanE_h VARCHAR(50),
--     fkMateria_h VARCHAR(10),
--     fkSemestre_h VARCHAR(20),
--     fkPersonal_h VARCHAR(50),
--     hora_h VARCHAR(10) NOT NULL,
--     PRIMARY KEY(fkEdificio_h, fkAula_h, fkGrupo_h, fkEspecialidad_h, fkPlanE_h, fkMateria_h, fkSemestre_h,fkPersonal_h),
--     FOREIGN KEY(fkEdificio_h,fkAula_h) REFERENCES edificio(cve_e,cveAula_e),
--     FOREIGN KEY(fkGrupo_h,fkPlanE_h,fkEspecialidad_h,fkMateria_h,fkSemestre_h,fkPersonal_h) REFERENCES grupo(cve_g,fkPlanE_g,fkEspecialidad_g,fkMateria_g,fksemestre_g,fkPersonal_g)
-- );

-- -- Prerrequisitos
-- CREATE TABLE Prerrequisitos
-- (
--     cve_pre VARCHAR(5) ,
--     fkMateria_pre VARCHAR(10),
--     fkPlanE_pre VARCHAR(50),
--     fkEspecialidad_pre VARCHAR(50),
--     fkSemestre_pre VARCHAR(20)

--         --Primary Key
--         PRIMARY KEY(cve_pre,fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
--         -- Foreign keys
--         FOREIGN KEY(fkMateria,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre) 
--     REFERENCES materiaPlanE(fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- );