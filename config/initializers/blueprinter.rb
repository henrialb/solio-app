require 'oj'
require 'remove_nil_fields_transformer'
require 'lower_camel_transformer'

Blueprinter.configure do |config|
  config.generator = Oj
  config.datetime_format = ->(datetime) { datetime&.iso8601 }
  config.default_transformers = [RemoveNilFieldsTransformer, LowerCamelTransformer]
end
