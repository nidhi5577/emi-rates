class EmiRatesController < ApplicationController

	def index
	  EmiRate.update_rates_from_dynamic_csv
	  emi_on_amount = EmiRate.where(minimum: params[:amount].to_i)
      emi_rates = emi_on_amount.collect{|emi| {bank: emi.lender, tenures:  
      	          emi_on_amount.where(lender: emi.lender).collect{|rate| {months: 
      	          rate.tenure, rate: rate.rate, minimum_amount: rate.minimum} } }}.uniq
      render json: JSON.pretty_generate(emi_rates)
	end

end