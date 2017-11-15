class Candidate < ApplicationRecord
  def get_percentiles
    list = Candidate.find_by_sql(["SELECT * FROM candidates WHERE fractal_index > ? AND fractal_index < ? AND title = ?", self.fractal_index - 0.15, self.fractal_index + 0.15, self.title])
    comm_score_list = list.sort_by { |val| val["communication_score"] }
    comm_score_position = comm_score_list.index {|h| h[:candidate_id] == self.candidate_id }
    code_score_list = list.sort_by { |val| val["coding_score"] }
    code_score_position = code_score_list.index {|h| h[:candidate_id] == self.candidate_id }
    comm_score_percentile = (((comm_score_position.to_f + 1) / comm_score_list.count) * 100).ceil
    code_score_percentile = (((code_score_position.to_f + 1)  / code_score_list.count) * 100).ceil
    return {candidate_id: self.candidate_id, company_id: company_id, code_score_percentile: code_score_percentile, comm_score_percentile: comm_score_percentile, title: self.title}
  end
end
