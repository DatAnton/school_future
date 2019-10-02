<template>
  <div class="form-group">
    <label for="exampleFormControlSelect1">Select teacher:</label>
    <select v-model="selectedTeacher"
    class="form-control w-25 p-3" id="exampleFormControlSelect1">
        <option v-for="teacher in teachers" v-bind:value="teacher">
          {{ teacher.first_name }} {{ teacher.last_name }}
        </option>
    </select>
  </div>
</template>

<script>
export default {
  props: {
    subject: {
      default: -1,
    },
    lesson_id: {
      default: -1
    }
  },
  data: function() {
    return {
      teachers: [],
      selectedTeacher: Object
    }
  },
  watch: {
    selectedTeacher: function(teacher) {
      this.$emit('change', teacher);
    },
    subject: async function(subject, old) {
      const _self = this;
      const response = await fetch(`/lessons/get_teachers_of_subject?subject_id=${subject}&lesson_id=${this.lesson_id}`);
      const list = await response.json();

      this.teachers = list;
    }
  },
  methods: {
      selectTeacher() {
        this.$emit('change', this.teacher);
      }
  }
}
</script>

<style lang="css">
</style>
