# Pagy initializer
# See https://ddnexus.github.io/pagy/docs/api/initializer

# Pagy::DEFAULT[:items] = 10 # items per page
# Pagy::DEFAULT[:size]  = [1, 4, 4, 1] # nav bar links

# Better user experience using the bootstrap extra
require "pagy/extras/bootstrap"
require "pagy/extras/overflow"
require "pagy/extras/headers"

Pagy::DEFAULT[:overflow] = :last_page
