require "cucumber/rails"

ActionController::Base.allow_rescue = false
Capybara.use_html5_parsing = true

DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation

World(FactoryBot::Syntax::Methods)
