export const state = () => ({
  userAuth: null,
})

export const mutations = {
  setToken(state, userAuth) {
    state.userAuth = userAuth
  },
}

export const actions = {
  setInfo({ commit }, userAuth) {
    commit('setToken', userAuth)
  },
  deleteInfo({ commit }) {
    commit('setToken', null)
  },
}
