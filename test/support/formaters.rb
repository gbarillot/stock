def jsonify(json_as_string)
  out = JSON.parse(json_as_string)

  return out.map(&:deep_symbolize_keys) if out.is_a?(Array)
  return out.deep_symbolize_keys!
end
