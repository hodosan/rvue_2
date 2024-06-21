# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "vue", to: "https://ga.jspm.io/npm:vue@3.4.27/dist/vue.esm-browser.js", preload: true
pin_all_from "app/javascript/components", under: "components", to: "components", preload: false

