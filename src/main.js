// import { createApp } from 'vue'
// import App from './App.vue'
// import router from './router'

// createApp(App).use(router).mount('#app')
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import vuetify from './plugins/vuetify';
import { loadFonts } from './plugins/webfontloader';
import axios from 'axios';
import VueAxios from 'vue-axios';

const app = createApp(App);

app.use(router);
app.use(vuetify);
app.use(VueAxios, axios);
app.config.productionTip = false;

axios.defaults.baseURL = 'http://localhost:3000/';

loadFonts();

app.mount('#app');
