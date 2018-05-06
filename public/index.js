/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Coins list",
      coins: [],
      favorites: [],
      currentFavorite: {
        coin_name: "",
        coin_api_id: "",
        notes: ""
      }
    };
  },
  created: function() {
    axios.get("/v1/coins").then(
      function(response) {
        this.coins = response.data;
        console.log("the coins", this.coins);
      }.bind(this)
    );
    axios.get("/v1/favorites").then(
      function(response) {
        this.favorites = response.data;
        console.log(this.favorites);
      }.bind(this)
    );
  },
  methods: {
    createFavorite: function(coin) {
      var params = {
        coin_name: coin.name,
        coin_api_id: coin.symbol
      };
      console.log("the params are", params);
      axios
        .post("/v1/favorites", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
      // axios.post to "/v1/favorites"
      // send params {coin_name: ..., coin_api_id: ...}
    }
  },
  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      first_name: "",
      last_name: "",
      email: "",
      phone_number: "",
      password: "",
      password_confirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
        last_name: this.last_name,
        email: this.email,
        phone_number: this.phone_number,
        password: this.password,
        password_confirmation: this.password_confirmation
      };
      axios
        .post("/v1/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var FavoritesPage = {
  template: "#favorite-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      favorites: [],
      currentFavorite: {
        name: "",
        symbol: ""
      }
    };
  },
  created: function() {
    axios.get("/v1/favorites").then(
      function(response) {
        this.favorites = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/favorites/new", component: FavoritesPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
