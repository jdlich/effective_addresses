module Effective
  class AddressesController < ApplicationController
    skip_authorization_check if defined?(CanCan)
    respond_to :json

    def subregions
      @subregions = Carmen::Country.coded(params[:country_code]).try(:subregions)

      if @subregions.present?
        render :partial => 'effective/addresses/subregions'
      else
        render :text => "<option value=''>None Available</option>"
      end
    end
  end
end
