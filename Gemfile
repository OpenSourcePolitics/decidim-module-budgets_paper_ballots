# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# Inside the development app, the relative require has to be one level up, as
# the Gemfile is copied to the development_app folder (almost) as is.
base_path = ""
base_path = "../" if File.basename(__dir__) == "development_app"
require_relative "#{base_path}lib/decidim/budgets_paper_ballots/version"

DECIDIM_VERSION = Decidim::BudgetsPaperBallots::DECIDIM_VERSION

gem "decidim", DECIDIM_VERSION
gem "decidim-budgets_paper_ballots", path: "."

gem "bootsnap", "~> 1.4"
gem "puma", ">= 6.3.1"
gem "uglifier", "~> 4.1"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
  gem "rubocop-faker", "~> 1.3",">= 1.3.0"
end

group :development do
  gem "faker", "3.5.3"
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "spring", "~> 4.0"
  gem "spring-watcher-listen", "~> 2.1"
  gem "web-console", "~> 4.2"
end
