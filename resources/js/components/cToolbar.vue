<template>
    <div>
        <q-toolbar inverted class="text-primary">            
            <q-toolbar-title >
                <div class="mobile-only q-headline">
                    <h5><strong>{{cToolbarLabel}} {{documentId}}</strong></h5>
                </div>                
                <div class="desktop-only q-headline">
                    <b>{{cToolbarLabel}} {{documentId}}</b>
                </div>
            </q-toolbar-title>
            <div class="desktop-only">
                <q-btn rounded v-if="showbackButton===true" v-bind:style="styleButton" 
                  color="grey" :icon="icon1" flat v-go-back="redirectTo" :label="label1">                 
                </q-btn>                
                <q-btn rounded v-if="showsaveButton===true && showDropdown==false" v-bind:style="styleButton" :loading="loading"
                  @click="handleClick" :icon="icon2"  color="primary" :label="label2"> 
                    <span slot="loading">
                      <q-spinner-hourglass class="on-left" />
                      Guardando...
                    </span>
                </q-btn>

                 <q-btn-dropdown rounded v-if="showDropdown==true" outline label="Acciones">
                  <q-list dense>
                    <q-item-label header>Folders</q-item-label>
                    <q-item v-for="n in 3" :key="`x.${n}`" clickable v-close-popup tabindex="0">
                      <q-item-section avatar>
                        <q-avatar icon="folder" color="secondary" text-color="white" ></q-avatar>
                      </q-item-section>
                      <q-item-section>
                        <q-item-label>Photos</q-item-label>
                        <q-item-label caption>February 22, 2016</q-item-label>
                      </q-item-section>
                      <q-item-section side>
                        <q-icon name="info" ></q-icon>
                      </q-item-section>
                    </q-item>
                    <q-separator inset spaced ></q-separator>
                    <q-item-label header>Files</q-item-label>
                    <q-item v-for="n in 3" :key="`y.${n}`" clickable v-close-popup tabindex="0">
                      <q-item-section avatar>
                        <q-avatar icon="assignment" color="primary" text-color="white" ></q-avatar>
                      </q-item-section>
                      <q-item-section>
                        <q-item-label>Vacation</q-item-label>
                        <q-item-label caption>February 22, 2016</q-item-label>
                      </q-item-section>
                      <q-item-section side>
                        <q-icon name="info" ></q-icon>
                      </q-item-section>
                    </q-item>
                  </q-list>
                </q-btn-dropdown>

            </div>           
        </q-toolbar>
         <div class="mobile-only">
           <q-footer  >
            <q-toolbar inverted color="primary">
               <q-btn rounded dense no-wrap v-if="showbackButton===true" v-bind:style="styleButton" :label="label1"
                   :icon="icon1" color="grey" flat v-go-back="redirectTo">
                  </q-btn>
                  <q-toolbar-title>                    
                  </q-toolbar-title>

                  <q-btn rounded dense v-if="showsaveButton===true" v-bind:style="styleButton" :label="label2" @click="handleClick" :loading="loading"
                    :icon="icon2"   color="primary" >
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
      default: "save"
    },
    showDropdown: {
      default: false
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
