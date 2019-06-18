
import * as CustomizedComponents from '~/components/custom'

// leave the export, even if you don't use it
export default async ({ app, router, Vue }) => {
  // Globally register the components

  Object.keys(CustomizedComponents).map(v => {
    Vue.component(v, CustomizedComponents[v])
  })
}
