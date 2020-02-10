class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    if logged_in?
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
    if current_user.id == @picture.user_id
      @picture.image.cache!
    else
      redirect_to pictures_path, notice: 'ほかのユーザーの投稿は編集できません'
    end
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = current_user.pictures.build(picture_params) #現在ログインしているuserのidを、blogのuser_idカラムに挿入する

    respond_to do |format|
      if @picture.save
        PictureMailer.picture_mail(@picture).deliver  ##mailer作成時追記
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params) #現在ログインしているuserのidを、blogのuser_idカラムに挿入する
    render :new if @picture.invalid?
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:image, :content, :image_cache)
  end
end
