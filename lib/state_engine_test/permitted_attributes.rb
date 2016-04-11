module StateEngineTest
  module PermittedAttributes

    ATTRIBUTES = [
      :address_attributes,
      :contact_attributes,
      :location_attributes,
      :organisation_attributes,
      :phone_number_attributes
    ].freeze

    # Here we can define individual model attributes
    # These can be combined to create complex sets e.g for Controllers
    # processing nested views in :
    #    lib/waste_exemptions/controller_helpers/strong_parameters.rb
    #
    mattr_reader *ATTRIBUTES

    # rubocop:disable Style/ClassVars

    @@address_attributes = [:id, :address_type,
                            :premises, :street_address, :locality, :city,
                            :postcode, :county_province,
                            :county_province_id, :country_iso
    ]

    @@contact_attributes = [:id, :contact_type, :party_id, :title, :suffix,
                            :first_name, :last_name,
                            :date_of_birth, :valid_from, :valid_to, :position,
                            :email_address, :email_address_confirmation,
                            :full_name
    ]

    @@location_attributes = [:id, :grid_reference, :uprn, :lat, :long, :site_info]

    @@organisation_attributes = [:id, :type, :name, :company_number]

    @@phone_number_attributes = [:id, :number_type, :tel_number, :start_date, :end_date, :contact_id]

  end

end
