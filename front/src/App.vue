<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <div>
        Upload File Test
      </div>
    </v-app-bar>

    <v-main>
      <v-container>
        <router-view></router-view>
      </v-container>
    </v-main>
  </v-app>
</template>

<script lang="ts">
import Vue from 'vue';

export default Vue.extend({
  name: 'App',
});
</script>
