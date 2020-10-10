import Axios from 'axios'

const STORAGE_KEY = 'input_token'

export const fetchUser = async () => {
  let token = window.localStorage.getItem(STORAGE_KEY)

  if (!token) {
    token = (await Axios.post('/api/users', { role: 'interface' })).data.token
    if (!token) return

    window.localStorage.setItem(STORAGE_KEY, token)
  }

  return token
}
