# Depot App

Based on **Agile Web Development with Rails 7** by Sam Ruby and Dave Thomas (Pragmatic Bookshelf)

> This project follows the exercises in the book. It is a work in progress; currently on **Chapter 13, Task H (page 189)**.

## 📖 About

The Depot App is a simple e‑commerce application built in Rails 7. It demonstrates key Rails concepts including:

- MVC architecture (Models, Views, Controllers)
- RESTful routing and resources
- Active Record associations and validations
- Shopping cart functionality
- Order processing and checkout
- Testing with Minitest

## 🚀 Getting Started

### Prerequisites

- Ruby 3.x
- Rails 7.x
- SQLite3 (default) or PostgreSQL
- Bundler
- Node.js & Yarn (for assets)

### Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/depot-app.git
    cd depot-app
2. Install dependencies:
    ```bash
    bundle install
    yarn install --check-files
3. Setup the database:
    ```bash
    rails db:create db:migrate db:seed
4. Run the test suite:
    ```bash
    rails test
5. Start the Rails server:
    ```bash
    bin/rails server

### 🛠 Current Progress
- Completed through Chapter 12: Order model, payments, and email notifications.
- Now working on Chapter 13, Task H (page 189): Implementing advanced search and filtering of products.
- Remaining: finalize Task H, chapters 14+ (administration UI, security hardening).

### 📝 Notes
- This is a learning project; code may follow the book’s style and conventions.
- Contributions and suggestions welcome—feel free to open issues or pull requests.

### 📚 References
- Agile Web Development with Rails 7 (Pragmatic Bookshelf)
- Official Rails Guides: https://guides.rubyonrails.org
- Ruby Docs: https://ruby-doc.org


**Status: In progress – Chapter 13 Task H (page 189)**
