Jinsei::Application.configure do
  config.cache_classes = false
  config.consider_all_requests_local       = true
  # config.action_view.debug_rjs             = false
  # config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.action_mailer.default_url_options = {:host => 'localhost:3000'}
  config.action_mailer.delivery_method = :letter_opener
  # OmniAuth.config.test_mode = true
  config.logger = Logger.new(STDOUT)
  config.active_record.migration_error = :page_load
  # Do not eager load code on boot.
  config.eager_load = false
end