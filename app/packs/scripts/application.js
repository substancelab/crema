/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Make Rails standard helpers (ie data-confirm, data-remote etc) work as
// expected
import Rails from "rails-ujs";
Rails.start();

// Set up Stimulus
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Import and register all TailwindCSS Components
import { Dropdown } from "tailwindcss-stimulus-components"
application.register('dropdown', Dropdown)
