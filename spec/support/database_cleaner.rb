RSpec.configure do |config|
  #It runs before the entire test suite runs and it clears the test database. 
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  
  # itsets the default database cleaning strategy to be transactions. 
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  
  #Tests which is flagged as :js => true by default, these tests using Capybara 
  # using Capybaras test server and firing an actual browser window via the Selenium 
  # backend. For these types of tests, our previous transactions won’t work, so we need to override
  # the setting and chooses the “truncation” strategy instead.
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end


# Now we need to start and end database cleaner.
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end