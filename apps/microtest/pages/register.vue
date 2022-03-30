<template>
  <div>
    <!-- Validation Errors -->
    <BreezeValidationErrors :errors="form.errors" class="mb-4" />

    <form @submit.prevent="submit">
      <div>
        <BreezeLabel for="name" value="Name" />
        <BreezeInput
          id="name"
          v-model="form.name"
          type="text"
          class="input mt-1 block w-full"
          required
          autofocus
          autocomplete="name"
        />
      </div>

      <div class="mt-4">
        <BreezeLabel for="email" value="Email" />
        <BreezeInput
          id="email"
          v-model="form.email"
          type="email"
          class="mt-1 block w-full"
          required
          autocomplete="username"
        />
      </div>

      <div class="mt-4">
        <BreezeLabel for="password" value="Password" />
        <BreezeInput
          id="password"
          v-model="form.password"
          type="password"
          class="mt-1 block w-full"
          required
          autocomplete="new-password"
        />
      </div>

      <div class="mt-4">
        <BreezeLabel for="password_confirmation" value="Confirm Password" />
        <BreezeInput
          id="password_confirmation"
          v-model="form.password_confirmation"
          type="password"
          class="mt-1 block w-full"
          required
          autocomplete="new-password"
        />
      </div>

      <div class="flex items-center justify-end mt-4">
        <NuxtLink to="/login" class="underline text-sm text-gray-600 hover:text-gray-900">
          Already registered?
        </NuxtLink>

        <BreezeButton class="ml-4" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
          Register
        </BreezeButton>
      </div>
    </form>
  </div>
</template>

<script>
import BreezeValidationErrors from '@/components/ValidationErrors.vue'
import BreezeButton from '@/components/CButton.vue'
import BreezeInput from '@/components/CInput.vue'
import BreezeLabel from '@/components/CLabel.vue'
export default {

  name: 'RegisterPage',

  components: {
    BreezeValidationErrors,
    BreezeButton,
    BreezeInput,
    BreezeLabel
  },

  layout: 'guest',

  data () {
    return {
      form: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        terms: false,
        processing: false,
        errors: []
      }
    }
  },
  head: {
    title: 'Register'
  },

  methods: {
    async submit () {
      this.processing = true
      this.form.errors = []

      try {
        await this.$axios.get('https://users.microtest.test/sanctum/csrf-cookie')

        await this.$axios.post('https://users.microtest.test/register', this.form)

        await this.$auth.loginWith('laravelSanctum', { data: this.form })
        this.processing = false
      } catch (e) {
        console.log('E:', e)
        // Object.keys(e.response.data.errors).forEach((key) => {
        //   Object.values(e.response.data.errors[key]).forEach((error) => {
        //     this.form.errors.push(error)
        //   })
        // })
      }
    }
  }
}
</script>
