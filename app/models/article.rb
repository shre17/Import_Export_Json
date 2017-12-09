require 'csv'
class Article < ApplicationRecord

   def as_json(options = nil)
    super({ only: [:title, :text] }.merge(options || {}))
  end

  def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
          Article.create! row.to_hash
        end
      end

  def self.json_import(file)
        json_file = file.read
        new_article = JSON.parse(json_file)
        new_article.each do |article|
          Article.create(article.to_h)
        end
     end

       def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |article|
        csv << article.attributes.values_at(*column_names)
      end
    end
  end

end
