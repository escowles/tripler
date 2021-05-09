class PredicatesController < ApplicationController
  before_action :set_vocab
  before_action :set_predicate, only: %i[ show edit update destroy ]

  # GET /predicates or /predicates.json
  def index
    @predicates = @vocab.predicates
  end

  # GET /predicates/1 or /predicates/1.json
  def show
  end

  # GET /predicates/new
  def new
    @predicate = @vocab.predicates.build
  end

  # GET /predicates/1/edit
  def edit
  end

  # POST /predicates or /predicates.json
  def create
    @predicate = @vocab.predicates.build(predicate_params)

    respond_to do |format|
      if @predicate.save
        format.html { redirect_to vocab_path(@vocab), notice: "Predicate was successfully created." }
        format.json { render :show, status: :created, location: @predicate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @predicate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /predicates/1 or /predicates/1.json
  def update
    respond_to do |format|
      if @predicate.update(predicate_params)
        format.html { redirect_to vocab_path(@vocab), notice: "Predicate was successfully updated." }
        format.json { render :show, status: :ok, location: @predicate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @predicate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /predicates/1 or /predicates/1.json
  def destroy
    @predicate.destroy
    respond_to do |format|
      format.html { redirect_to vocab_path(@vocab), notice: "Predicate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_predicate
      @predicate = @vocab.predicates.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def predicate_params
      params.require(:predicate).permit(:name, :vocab_id)
    end

    def set_vocab
      @vocab = Vocab.find(params[:vocab_id])
    end
end
