class ArticlesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    @articles = Article.all
    respond_to do |format| 
     format.html{}
     # format.json{render json: @blogs.to_json}
     format.json{send_data @articles.to_json}
     format.csv{ render text: @articles.to_csv }
      format.xlsx
   end
  end

  def new
    @article = Article.new
  end 

  def create
     @article = Article.new(article_params)

    if @article.save
      flash[:success] = "article added!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end



  def import_json
    data = JSON.parse(File.read(params[:file]))
    data.each do |article|
      Article.create(article.to_h)
    end
    redirect_to articles_path
  end

  def import_csv
    CSV.foreach('new_article.csv', headers: true) do |row|
      Article.create! row.to_hash
    end
    redirect_to articles_path
  end

  # def json_import
  #   Article.import(params[:file])
  #   redirect_to root_url, notice: "JSON data imported!"
  # end

  def export_json
    data = Article.all.to_json
    send_data data, :type => 'application/json; header=present', :disposition => "attachment; filename=new_article.json"
  end
  
  def export_csv
    data = Article.all.to_json
    send_data data, :type => 'application/json; header=present', :disposition => "attachment; filename=new_article.csv"
  end 

  def export_excel
    @article = Article.all#.to_csv
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition']= 'attachment; filename = "new_article.xls"'
    headers['Cache-Control'] = ''
  end

    def article_params
      params.require(:article).permit(:title, :text)
    end
 
#   def new 
#     @article = Article.new
#   end

#   def create
#     respond_to do |format|
#         format.json { render json: @article.errors, status: :unprocessable_entity} 
#   end
# end

  # def index
  # end

end
