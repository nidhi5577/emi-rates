require 'csv' 
require 'open-uri' 

class EmiRate < ApplicationRecord

	private

	def self.update_rates_from_dynamic_csv
	  EmiRate.delete_all
	  csv_folder_path = Rails.root.join("public/csv").to_s
      FileUtils.rm_rf(Dir.glob("#{csv_folder_path}/*"))
      csv_path = "https://docs.google.com/spreadsheets/d/e/2PACX-1vSm2-Ya0gtq144zAkExCrkVTXu_T8NfdvdtMJTJrCYRBbTXo_KUsma7N6ULeV0ihs4e15gDc1vUxoSc/pub?gid=0&single=true&output=csv"
      File.write(Rails.root.join("public/csv", "emi_rates.csv").to_s, open(csv_path, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read)
      file = Rails.root.join("public/csv", "emi_rates.csv").to_s
      CSV.foreach(file, :headers => true) do |row|
        new_hash = Hash[row.to_hash.map { |k, v| [k.downcase, v] }]
        EmiRate.create!(new_hash)
      end
	end 
end
