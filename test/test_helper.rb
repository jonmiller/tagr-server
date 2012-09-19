ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  setup :log_test, :init_carrierwave_for_tests

  private

  def log_test
    if Rails::logger
      # When I run tests in rake or autotest I see the 
      # same log message multiple times per test for some reason.
      # This guard prevents that.
      unless @already_logged_this_test
        Rails::logger.info "\n\nStarting #{__name__}\n#{'-' * (9 + __name__.length)}\n"
      end
      @already_logged_this_test = true
    end
  end

  def init_carrierwave_for_tests
    if defined?(CarrierWave)
      CarrierWave::Uploader::Base.descendants.each do |klass|
        next if klass.anonymous?
        klass.class_eval do
          def cache_dir
            "#{Rails.root}/test/tmp/uploads/tmp"
          end

          def store_dir
            "#{Rails.root}/test/tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
          end
        end
      end
    end
  end

end
