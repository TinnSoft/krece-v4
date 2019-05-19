<template>
    <q-card >       
        <q-chip dense :color="backgroundColor" text-color="white" icon="star">
          Total {{title}}
        </q-chip>
        <q-card class="my-card">
                
                <q-card-section>
                  <div class="text-h6">{{kValue}}</div>                 
                </q-card-section>          
              </q-card>
    </q-card> 

</template>

<script type="text/javascript">

export default {
    props: ['title', 'total', 'backgroundColor', 'iconName', 'subtitle'],
    computed: {
        kValue() {
            return accounting.formatMoney(this.total);
        }
    },
    data() {
        return {
            options: {
                separator: '.'
            }
        }
    }
}
</script>
<style lang="stylus">
  .q-card
    width 300px  
  .bigger
    width 450px
    max-width 90vw
.q-card-section 
    height: 50px   
  @media (max-width $breakpoint-xs-max)
    .q-card
      width 100%   
.my-card
  width 100%
  max-width 250px
</style>