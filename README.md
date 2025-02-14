# Race Management System

A web-based application for managing race results at schools. This system allows teachers to create races, assign students to lanes, record final race results, and view outcomes. The application is built entirely in Ruby on Rails (Ruby 3.4, Rails 7.2) and features dynamic nested forms, custom validations, and an enhanced user interface powered by Bootstrap.

## Table of Contents

- [Features](#features)
- [Architecture and Implementation](#architecture-and-implementation)
- [Getting Started](#getting-started)

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
  - Dynamic form fields for adding extra race entries.

## Architecture and Implementation

The application is structured using standard Rails MVC convention:

- **Models:**
  - **Race:** The primary model that represents a race. It has many associated `RaceEntry` objects. It leverages nested attributes to manage race entries directly from the race forms.
  - **RaceEntry:** Represents individual race entries (student participation). Custom validations ensure that lanes and student names are unique within a race.
  - **Custom Validations:** Implemented in the `Race` model to enforce a minimum number of valid entries, verify finishing positions' consistency when entered, and to check for duplicate lanes and student names among nested race entries. This prevents database-level uniqueness errors before saving.
  
- **Controllers:**
  - **RacesController:** Follows RESTful conventions to handle creating, reading, updating, and deleting races. It also manages nested attributes for race entries.
  
- **Views:**
  - **New Race Form:** Provides a user-friendly form where the first two race entries are mandatory and non-removable. Users can dynamically add more entries using JavaScript.
  - **Error Handling:** Uses a shared partial to display validation errors without breaking the UI.
  - **Enhanced UI:** Built using Bootstrap for a modern and responsive layout. Navigation buttons (Home, Back) are present on all applicable pages.
  
- **JavaScript and UI Enhancements:**
  - The dynamic nested form fields for race entries are handled with vanilla JavaScript. New fields are added or removed without reloading the page.
  - Bootstrap’s CSS and JS are used to ensure a consistent look and feel.

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
