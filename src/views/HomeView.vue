<template>
  <v-container>
    <v-app-bar app color="primary" dark>
      <v-toolbar-title>DBA</v-toolbar-title>

    </v-app-bar>
    <v-alert text closable v-model="alert.show" :type="alert.type">{{ alert.message }}
    </v-alert>
    <v-row justify="center">

      <v-col class="text-center" md="2" sm="12">
        <v-btn color="success" @click="suForm = false">Iniciar sesion </v-btn>
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col md="6" sm="6">
        <v-card-text>
          <!--funcion de login(signup)-->
          <v-form class="ma-3" @submit.prevent="signin()" ref="signinForm">

            <v-text-field label="Numero de control" prepend-icon="mdi-email" v-model="user.control"></v-text-field>

            <v-text-field label="Password" prepend-icon="mdi-lock" type="password" v-model="user.password"></v-text-field>

            <!--validamos aqui mismo si se selecciono una una opcion del radio buton-->
            <v-radio-group row :rules="[(v) => !!v || 'please choose one']">
              <v-radio label="personal" value="personal"></v-radio>
              <v-radio label="alumno" value="alumno"></v-radio>
            </v-radio-group>

            <v-btn block color="success mt-3" type="submit">sign in</v-btn>
          </v-form>


        </v-card-text>
      </v-col>

    </v-row>
  </v-container>
</template>

<script>
// Components
// import HelloWorld from '../components/HelloWorld.vue';

export default {
  data: () => ({

    alert: { show: false, message: '' },
    nameRules: [
      value => !!value || 'Name is require',
      value => (value && value.length >= 5 || 'Name must be more than 5 characters')
    ],
    //validamos el correo, que cumpla los requisitos
    // emailRules: [
    //   value => !!value || 'E-mail is required',
    //   value => /.+@.+\..+/.test(value) || 'Email must be valid'
    // ],
    //validamos que se escriba una contrasena valida
    passwordRules: [
      value => !!value || 'Password is required',
      value => (value && value.length >= 2 || 'password must more than character ')
    ],

    user: { name: "", control: "", password: "", rol: "" },
    suForm: true

  }),

  methods: {
    //ingresar
    // async signup() {
    //   let valid = this.$refs.signupForm.validate();
    //   if (valid) {
    //     try {
    //       const res = await this.axios.post('/signup', this.user);
    //       this.$refs.signupForm.reset();
    //       console.log(res);
    //       this.alert = {
    //         show: true,
    //         type: 'success',
    //         message: res.data.message,
    //       }

    //     } catch (error) {
    //       this.alert = {
    //         show: alert,
    //         type: 'error',
    //         message: error.response.data.message,

    //       }

    //     }
    //   }

    // },
    async signin() {
      let valid = this.$refs.signinForm.validate();
      if (valid) {
        try {
          const res = await this.axios.post('/signin', this.user);
          if (res.data.NotFound) {
            this.alert = {
              show: true,
              type: 'error',
              message: res.data.message
            }
          } else {
            sessionStorage.setItem("session", JSON.stringify(res.data));
            this.$router.push("/perfil");
            //   this.alert={
            //   show:true,
            //   type:"success",
            //   message:'Welcome'
            // };
          }

        } catch (error) {
          this.alert = {
            show: true,
            type: "error",
            message: error.response.data.message,
          };

        }
      }


    }
  }

};
</script>
