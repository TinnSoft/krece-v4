const path = require('path')
const fs = require('fs-extra')
const mix = require('laravel-mix')
require('laravel-mix-versionhash')

// const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer')

//mix.config.vue.esModule = true
mix
  .js('resources/js/app.js', 'public/js')
  .sass('resources/sass/app.scss', 'public/css')
  .sourceMaps()
  .disableNotifications()

if (mix.inProduction()) {
  //version()
  mix
  .versionHash()

  extract([
    'vue',
    'vform',
    'axios',
    'vuex',
    'jquery',
    'popper.js',
    'vue-i18n',
    'vue-meta',
    'js-cookie',
    'bootstrap',
    'vue-router',
    'sweetalert2',
    'vuex-router-sync',
    'Quasar'
  ])
}else {
  mix.sourceMaps()
}

mix.webpackConfig({
  plugins: [
    // new BundleAnalyzerPlugin()
  ],
  resolve: {
    extensions: ['.js', '.json', '.vue'],
    alias: {
      '~': path.join(__dirname, './resources/js'),
      'Quasar': path.join(__dirname, './node_modules/quasar/dist/quasar.umd.min.js'),
      'iePolyfill': path.join(__dirname, './node_modules/quasar/dist/quasar.ie.polyfills.umd.min.js'),
      'i18nLang': path.join(__dirname, './node_modules/quasar/dist/lang/es.umd.min.js'),
      'QuasarCss': path.join(__dirname, './node_modules/quasar/dist/quasar.min.css')
    }
  },
  output: {
   // chunkFilename: 'js/[name].[chunkhash].js',
   chunkFilename: 'js/[name].js',
   publicPath: '/'
   // publicPath: mix.config.hmr ? '//localhost:8080' : '/'
  }
})
/*mix.then(() => {
  if (!mix.config.hmr) {
    process.nextTick(() => publishAseets())
  }
})*/

function publishAseets () {
  const publicDir = path.resolve(__dirname, './public')

  if (mix.inProduction()) {
    fs.removeSync(path.join(publicDir, 'dist'))
  }

  fs.copySync(path.join(publicDir, 'build', 'dist'), path.join(publicDir, 'dist'))
  fs.removeSync(path.join(publicDir, 'build'))
}