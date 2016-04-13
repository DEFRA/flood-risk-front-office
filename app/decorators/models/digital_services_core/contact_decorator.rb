DigitalServicesCore::Contact.class_eval do

  has_one :enrollment_applied_for, inverse_of: :applicant_contact, class_name: "DigitalServicesCore::Enrollment",
          foreign_key: :applicant_contact_id, dependent: :restrict_with_exception

  has_one :enrollment_contacted, inverse_of: :correspondence_contact, class_name: "DigitalServicesCore::Enrollment",
          foreign_key: :correspondence_contact_id, dependent: :restrict_with_exception

=begin
  # Partnership-organisation is an optional association


  belongs_to :partnership_organisation, inverse_of: :partner_contacts,
             class_name: "WasteExemptionsShared::OrganisationType::Partnership"

  # VALIDATION SECTION

  validate :full_name_presence

  FULL_NAME_REGEX = /\A[\p{Alpha} ,\.'-]+\z/i unless defined? FULL_NAME_REGEX

  validate :full_name_format_of

  # Email is not required for all contact types
  validates :email_address, presence: { message: :blank_applicant },
            email_format: { message: :invalid_applicant_email_address },
            if: :applicant?

  validates :email_address_confirmation, presence: { message: :blank_applicant },
            if: Proc.new { |c| c.applicant? && c.email_address_changed? }

  validates :email_address, presence: true, if: :correspondence?

  after_validation do |c|
    sorter = DigitalServicesCore::SortValidations.new(c)

    # the validations do not come out in right order as per the form
    # for future ref, this may vary depending on the contact_type
    sorter.sort(%i[full_name position
                   business_number.tel_number telephone_number.tel_number
                   addresses.premises addresses.street_address addresses.locality
                   addresses.city addresses.postcode
                   email_address email_address_confirmation])

    if c.applicant?
      if c.errors[:email_address].length > 1
        c.errors.set :email_address, [c.errors[:email_address].last]
      end

      if c.errors[:email_address_confirmation].length > 1
        c.errors.set :email_address_confirmation, [c.errors[:email_address_confirmation].last]
      end
    end
  end

  def self.full_name_max_length
    255
  end

  # This is used in the prepare_data_for_review YAML DSL as we need a helper method on this
  # object get the right formatted output for a contact e.g. when they are a partner.
  # TODO: Move to a presenter at some point as this is presentation code.
  def to_s
    summary = full_name
    summary += ", #{primary_address}" if primary_address.present?
    summary
  end

  private

  def full_name_presence
    return if establishment_or_undertaking?

    if [first_name, last_name].join("").blank?
      error_key =
        case contact_type.try!(:to_sym)
          when :partner then :blank_partner
          when :applicant then :blank_applicant
          else :blank
        end

      errors.add :full_name, error_key
    end
  end

  def full_name_format_of
    return if establishment_or_undertaking?
    return unless errors[:full_name].empty?

    if full_name !~ FULL_NAME_REGEX
      errors.add :full_name, :invalid
    elsif full_name.length > (DigitalServicesCore::Contact.full_name_max_length + 1) # +1 separator
      errors.add :full_name, :"too_long.other", count: DigitalServicesCore::Contact.full_name_max_length
    end

  end
=end
end
