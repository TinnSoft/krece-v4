export default function kNotify(parent,message, msgtype) {
  parent.$q.notify({
      message,
      timeout: 3000,
      type: msgtype
    });
  }