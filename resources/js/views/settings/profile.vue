<template>
     <q-page padding>
        <q-input v-model="form.name" float-label="*Nombre" />
        <q-input v-model="form.last_name" float-label="Apellido" />
        <q-input v-model="form.email" float-label="*Email" />
        <br>
        <q-btn  icon="save" label="GUARDAR" color="green" @click="update">
        </q-btn>
     </q-page>
</template>

<script>
import store from "../../store";
import kNotify from "../../components/messages/Notify.js";

export default {
  created() {
    try {
      let vm = this;
      vm.$set(vm.$data.form, "id", store.getters["auth/user"].id);
      vm.$set(vm.$data.form, "name", store.getters["auth/user"].name);
      vm.$set(vm.$data.form, "email", store.getters["auth/user"].email);
      vm.$set(vm.$data.form, "last_name", store.getters["auth/user"].last_name);
    } catch (e) {}
  },
  data() {
    return {
      form: {},
      path: "/api/profile/"
    };
  },
  computed: {
    canSave() {
      if (this.form.name) {
        return true;
      }
      return false;
    }
  },
  methods: {
    update() {
      let vm = this;
      axios
        .put(vm.path + vm.form.id, vm.form)
        .then(function(response) {
          if (response.data.updated) {
            kNotify(
              vm,
              "El registro se actualizó satisfactoriamente",
              "positive"
            );
          } else {
          }
        })
        .catch(function(error) {
          kNotify(vm, "No se ha podido actualizar el registro", "negative");
        });
    }
  }
};
</script>
