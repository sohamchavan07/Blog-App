🚀 Blog-App
A robust, scalable blogging platform built with Ruby on Rails and PostgreSQL.

• [Ruby](https://www.ruby-lang.org/)
• [Rails](https://rubyonrails.org/)
• [PostgreSQL](https://www.postgresql.org/)
• [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
• [TailwindCSS](https://tailwindcss.com/)
• [React](https://reactjs.org/)
• [Live Demo](https://your-demo-url.com)
• [Portfolio](https://www.sohamchavan.site/)

---

📌 Table of Contents
• [About](#-about)
• [Features](#-features)
• [Tech Stack](#-tech-stack)
• [Getting Started](#-getting-started)
• [Usage](#-usage)
• [Screenshots](#-screenshots)
• [Roadmap](#-roadmap)
• [Contributing](#-contributing)
• [Author](#-author)

---

📖 About
Blog-App is a web app built to solve the need for a seamless and high-performing blogging platform. It is designed for developers, writers, and content creators, and focuses on core values like speed, simplicity, and security with robust API authentication.

---

✨ Features
• ✅ JWT API Authentication — Secure API endpoints with JSON Web Tokens.
• ✅ Service Objects Pattern — Maintainable and scalable business logic.
• ✅ PostgreSQL Database — Reliable and high-performance data storage.
• 🔜 Upcoming: Mobile-responsive polish and richer user interface.

---

🛠️ Tech Stack
• Backend: Ruby on Rails
• Database: PostgreSQL
• Authentication: Devise & JWT

---

🚀 Getting Started
Prerequisites

```text
ruby  >= 3.x
rails >= 8.x
node  >= 18.x
postgresql >= 11
```

Installation

```bash
# 1. Clone the repo
git clone https://github.com/sohamchavan07/Blog-App.git
cd Blog-App
 
# 2. Install dependencies
bundle install
npm install # if using node
 
# 3. Set up environment variables
cp .env.example .env
 
# 4. Set up the database
rails db:create db:migrate db:seed
 
# 5. Start the dev server
bin/dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

---

💡 Usage
```bash
# Example command or workflow
rails generate scaffold Post title:string body:text
rails db:migrate
```

---

📸 Screenshots
*(Add your screenshots here)*

---

🗺️ Roadmap
• MVP — core features live
• Add authentication
• Mobile-responsive polish
• Deploy to production

---

🤝 Contributing
Contributions, issues and feature requests are welcome!

1. Fork the repo
2. Create your branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'feat: add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

👤 Author
Soham Chavan

• [Portfolio](https://www.sohamchavan.site/)
• [LinkedIn](https://www.linkedin.com/in/sohamchavan07/)
• [X](https://x.com/soham_chavan07)

---

📄 License
This project is licensed under the [MIT License](./LICENSE).

---

Made with ❤️ by Soham Chavan
