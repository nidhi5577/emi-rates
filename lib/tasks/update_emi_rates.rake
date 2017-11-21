require 'csv'    

desc "Update rates from a dynamic CSV file"
task :emi_rates => :environment do
  file = Rails.root.join("public", "EMI Rates - Sheet1.csv").to_s
  CSV.foreach(file, :headers => true) do |row|
    new_hash = Hash[row.to_hash.map { |k, v| [k.downcase, v] }]
    EmiRate.create!(new_hash)
  end
end