class Api::V1::ProductsController < Api::V1::BaseController  
  before_action :authenticate, except: [:index,:show]
  load_and_authorize_resource
  before_action :set_store, only: [:index,:create]
  before_action :set_product, only: [:show, :update, :destroy]
  # GET /products
  def index
    @products = @store.products

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = @store.products.build(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    def set_store
      @store = Store.includes(:products).find(params[:store_id])
    end

    def set_product
      @product = set_store.products.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :price, :store_id)
    end
end
