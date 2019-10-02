<template>
  <div class="form-group">
    <label for="exampleFormControlSelect1">Select subject:</label>
    <select v-on:change="changeSubject" v-model="selectedSubject"
      class="form-control w-25 p-3" id="exampleFormControlSelect1">
      <option v-for="subject in subjects" v-bind:value="subject.id"> {{ subject.name }} </option>
    </select>
  </div>
</template>

<script>
export default {
  props: ['old_subj_id'],
  data: function(){
    return {
      subjects: [],
      selectedSubject: this.old_subj_id
    }
  },
  mounted: async function() {
    const response = await fetch('/subjects');
    const subjects = await response.json();

    this.subjects = subjects;
  },

  methods: {
    changeSubject: function() {
      this.$emit('change', this.selectedSubject);
      }
  }
}
</script>

<style lang="css">
</style>
