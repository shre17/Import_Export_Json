require 'csv'

namespace :article_task do
  desc "This Task is to import the locations via JSON"
  task import_articles_json: :environment do
      new_article = JSON.parse(File.read('new_article.json'))
      new_article.each do |article|
      Article.create(article.to_h)
    end
 end
desc "This Task is to import the locations via CSV"
  task import_articles_csv: :environment do
    CSV.foreach('new_article.csv', headers: true) do |row|
      Article.create! row.to_hash
    end
  end

  

end
