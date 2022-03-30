<template>
  <div>
    <h2 class="text-3xl">
      Home page
    </h2>
    <div v-for="(user, id) in users" :key="id">
      {{ user.name }}
    </div>
  </div>
  <!-- <Tutorial /> -->
</template>

<script>
export default {
  name: 'IndexPage',
  data () {
    return {
      users: Array
    }
  },
  mounted () {
    this.fillUsers()
  },
  methods: {
    fillUsers () {
      this.$axios.$get('https://users.microtest.test/api/users')
        .then((users) => {
          this.users = users
        })
    }
  }
}
</script>
