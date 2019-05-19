<template>

<div class="layout-padding row justify-center">
  
    <div style="width: 400px; max-width: 90vw;">
      <form @submit.prevent="send" @keydown="form.errors.clear($event.target.name)">
        <q-list>
          <q-item-label>RECUPERAR CONTRASEÑA</q-item-label>
  
          <q-item>
            <q-item-label>
              <q-input v-model="form.email" type="email" :error="form.errors.has('email')" float-label="Tu correo" clearable />
            </q-item-label>
          </q-item>
        
          <q-item>
            <q-item-label>
              <q-btn color="secondary" class="full-width">ENVIAR LINK</q-btn>
            </q-item-label>
          </q-item>
  
          <q-item>
            <q-item-label>
              <small> 
                <router-link :to="{ name: 'auth.login' }" active-class="active">
                  <a>Cancelar</a>
                </router-link>
              </small>
            </q-item-label>
          </q-item>
          
  
        </q-list>
        <q-banner v-if="form.errors.has('email')" color="red" icon="warning" enter="bounceInRight" leave="bounceOutLeft" appear dismissible>
          Porfavor revise la información ingresada
        </q-banner>
      </form>
  
    </div>
  </div>

</template>

<script>
import Form from 'vform'

import { required, email } from 'vuelidate/lib/validators'

export default {
  metaInfo: { titleTemplate: 'Reset Password | %s' },

  data: () => ({
    status: null,
    form: new Form({ email: '' })
  }),
  validations: {
    email: { required, email }
  },
  methods: {
    send() {
      this.form.post('/api/password/email')
        .then(({ data: { status } }) => {
          this.form.reset()
          this.status = status
        })
    }
  }
}
</script>
