<template>
  <q-page padding class="row justify-center">
  
    <div style="width: 400px; max-width: 90vw;">
      <form  @keydown="form.errors.clear($event.target.name)">
        <q-list>
          <q-item-label>REGISTRA UNA NUEVA CUENTA</q-item-label>
  
          <q-item>
            <q-item-label>
              <q-input v-model="form.email" type="email" :error="form.errors.has('email')" float-label="*Tu correo" clearable />
            </q-item-label>
          </q-item>
          <q-item>
            <q-item-label>
              <q-input v-model="form.name" type="text" :error="form.errors.has('name')" float-label="*Nombre de tu negocio" clearable />
            </q-item-label>
          </q-item>
          <q-item>
            <q-item-label>
              <q-input v-model="form.password" type="password" :error="form.errors.has('password')" float-label="*Tu Contraseña" />
            </q-item-label>
          </q-item>
          <q-item>
            <q-item-label>
              <q-input v-model="form.password_confirmation" type="password" :error="form.errors.has('password')" float-label="*Confirma Tu Contraseña" />
            </q-item-label>
          </q-item>
          <q-item>
            <q-item-label>
              <q-btn glossy @click="register" rounded color="secondary" class="full-width">Empezar</q-btn>
            </q-item-label>
          </q-item>
  
          <q-item>
            <q-item-label>
              <small> Ya tienes una cuenta?
                <router-link :to="{ name: 'login' }" active-class="active">
                  <a>Ingresa AQUÏ</a>
                </router-link>
              </small>
            </q-item-label>
          </q-item>
          
  
        </q-list>
        <q-banner v-if="form.errors.has('email')" color="red" icon="warning" enter="bounceInRight" leave="bounceOutLeft" appear dismissible>
          Los campos marcados en rojo son obligatorios...
        </q-banner>
      </form>
  
    </div>
  </q-page>
</template>

<script>
import Form from 'vform'

import {
   QLayout, QIcon, QToolbarTitle, QToolbar, QInput, 
  QList, QBtn, QListHeader, QItem, QItemMain, QItemSide, QField, QAlert
} from "Quasar";

export default {
  middleware: 'guest',
   components: {
     QLayout, QIcon, QToolbarTitle, QToolbar, QInput,
  QList, QBtn, QListHeader, QItem, QItemMain, QItemSide, QField, QAlert
  },
  metaInfo () {
    return { title: this.$t('register') }
  },
  data: () => ({
    form: new Form({
      name: '',
      email: '',
      password: '',
      password_confirmation: ''
    })
  }),
  methods: {
    async register () {
      // Register the user.
      const { data } = await this.form.post('/api/register')
      // Log in the user.
      const { data: { token } } = await this.form.post('/api/login')
      // Save the token.
      this.$store.dispatch('auth/saveToken', { token })
      // Update the user.
      await this.$store.dispatch('auth/updateUser', { user: data })
      // Redirect home.
      this.$router.push({ name: 'home' })
    }
  }
}
</script>