class ItemsController < ApplicationController
  before_action :set_items,only:[:show]

  def index

    
  end

  
    def new
      @item = Item.new
      # 4.times{@item.item_images.build}
      @images=@item.item_images.build
    end

  
    # 以下全て、formatはjsonのみ
     # 親カテゴリーが選択された後に動くアクション
   def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(id: "#{params[:id]}", ancestry: nil).children
 end

  # 子カテゴリーが選択された後に動くアクション
 def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
 end

 def create
  @item = Item.new(item_params)
  if @item.save
    redirect_to controller: :items, action: :index
  else
    flash[:alert] = '必須事項を入力してください。'
    redirect_to controller: :items, action: :new

  end
end

  def show
    @item=Item.find(params[:id])
    @category=@item.category
    @children=@category.parent
    @parentcategory=@category.parent
    @images = @item.item_images
    @image = @images.first
    # @comment = Comment.new
    # @comments = @product.comments.includes(:user)
  end

  private


  def set_items
    @item = Item.find(params[:id])

  end

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :price, :condition_id,:brand_id,  :deliverycharge_id,:deliveryaddres_id,  :deliveryspend_id, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
