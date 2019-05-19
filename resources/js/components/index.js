import Vue from 'vue'
import { HasError, AlertError, AlertSuccess } from 'vform'

// Components that are registered globaly.
[  
  HasError,
  AlertError,
  AlertSuccess
].forEach(Component => {
  Vue.component(Component.name, Component)
})