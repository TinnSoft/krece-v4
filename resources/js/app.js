import Vue from 'vue'
require('./bootstrap');

import Quasar from 'Quasar'
import i18nLang from 'i18nLang'
import iePolyfill from 'iePolyfill'
require(`QuasarCss`)

//console.log(Quasar)
moment.locale("es");

import store from '~/store'
import router from '~/router'
import i18n from '~/plugins/i18n'
import App from '~/components/App'

import '~/plugins'
import '~/components'

Vue.config.productionTip = false
/* eslint-disable no-new */
Quasar.lang.set(i18nLang)
//Quasar.icons.set(Quasar.iconSet.fontawesomeV5)

Vue.use(Quasar) 
Vue.use(iePolyfill) 

new Vue({
  el: '#q-app',
  i18n,
  store,
  router,
  ...App  
})