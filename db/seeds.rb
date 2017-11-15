require 'CSV'

company_file = File.join(Rails.root, 'files/score-companies.csv')
company_data = CSV.read(company_file)
headers = company_data.shift.map {|i| i.to_s }
string_data = company_data.map {|row| row.map {|cell| cell.to_s } }
company_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }

candidate_file = File.join(Rails.root, 'files/score-records.csv')
candidates = CSV.read(candidate_file)
candidates.shift
candidates.each do |candidate|
  fractal_index = company_hashes.select {|company| company['company_id'].to_i == candidate[4].to_i}
  Candidate.create(candidate_id: candidate[0], communication_score: candidate[1], coding_score: candidate[2], title: candidate[3], company_id: candidate[4], fractal_index: fractal_index[0]['fractal_index'].to_f)
end
