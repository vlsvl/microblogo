<template>
  <div>
    <!-- Validation Errors -->
    <BreezeValidationErrors :errors="form.errors" class="mb-4" />

    <form @submit.prevent="submit">
      <div>
        <BreezeLabel for="email" value="Email" />
        <BreezeInput
          id="email"
          v-model="form.email"
          type="email"
          class="mt-1 block w-full"
          required
          autofocus
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
          autocomplete="current-password"
        />
      </div>

      <div class="block mt-4">
        <label class="flex items-center">
          <BreezeCheckbox name="remember" :checked="form.remember" />
          <span class="ml-2 text-sm text-gray-600">Remember me</span>
        </label>
      </div>

      <div class="flex items-center justify-end mt-4">
        <NuxtLink to="/forgot-password" class="underline text-sm text-gray-600 hover:text-gray-900">
          Forgot your password?
        </NuxtLink>

        <BreezeButton class="ml-4" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
          Log in
        </BreezeButton>
      </div>
    </form>
  </div>
</template>

<script>
import BreezeValidationErrors from '@/components/ValidationErrors.vue'
import BreezeCheckbox from '@/components/CCheckbox.vue'
import BreezeButton from '@/components/CButton.vue'
import BreezeInput from '@/components/CInput.vue'
import BreezeLabel from '@/components/CLabel.vue'
export default {

  name: 'LoginPage',

  components: {
    BreezeValidationErrors,
    BreezeCheckbox,
    BreezeButton,
    BreezeInput,
    BreezeLabel
  },

  layout: 'guest',

  data () {
    return {
      form: {
        email: '',
        password: '',
        remember: false,
        processing: false,
        errors: []
      }
    }
  },
  head: {
    title: 'Login'
  },

  methods: {
    async submit () {
      this.processing = true
      this.form.errors = []

      try {
        // await this.$axios.get('https://users.microtest.test/sanctum/csrf-cookie')
        // await this.$axios.post('https://users.microtest.test/login', this.form)
        await this.$auth.loginWith('laravelSanctum', { data: this.form })

        this.processing = false
      } catch (e) {
        Object.keys(e.response.data.errors).forEach((key) => {
          Object.values(e.response.data.errors[key]).forEach((error) => {
            this.form.errors.push(error)
          })
        })
      }
    }
  }
}
</script>
