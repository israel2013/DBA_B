<template>

    <v-container>
        <v-row justify="center">
            <v-col md="6" sm="6">
                <v-card>
                    <v-card-title class="text-uppercase">{{user.rol}}</v-card-title>
                    <v-card-text>
                        <h2>{{user.name}}</h2>
                        <h4>{{user.ncontrol}}</h4>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
export default{
    data:()=>({
        user:{rol:"Default",name:"",ncontrol:""}
    }),
    created: function(){
        this.user =JSON.parse( sessionStorage.getItem('session'));
        if(this.user == null)
                    this.$router.push("/");
        
    }
}
</script>