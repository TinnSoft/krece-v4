const Default = () =>  import ('~/layouts/default').then(m => m.default || m)
const Home = () =>  import ('~/views/home').then(m => m.default || m)
const Login = () =>  import ('~/views/auth/login').then(m => m.default || m)
const Register = () =>  import ('~/views/auth/register').then(m => m.default || m)
const PasswordEmail = () => import('~/views/auth/password/email').then(m => m.default || m)
//const PasswordReset = () => import('~/views/auth/password/reset').then(m => m.default || m)
const NotFound = () =>  import ('~/views/errors/404').then(m => m.default || m)

//Invoice
const InvoiceIndex = () =>  import ('~/views/invoice/index').then(m => m.default || m)
const InvoiceCreateEditClone = () =>  import ('~/views/invoice/form').then(m => m.default || m)
const InvoiceShow = () =>  import ('~/views/invoice/show').then(m => m.default || m)

//Payment in
const InPaymentIndex = () =>  import ('~/views/payment-in/index').then(m => m.default || m)
const InPaymentCreateEditClone = () =>  import ('~/views/payment-in/form').then(m => m.default || m)
const InPaymentShow = () =>  import ('~/views/payment-in/show').then(m => m.default || m)

const BankIndex = () =>  import ('~/views/bank/index').then(m => m.default || m)
const BankShow = () =>  import ('~/views/bank/show').then(m => m.default || m)

const CategoryIndex = () =>  import ('~/views/category/index').then(m => m.default || m)

const InventoryIndex = () =>  import ('~/views/inventory/index').then(m => m.default || m)
const InventoryShow = () =>  import ('~/views/inventory/show').then(m => m.default || m)

const ContactIndex = () =>  import ('~/views/contact/index').then(m => m.default || m)

const SettingsIndex = () =>  import ('~/views/settings/index').then(m => m.default || m)
const SettingsProfile = () =>  import ('~/views/settings/profile').then(m => m.default || m)
const SettingsCompany = () =>  import ('~/views/settings/company').then(m => m.default || m)
const SettingsNumeration = () =>  import ('~/views/settings/numeration').then(m => m.default || m)
const SettingsPaymentTerms = () =>  import ('~/views/settings/payment_terms').then(m => m.default || m)
const SettingsRetention = () =>  import ('~/views/settings/retention').then(m => m.default || m)
const SettingsTaxes = () =>  import ('~/views/settings/taxes').then(m => m.default || m)

export default [
  { path: '/', name: 'home', component: Home},
  { path: '/login',name: 'login', component: Login},
  { path: '/register',name: 'register', component: Register },
  { path: '/password/reset', name: 'password.request', component: PasswordEmail },
  
  { path: '/invoice', name: 'invoice_index', component: InvoiceIndex },
  { path: '/invoice/create', name: 'invoice_form', component: InvoiceCreateEditClone },
  { path: '/invoice/:id/edit', component:InvoiceCreateEditClone, meta: { mode: 'edit' } },
  { path: '/invoice/:id/clone', component: InvoiceCreateEditClone, meta: { mode: 'clone' } },
  { path: '/invoice/:id', name: 'invoice_show', component: InvoiceShow },

  { path: '/payment-in', name: 'inpayment_index', component: InPaymentIndex },
  { path: '/payment-in/create', name: 'inpayment_form', component: InPaymentCreateEditClone },
  { path: '/payment-in/:id/edit', component:InPaymentCreateEditClone, meta: { mode: 'edit' } },
  { path: '/payment-in/:id/clone', component: InPaymentCreateEditClone, meta: { mode: 'clone' } },
  { path: '/payment-in/:id', name: 'inpayment_show', component: InPaymentShow },

  { path: '/bank', name: 'bank_index', component: BankIndex },
  { path: '/bank/:id', name: 'bank_show', component: BankShow },
  { path: '/category', name: 'category_index', component: CategoryIndex },
  
  { path: '/inventory', name: 'inventory_index', component: InventoryIndex },
  { path: '/inventory/:id', name: 'inventory_show', component: InventoryShow },

  { path: '/contact', name: 'contact_index', component: ContactIndex },

  {
    path: '/settings',   
    component: SettingsIndex,
    children: [
      { path: '', redirect: { name: 'settings.company' }},
      { path: 'profile', name: 'settings.profile', component:SettingsProfile},
      { path: 'company', name: 'settings.company', component:SettingsCompany },
      { path: 'numeration', name: 'settings.numeration', component: SettingsNumeration },
      { path: 'payment_terms', name: 'settings.payment_terms', component: SettingsPaymentTerms },
      { path: 'retention', name: 'settings.retention', component: SettingsRetention },
      { path: 'taxes', name: 'settings.taxes', component: SettingsTaxes },
      /*{ path: 'payment_terms', name: 'settings.payment_terms', component: require('../views/settings/payment_terms.vue') },
      { path: 'retention', name: 'settings.retention', component: require('../views/settings/retention.vue') },
      { path: 'taxes', name: 'settings.taxes', component: require('../views/settings/taxes.vue') }*/
    ]
  },

  { path: '*', component: NotFound }
]