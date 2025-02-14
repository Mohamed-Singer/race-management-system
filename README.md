# Race Management System

A web-based application for managing race results at schools. This system allows teachers to create races, assign students to lanes, record final race results, and view outcomes. The application is built entirely in Ruby on Rails (Ruby 3.4, Rails 7.2) and features dynamic nested forms, custom validations, and an enhanced user interface powered by Bootstrap.

## Features

- **Race Setup & Management**
  - Create a new race with a human-friendly name.
  - Two mandatory race entries are built by default; these cannot be removed.
  - Dynamically add extra race entries via nested attributes.
  
- **Race Entry Validations**
  - **Minimum Entries:** Each race must have at least two race entries.
  - **Unique Lanes:** Each race entry must have a unique lane within the race.
  - **Unique Student Names:** Each student can be assigned only once per race (validated in a case-insensitive and trimmed manner).
  - **Final Places Consistency:** Final places must form a continuous sequence with proper handling of ties (e.g., `[1, 1, 3]` is valid while `[1, 2, 4]` is invalid).

- **Race Results**
  - Enter and update final race results with enforced validations.
  - Display race details and outcomes in a clean, tabular format.

- **Enhanced User Interface**
  - Responsive UI built with Bootstrap.
  - Clear navigation with Home, Back, and action buttons.
  - Inline error display using a shared error messages partial.

## Getting Started

### Prerequisites

- SQLite3
- Bundler
- Ruby 3.4
- Rails 7.2

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/mohamed-singer/race-management-system.git
   cd race-management-system
   ```
2. **Install Dependencies**
   ```bash
   bundle install
   ```
3. **Database Setup**
   ```bash
    rails db:create
    rails db:migrate
    ```
4. **Run Tests and Coverage**
   ```bash
   bundle exec rspec
   ```
   SimpleCov gem will automatically generate a coverage report in the coverage directory. Open coverage/index.html in your browser to view detailed coverage statistics.

5. **Start the Rails Server**
   ```bash
   rails server
   ```
