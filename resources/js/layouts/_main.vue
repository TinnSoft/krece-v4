<template>
    <q-layout view="hHh LpR lFf">

      <q-header reveal elevated class="bg-primary text-white glossy">
        <q-toolbar>
          <q-btn dense flat round icon="menu" @click="left = !left" />

          <q-toolbar-title>            
              {{title}}
          </q-toolbar-title>
          <q-btn flat dense v-if="!$q.platform.within.iframe" icon="exit_to_app" class="q-mr-sm" label="Salir" @click.native="logout"></q-btn>
        </q-toolbar>
      </q-header>


    <q-drawer
        side="left"
        v-model="left"
        :overlay="leftOverlay"
        :behavior="leftBehavior"
        :breakpoint="leftBreakpoint"
        :mini="miniState"
        @mouseover="miniState = false"
        @mouseout="miniState = true"
        show-if-above
        content-class="bg-grey-1"
        >

        <q-scroll-area class="fit">
            <q-list padding style="max-width: 350px">

             <div v-for="item in items" v-bind:key="item.title" >
                 <q-item dense v-if="item.type=='alone'" item :to="item.path" :key="item.title" clickable v-ripple
                 active-class="text-primary text-bold">
                      <q-item-section  avatar>
                        <q-icon :name="item.icon"></q-icon>
                      </q-item-section>
                      <q-item-section>
                        {{item.title}}
                      </q-item-section>
                </q-item>
                <q-expansion-item expand-separator v-if="item.type!=='alone'"  :icon="item.icon"
                  :label="item.title" dense dense-toggle 
                  :content-inset-level="1.5">                        
                        <div v-for="subItem in item.items" v-bind:key="subItem.title">  
                                <q-item dense :to="subItem.path" :key="subItem.title" clickable v-ripple 
                                active-class="text-primary text-bold">                                   
                                  <q-item-section >
                                      {{subItem.title}}
                                    </q-item-section>
                                </q-item>        
                        </div>
                </q-expansion-item>
             </div>                           
            </q-list>            
          </q-scroll-area>
          <!-- <q-img class="absolute-top" src="https://cdn.quasar-framework.org/img/material.png" style="height: 150px">
            <div class="absolute-bottom bg-transparent">
              <q-avatar size="56px" class="q-mb-sm">
                <img src="https://cdn.quasar-framework.org/img/boy-avatar.png">
              </q-avatar>
              <div class="text-weight-bold">Razvan Stoenescu</div>
              <div>@rstoenescu</div>
            </div>
          </q-img>
        
        <q-item-label>{{email}}</q-item-label>
  

            -->
     </q-drawer>

      <q-page-container>
        <router-view />
      </q-page-container>

    </q-layout>
</template>

<script type="text/javascript">
import store from "../store";

export default {
  props: ["title", "backgroundColor", "subtitle", "items"],
  data() {
    return {
      miniState: true,
      header: true,
      headerReveal: true,
      left: true,
      leftOverlay: false,
      leftBehavior: "default",
      leftBreakpoint: 992,
      scrolling: true,
    };
  },
  computed: {
    email() {
      return this.$store.getters["auth/user"].email;
    }
  },
  methods: {
    _subString(val) {
      return val.substring(0, 1);
    },
    logout() {
      this.$store.dispatch("logout").then(() => {
        this.$router.push({ name: "auth.login" });
      });
    }
  }
};
</script>
<style lang="stylus">
   /*.q-icon 
    color teal*/
</style>
