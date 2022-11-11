// Entry point for the build script in your package.json
import { Turbo } from "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "trix"
import "@rails/actiontext"

import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false