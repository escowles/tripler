class ObjsController < ApplicationController
  before_action :set_vocab
  before_action :set_obj, only: %i[ show edit update destroy ]

  # GET /objs or /objs.json
  def index
    @objs = @vocab.objs
  end

  # GET /objs/1 or /objs/1.json
  def show
  end

  # GET /objs/new
  def new
    @obj = @vocab.objs.build
  end

  # GET /objs/1/edit
  def edit
  end

  # POST /objs or /objs.json
  def create
    @obj = @vocab.objs.build(obj_params)

    respond_to do |format|
      if @obj.save
        format.html { redirect_to vocab_path(@vocab), notice: "Obj was successfully created." }
        format.json { render :show, status: :created, location: @obj }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @obj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /objs/1 or /objs/1.json
  def update
    respond_to do |format|
      if @obj.update(obj_params)
        format.html { redirect_to vocab_path(@vocab), notice: "Obj was successfully updated." }
        format.json { render :show, status: :ok, location: @obj }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @obj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /objs/1 or /objs/1.json
  def destroy
    @obj.destroy
    respond_to do |format|
      format.html { redirect_to vocab_path(@vocab), notice: "Obj was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_obj
      @obj = @vocab.objs.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def obj_params
      params.require(:obj).permit(:vocab_id, :name)
    end

    def set_vocab
      @vocab = Vocab.find(params[:vocab_id])
    end
end
