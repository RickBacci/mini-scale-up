class LoanRequestsController < ApplicationController
  before_action :set_loan_request, only: [:update, :show, :edit]

  def index
    @loan_requests = LoanRequest.page params[:page]
  end

  def create
    loan_request = current_user.loan_requests.new(loan_request_params)

    if loan_request.save
      flash[:notice] = "Loan Request Created"
      redirect_to(:back)
    else
      flash[:error] = loan_request.errors.full_messages.to_sentence
      redirect_to(:back)
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @loan_request.update(loan_request_params)
        format.html { redirect_to loan_request_path(@loan_request), notice: 'Loan Request Updated' }
        format.json { render :show, status: :ok, location: @loan_request }
      else
        format.html { render "loan_requests/_edit", notice: "#{@loan_request.errors.full_messages.to_sentence}" }
        format.json { render json: @loan_request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def loan_request_params
    params.require(:loan_request).permit(:title,
                                         :description,
                                         :requested_by_date,
                                         :image_url,
                                         :repayment_begin_date,
                                         :repayment_rate,
                                         :amount,
                                         :category)
  end

  def set_loan_request
    @loan_request = LoanRequest.find(params[:id])
  end
end
