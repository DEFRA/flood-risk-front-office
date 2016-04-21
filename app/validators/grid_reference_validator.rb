# Shareable validation for checking business rules for Grid Reference on a Location
# This can be used in Context dependent situations

  class GridReferenceValidator < SimpleDelegator

    include ActiveModel::Validations

    delegate :site_info, :grid_reference_form, :errors, to: :location

    def initialize(location)
      @location = location
    end

    # rubocop:disable Style/BlockDelimiters
    cattr_accessor :grid_ref_valid_lengths do 12 end
    cattr_accessor :site_info_max_length do 500 end
    cattr_accessor :site_info_min_length do 3 end

    GRID_REFERENCE_REGEX = /\A[a-zA-Z]{2}\d{6,10}\z/i

    # Fire the lengths validation on it's own, and then only for format, if length ok
    validate :grid_reference_lengths

    validates :grid_reference_form,
              format: { with: GridReferenceValidator::GRID_REFERENCE_REGEX },
              if: Proc.new {|location| !location.grid_reference.blank? && location.errors.empty?}

    validates_presence_of :site_info, if: Proc.new {|location| !location.grid_reference.blank?}

    validates_length_of :site_info, minimum: GridReferenceValidator.site_info_min_length, allow_blank: true
    validates_length_of :site_info, maximum: GridReferenceValidator.site_info_max_length, allow_blank: true

    def grid_reference_lengths
      # used to be a number of possible lengths so left for reference incase we go back to that
      #unless grid_ref_valid_lengths.include?(grid_reference.to_s.length)
      unless(grid_ref_valid_lengths == grid_reference.to_s.length)
        Rails.logger.debug"GridReference - INVALID  #{grid_ref_valid_lengths.inspect} != #{grid_reference.to_s.length}"
        @location.errors.add(:grid_reference_form, :length, list: grid_ref_valid_lengths.inspect)
      end unless(grid_reference.blank?)
    end

    private

    attr_reader :location

  end

