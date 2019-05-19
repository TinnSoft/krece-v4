<template>
    <div>
        <q-toolbar inverted color="blue-grey-4">
            <q-toolbar-title >
                <div class="mobile-only q-headline">
                    <h5><strong>{{cToolbarLabel}} {{documentId}}</strong></h5>
                </div>                
                <div class="desktop-only q-headline">
                    <b>{{cToolbarLabel}} {{documentId}}</b>
                </div>
            </q-toolbar-title>
            <div class="desktop-only">
                <q-btn rounded dense v-if="showbackButton===true" v-bind:style="styleButton" 
                color="grey" :icon="icon1" flat v-go-back="redirectTo" :label="label1">                 
                </q-btn>
                <q-btn rounded dense v-if="showsaveButton===true" v-bind:style="styleButton" :loading="loading"
                  @click="handleClick" :icon="icon2"  color="positive" :label="label2"> 
                    <span slot="loading">
                      <q-spinner-hourglass class="on-left" />
                      Guardando...
                    </span>
                </q-btn>
            </div>           
        </q-toolbar>
         <div class="mobile-only">
           <q-footer  >
            <q-toolbar inverted color="secondary">
               <q-btn rounded dense no-wrap v-if="showbackButton===true" v-bind:style="styleButton" :label="label1"
                   :icon="icon1" color="grey" flat v-go-back="redirectTo">
                  </q-btn>
                  <q-toolbar-title>                    
                  </q-toolbar-title>

                  <q-btn rounded dense v-if="showsaveButton===true" v-bind:style="styleButton" :label="label2" @click="handleClick" :loading="loading"
                    :icon="icon2"   color="positive" >
                      <span slot="loading">
                        <q-spinner-hourglass class="on-left" />
                        Guardando...
                      </span>
                  </q-btn>
            </q-toolbar>
          </q-footer>

            </div>
        <br>
    </div>
</template>
<script type="text/javascript">

export default {
  data() {
    return {
      styleButton: {
        border: 1,
        padding: 1
      }
    };
  },
  props: {
    toolbarlabel: {},
    documentId: {},
    redirectTo: {},
    label1: {
      default: "REGRESAR"
    },
    icon1: {
      default: "keyboard_arrow_left"
    },
    label2: {
      default: "GUARDAR"
    },
    icon2: {
      default: "check"
    },
    showbackButton: {
      default: true
    },
    showsaveButton: {
      default: true
    },
    loading: {
      default: false
    }
  },
  components: {
  },
  computed: {
    cToolbarLabel() {
        try{
            return this.toolbarlabel.toUpperCase();
        }
        catch(e){
            return null;
        }
      
    }
  },
  methods: {
    handleClick(newVal) {
      this.$emit("click", newVal);
    }
  }
};
</script>
