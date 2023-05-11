# frozen_string_literal: true

Dir[Rails.root.join('db/seeds/*.json')].each do |path|
  File.open(path) do |file|
    base = File.basename(path, '.json')
    classes = /(\d+)_(.+)/.match(base)[2]
    objs = JSON.load(file)[classes]

    klass = classes.singularize.camelize.constantize
    klass.upsert_all(objs)
  end
end
