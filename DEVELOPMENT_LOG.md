# Development Log - Blog App

This document tracks the major steps, features, and fixes implemented during the development of the Blog App.

## 2026-04-27: Authentication & API Foundation

### 1. Devise Integration & Fixes
- **Gem Setup**: Added `devise` gem to the project.
- **Generator Fixes**: Resolved an issue where the devise generator was not found by properly installing dependencies.
- **Migration Troubleshooting**: 
    - Fixed a `PG::DuplicateColumn` error in the users migration by handling the pre-existing `email` column.
    - Verified and updated the `User` model to include devise modules.
- **Configuration**: Generated devise initializers and set up the default authentication configuration.

### 2. API Development & JWT Authentication
- **JWT Implementation**:
    - Added the `jwt` gem for token-based authentication.
    - Implemented `encode_token` and `decode_token` methods in `ApplicationController`.
    - Added `authorize_request` filter to protect API endpoints, ensuring only valid tokens can access JSON resources.
- **API Versioning**: Established a namespaced structure under `api/v1`.
- **Authentication Endpoint**: 
    - Created `Api::V1::AuthController` with a `login` action to authenticate users and return a JWT.
- **Posts API**: 
    - Created `Api::V1::PostsController` for CRUD operations on blog posts via API.

### 3. Routing Architecture
- **Web Routes**:
    - Set up `resources :posts` with nested `resources :comments`.
    - Configured the application root to `posts#index`.
- **API Routes**:
    - Configured `namespace :api` and `namespace :v1` for clean API endpoint separation.
    - Added `post "/login"` route for user authentication.

### 4. Code Quality & Refactoring
- **Service Objects**: Began refactoring business logic into service objects to keep controllers lean.
- **Linting**: Fixed syntax errors in service objects that were causing RuboCop failures.

### 5. UI/UX Improvements
- **Design Overhaul**: Redesigned the registration and login pages to use a more modern, premium aesthetic (modern typography, glassmorphism-inspired elements, and improved button styles).
- **Responsiveness**: Ensured the UI is fully responsive across different screen sizes.

### 6. Security & Infrastructure
- **Ruby Upgrade**: Upgraded Ruby from 3.2.2 to 3.3.1 to resolve a Brakeman security warning regarding the End-of-Life (EOL) status of Ruby 3.2.
- **CI Fixes**: Updated `Gemfile.lock` with the `x86_64-linux` platform to ensure compatibility with GitHub Actions runners.

---
*Last updated: April 27, 2026*