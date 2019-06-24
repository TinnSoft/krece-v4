<template>
    <blockquote :class="customClass">   
        <div v-html="textToShow"></div>   
    </blockquote>
</template>
<script type="text/javascript">
export default {
  name:'kBlockQuote',
  props: ["textToShow","customClass"],
};
</script>
<style lang="stylus">
      
        .doc-token
            background:#d8d8d8
            color:#424242
        .doc-note
          background-color:#eee
          border-radius:4px
          margin:16px 0
          padding:16px 24px
          font-size:1em
          border-width:0 5px 0
          border-style:solid
          border-color:#9e9e9e
          letter-spacing:.5px
        .doc-note .doc-token
          color:#424242
        .doc-note>p
          margin-bottom:0
        .doc-note--tip
          background-color:#c1f4cd
          border-color:#21ba45
        .doc-note--tip .doc-token
          background:#90eba5
        .doc-note--tip .doc-link
          color:#15792d
        .doc-note--warning
          background-color:#f9e09b
          border-color:#f2c037
        .doc-note--warning .doc-token
          background:#f4c955
        .doc-note--warning .doc-link
          color:#99730a
        .doc-note--danger
          background-color:#ffc0c6
          border-color:#c10015
        .doc-note--danger .doc-token
          background:#ff909c
        .doc-note--danger .doc-link
          color:#910010
        .doc-note__title
          font-weight:500
</style>
