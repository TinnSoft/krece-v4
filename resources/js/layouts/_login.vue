<template>
    <q-layout view="lHh Lpr fff">
     <q-header>
        <q-toolbar :class="backgroundColor"  
        >           
          <q-toolbar-title>
            {{title}}
            <!--<div slot="subtitle">{{ subtitle }}</div>-->
          </q-toolbar-title>
        </q-toolbar>
     </q-header>

    <q-page-container>
      <transition enter-active-class="animated fadeIn" leave-active-class="animated fadeOut" mode="out-in">
        <router-view></router-view>
      </transition>
    </q-page-container>

     
    </q-layout>
</template>

<script type="text/javascript">


export default {
  props: ["title", "backgroundColor", "subtitle"],
  data() {
    return {};
  }
};
</script>
