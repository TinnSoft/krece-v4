<template>
  <q-card class="doc-krece-custom q-my-lg" bordered flat>
    <q-toolbar inverted class="text-primary row no-wrap items-center doc-krece-custom__toolbar">
      <section id="krece--In-a-QDialog" class="q-my-sm q-mr-md text-subtitle1">
        <div class="doc-card-title_krece">{{kToolbarLabel}}</div>
      </section>
      <q-space></q-space>

      <template v-if="showDropdown==true">
        <q-btn-dropdown rounded flat label="Acciones">
          <q-list dense>
            <q-item clickable v-close-popup @click.native="objectVM.edit()">
              <q-item-section avatar>
                <q-avatar size="24px" icon="edit" color="grey-6" text-color="white"></q-avatar>
              </q-item-section>
              <q-item-section>
                <q-item-label>
                  <q-item-label>Editar</q-item-label>
                </q-item-label>
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup @click.native="objectVM.clone()">
              <q-item-section avatar>
                <q-avatar size="24px" icon="content_copy" color="grey-6" text-color="white"></q-avatar>
              </q-item-section>
              <q-item-section>
                <q-item-label>
                  <q-item-label>Clonar</q-item-label>
                </q-item-label>
              </q-item-section>
            </q-item>

            <q-separator inset spaced></q-separator>

            <q-item clickable v-close-popup @click.native="objectVM.pdf()">
              <q-item-section avatar>
                <q-avatar size="24px" icon="print" color="grey-6" text-color="white"></q-avatar>
              </q-item-section>
              <q-item-section>
                <q-item-label>
                  <q-item-label>Imprimir</q-item-label>
                </q-item-label>
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup @click.native="objectVM.email(objectVM.$refs)">
              <q-item-section avatar>
                <q-avatar size="24px" icon="mail" color="orange" text-color="white"></q-avatar>
              </q-item-section>
              <q-item-section>
                <q-item-label>
                  <q-item-label>Enviar por Correo</q-item-label>
                </q-item-label>
              </q-item-section>
            </q-item>

            <!--
            <q-item link>
              <q-item-section
                inverted
                :icon="data.status_id === 1 ? 'lock_outline' : 'lock_open'"
                color="grey-6"
              />
              <q-item-label :label="data.status_id === 1 ? 'Anular' : 'Habilitar'"/>
              <q-item-section right>
                <cToggle @blur="lockUnlock(data)" :id="data.status_id"></cToggle>
              </q-item-section>
            </q-item>-->
          </q-list>
        </q-btn-dropdown>
      </template>
    </q-toolbar>
  </q-card>
</template>
<script type="text/javascript">
export default {
  name: "kToolbarCustom",
  props: {
    objectVM: {},
    showDropdown: { default: false },
    label: {}
  },
  data() {
    return {};
  },
  computed: {
    kToolbarLabel() {
      try {
        return this.label.toUpperCase();
      } catch (e) {
        return null;
      }
    }
  },
  methods: {
    handleClick(newVal) {
      this.$emit("click", newVal);
    }
  }
};
</script>

<style lang="stylus">
.doc-krece-custom__toolbar {
  background: #fff;
  color: #616161;
}

.doc-krece-custom__toolbar>.q-btn {
  color: #757575;
}

.doc-krece-custom--dark .doc-krece-custom__toolbar {
  background: #212121;
  color: #fff;
}

.doc-krece-custom--dark .doc-krece-custom__toolbar>.q-btn {
  color: #eee;
}

.doc-card-title_krece {
  margin-left: -24px;
  padding: 2px 10px 2px 24px;
  background: blue; // #e0e0e0;
  color: #ffffff; // #616161;
  position: relative;
  border-radius: 3px 5px 5px 0;
}

.doc-card-title_krece:after {
  content: '';
  position: absolute;
  top: 100%;
  left: 0;
  width: 0;
  height: 0;
  border: 0 solid transparent;
  border-top-color: #bebebe;
  border-width: 9px 0 0 11px;
}
</style>
