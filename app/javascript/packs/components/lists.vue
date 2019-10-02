<template>
  <div class="text-center">
    <list-subjects v-on:change="selectSubject" :old_subj_id="curr_subject_id"></list-subjects>
    <br>
    <list-teachers v-on:change="selectTeacher" :lesson_id="lesson_id" v-bind:subject="selection.subject_id"></list-teachers>
    <br>
    <button type="button" name="button" class="btn btn-primary" style="margin: 20px"
      @click="saveChanges">Save</button>
  </div>
</template>

<script>
import ListTeachers from './list_teachers';
import ListSubjects from './list_subjects';

export default {
  props: ["curr_subject_id", "lesson_id", "form_id"],
  components: { ListTeachers, ListSubjects },
  methods: {
    selectSubject(subject) {
      this.selection.subject_id = subject;
    },
    selectTeacher(teacher) {
      this.selection.user_id = teacher.id;
    },
    saveChanges(){
      var self = this;
      fetch(`/lessons/${this.lesson_id}`, {
        method: 'PUT',
        body: JSON.stringify(self.selection),
        headers:{
          'Content-Type': 'application/json'
        }
      }).then(res => res.json())
      .then(response => console.log('OK:', JSON.stringify(response)))
      .catch(error => console.error('Error:', error));
      window.location.href = `/lessons/index?form_id=${this.form_id}`;
    }
  },
  mounted: function() {
    this.selectSubject(this.curr_subject_id);
  },
  data() {
    return {
      selection: {
        subject_id: -1,
         user_id: -1
       }
    };
  }
}
</script>

<style lang="css">
</style>
