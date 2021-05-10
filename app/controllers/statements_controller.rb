class StatementsController < ApplicationController
  before_action :set_subject
  before_action :set_statement, only: %i[ show edit update destroy ]

  # GET /statements or /statements.json
  def index
    @statements = @subject.statements
  end

  # GET /statements/1 or /statements/1.json
  def show
  end

  # GET /statements/new
  def new
    @statement = @subject.statements.build
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements or /statements.json
  def create
    @statement = @subject.statements.build(statement_params)

    respond_to do |format|
      if @statement.save
        format.html { redirect_to subject_path(@subject), notice: "Statement was successfully created." }
        format.json { render :show, status: :created, location: @statement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statements/1 or /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to subject_path(@subject), notice: "Statement was successfully updated." }
        format.json { render :show, status: :ok, location: @statement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1 or /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to subject_path(@subject), notice: "Statement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = @subject.statements.find(params[:id])
    end

    # strip literal if there is a non-literal object
    def statement_params
      return raw_params.except(:literal) if non_literal?
      raw_params
    end

    # Only allow a list of trusted parameters through.
    def raw_params
      @raw_params ||= params.require(:statement).permit(:subject_id, :predicate_id, :literal, :obj_id, :resource_object_id)
    end

    def non_literal?
      raw_params[:obj_id].present? || raw_params[:resource_object_id].present?
    end

    def set_subject
      @subject = Subject.find(params[:subject_id])
    end
end
