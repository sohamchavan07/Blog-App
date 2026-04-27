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
*Last updated: April 28, 2026*

## 2026-04-28: Comment Enhancements

### 1. User-Comment Association
- **Database Migration**: Added `user_id` to the `comments` table as a mandatory reference.
- **Model Associations**: 
    - Updated `Comment` model with `belongs_to :user`.
    - Verified `User` model has `has_many :comments`.
- **Controller Logic**: 
    - Restricted comment creation to authenticated users using `before_action :authenticate_user!`.
    - Automatically assigned `current_user` to newly created comments.
- **View Updates**: 
    - Displayed the author's name and relative time for each comment.
    - Conditionally rendered the comment form (only shown to logged-in users; others see a "Sign in" prompt).

### 2. Tags & Discovery
- **Tagging System**: 
    - Implemented a many-to-many relationship using `Tag` and `Tagging` models.
    - Added a `tag_list` virtual attribute to the `Post` model for easy comma-separated tag management.
    - Updated post forms to allow tag entry.
- **Search Functionality**: 
    - Added a search bar to the blog index.
    - Implemented text-based search (title/body) and tag-based filtering (using `#tagname`).
    - Optimized queries with `includes(:tags, :user)` to prevent N+1 issues.
- **UI Enhancements**: Added styling for tag "pills" across the application.