class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show]

  # GET /candidates/1
  def show
    if @candidate
      render json: @candidate.get_percentiles
    else
      render json: {
        error: "Candidate Not Found",
      }, status: 422
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.where(candidate_id: params[:id]).first
    end

    # Only allow a trusted parameter "white list" through.
    def candidate_params
      params.require(:candidate).permit(:candidate_id)
    end
end
