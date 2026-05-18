# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Removed hardcoded admin credentials to prevent exposure of sensitive data
# User.find_or_create_by!(email: "admin@gmail.com") do |user|
#   user.password = "admin@123"
#   user.password_confirmation = "admin@123"
#   user.full_name = "Admin User"
# end

# Use environment variables or a secure method to create admin users
