<template>
    <div>
    <q-card class="doc-krece-custom q-my-lg" bordered flat>
         <q-toolbar inverted class="text-primary row no-wrap items-center doc-krece-custom__toolbar">  
            <!--<div class="q-toolbar row no-wrap items-center doc-krece-custom__toolbar"> </div> -->
                <section id="krece--In-a-QDialog" class="q-my-sm q-mr-md text-subtitle1">                   
                  <div class="doc-card-title_krece">{{cToolbarLabel}} {{documentId}}</div>
                 </section>  
           
                <q-space></q-space>
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
         </q-toolbar>
        </q-card>
        <!--
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
         
            </div>   -->
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

<style lang="stylus">

.doc-krece-custom__toolbar{
    background:#fff;
    color:#616161
    }
.doc-krece-custom__toolbar>.q-btn{
      color:#757575}

.doc-krece-custom--dark .doc-krece-custom__toolbar{
  background:#212121;
  color:#fff}
.doc-krece-custom--dark .doc-krece-custom__toolbar>.q-btn{
    color:#eee}

.doc-card-title_krece{
    margin-left:-24px;
    padding:2px 10px 2px 24px;
    background:#e0e0e0;
    color:#616161;
    position:relative;
    border-radius:3px 5px 5px 0}
  .doc-card-title_krece:after{
    content:"";
    position:absolute;
    top:100%;
    left:0;
    width:0;
    height:0;
    border:0 solid transparent;
    border-top-color:#bebebe;
    border-width:9px 0 0 11px}
</style>
