<template>
    <q-card class="doc-krece-custom q-my-lg" bordered flat>
         <q-toolbar inverted class="text-primary row no-wrap items-center doc-krece-custom__toolbar">  
                <section id="krece--In-a-QDialog" class="q-my-sm q-mr-md text-subtitle1">                   
                  <div class="doc-card-title_krece">{{kToolbarLabel}}</div>
                 </section>             
                <q-space></q-space>           
         </q-toolbar>
        </q-card>     
</template>
<script type="text/javascript">

export default {
  name:'kToolbarCustom',
  data() {
    return {
    };
  },
  props: {
    label: {},   
  },
  computed: {
    kToolbarLabel() {
        try{
            return this.label.toUpperCase();
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
