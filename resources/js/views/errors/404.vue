<template>
   <q-page padding class="row justify-center">

    <div style="width: 400px; max-width: 90vw;">

         <q-card inline>
          <q-card-section>
            <q-icon slot="right" size="42px" name="sentiment_dissatisfied" />
          </q-card-section>
          <q-card>
          <div class="q-mb-md" :class="[`q-display-1`, `q-display-1-opacity`]">{{ $t('page_not_found') }}</div>   
          </q-card>
          <q-card-separator />
          <q-card-actions>
            <q-btn flat color="secondary" :to="{ name: 'home' }" label="Ir al inicio"/>
          </q-card-actions>
        </q-card>

  
    </div>
   </q-page>
</template>

<script>
export default {
  name: "NotFound"
};
</script>