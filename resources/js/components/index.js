import Vue from 'vue'
import { HasError, AlertError, AlertSuccess } from 'vform'
import kSelectFilter from './kSelectFilter.vue'
import kToolbar from './kToolbar.vue'
import kToolbarCustom from './kToolbarCustom.vue'
import kBlockQuote from './kBlockQuote.vue'
import kAttachFiles from './kAttachFiles.vue'
import kSendEmailForm from './kSendEmailForm.vue'
import kStatus from './kStatus.vue'
import kCard from './kCard.vue'
import kDateTime from './kDateTime.vue'
import kCurrencyInput from './kCurrencyInput.vue'

// Components that are registered globaly.
[  
  kCard,
  HasError,
  AlertError,
  AlertSuccess,
  kSelectFilter,
  kToolbar,
  kToolbarCustom,
  kBlockQuote,
  kAttachFiles,
  kSendEmailForm,
  kStatus,
  kDateTime,
  kCurrencyInput
].forEach(Component => {
  Vue.component(Component.name, Component)
})

