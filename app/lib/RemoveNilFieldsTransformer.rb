# frozen_string_literal: true

class RemoveNilFieldsTransformer < Blueprinter::Transformer
  def transform(hash, _object, _options)
    hash.compact!
  end
end
