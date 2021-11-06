class LowerCamelTransformer < Blueprinter::Transformer
  def transform(hash, _object, _options)
    hash.deep_transform_keys! { |key| key.to_s.camelize(:lower) }
  end
end
